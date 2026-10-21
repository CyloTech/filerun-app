#!/bin/bash
set -x

if [ ! -f /etc/filerun_installed ]; then
    # /etc/filerun_installed lives in the container layer, so every new
    # container (including the one an app update creates) runs this block.
    # When the persistent volumes already hold a FileRun installation, keep
    # its files, database, users and settings and only redo the per-container
    # setup.
    existing_install=false
    if [ -f /home/appbox/public_html/dav.php ] && [ -f /home/appbox/public_html/system/data/autoconfig.php ]; then
        existing_install=true
        echo "Existing FileRun installation found; keeping its files, database and settings"
    fi

    echo "Setting up Ioncube loaders"
    mv /ioncube.tar.gz/ioncube/ioncube_loader_lin_7.4* /usr/lib/php/20190902

    echo "zend_extension = \"/usr/lib/php/20190902/ioncube_loader_lin_7.4.so\"" > /etc/php/7.4/fpm/conf.d/00-ioncube.ini
    echo "zend_extension = \"/usr/lib/php/20190902/ioncube_loader_lin_7.4.so\"" > /etc/php/7.4/cli/conf.d/00-ioncube.ini
    rm -fr /ioncube.tar.gz

    echo "Adding Filerun php config"
    mv /00-filerun.ini /etc/php/7.4/fpm/conf.d/00-filerun.ini

    mkdir -p /home/appbox/trash
    mkdir -p /home/appbox/thumbnails

    if [ "$existing_install" != true ]; then
    rm -fr /home/appbox/public_html/*

    echo "Downloading Filerun"
    cd /home/appbox/public_html
    unzip /FileRun.zip

cat << EOF > /home/appbox/public_html/system/data/autoconfig.php
<?php
\$config['db'] = array (
  'type' => NULL,
  'server' => 'localhost',
  'database' => '${DB_NAME}',
  'username' => 'root',
  'password' => '${MYSQL_ROOT_PASSWORD}',
);
EOF

cat << EOF > /home/appbox/public_html/customizables/config.php
<?php
\$config['path']['trash'] = '/home/appbox/trash';
\$config['path']['thumbnail_cache'] = '/home/appbox/thumbnails';
EOF
    fi
    rm -fr /FileRun.zip

    rm -fr /home/appbox/config/nginx/sites-enabled/default-site.conf

    chown -R appbox:appbox /run/mysqld

    if [ "$existing_install" != true ]; then
    /usr/sbin/mysqld --defaults-file=/home/appbox/config/mysql/mysqld.cnf --verbose=0 --socket=/run/mysqld/mysqld.sock &
    while ! (mysqladmin --socket=/run/mysqld/mysqld.sock ping)
    do
        sleep 3
        echo "waiting for mysql ..."
    done

    mysql -u root -p${MYSQL_ROOT_PASSWORD} ${DB_NAME} < /db.sql

    php /home/appbox/public_html/cron/reset_superuser_pass.php localhost ${ADMIN_PASS}

    pkill -9 mysqld
    fi
    rm -fr /db.sql

    mv /nginx-webdav.conf /home/appbox/config/nginx/sites-enabled/nginx-webdav.conf

    touch /etc/filerun_installed

    if [ "${SKIP_APPBOX_CALLBACK:-0}" = "1" ]; then
        echo "Skipping the Appbox install callback"
    else
    until [[ $(curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST "https://api.cylo.io/v1/apps/installed/${INSTANCE_ID}" | grep '200') ]]
        do
        sleep 5
    done
    fi
##TODO: REMOVE THIS AFTER RELEASE
#mkdir /APPBOX_DATA
#chown -R appbox:appbox /APPBOX_DATA

cat << EOF > /home/appbox/config/nginx/sites-enabled/nginx-ssl-webdav.conf
server {
  server_name ${DOMAIN};
	listen 443 ssl http2 ;
  ssl_protocols TLSv1.2 TLSv1.3;
  ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
  ssl_prefer_server_ciphers off;
	ssl_stapling on;
	ssl_stapling_verify on;
	resolver 1.1.1.1 1.0.0.1 [2606:4700:4700::1111] [2606:4700:4700::1001] valid=300s; # Cloudflare
	resolver_timeout 5s;
	ssl_session_cache shared:MozSSL:10m;  # about 40000 sessions
	ssl_buffer_size 4k;
	ssl_session_timeout 1d;
	ssl_session_tickets off;
	ssl_certificate /etc/ssl/cert.crt;
	ssl_certificate_key /etc/ssl/cert.key;
	ssl_trusted_certificate /etc/ssl/cert.crt;

    root /home/appbox/public_html;

    index index.html index.php;

    server_name _;

    proxy_connect_timeout 300s;
    proxy_read_timeout 300s;
    client_header_timeout 300s;
    client_body_timeout 300s;
    client_max_body_size 0;
    send_timeout 300s;

    real_ip_header X-Real-IP;
    set_real_ip_from 172.20.0.0/12;

    location ~ [^/]\.php(/|$) {
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param PATH_INFO \$fastcgi_path_info;
        fastcgi_param HTTPS on;

        #Avoid sending the security headers twice
        fastcgi_param modHeadersAvailable true;
        fastcgi_param front_controller_active true;
        fastcgi_intercept_errors on;
        fastcgi_request_buffering off;

        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
        fastcgi_index index.php;
        include /etc/nginx/fastcgi_params;
    }
}
EOF

# Setup crontab to refresh certs in nginx
(crontab -l; echo "0 0 * * * pkill -HUP nginx >/dev/null 2>&1") | crontab

else
    echo "App is already installed, just start up."
fi

chown -R appbox:appbox /home/appbox/trash
chown -R appbox:appbox /home/appbox/thumbnails
chown -R appbox:appbox /home/appbox/public_html

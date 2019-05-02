#!/bin/bash
set -x


if [ ! -f /etc/filerun_installed ]; then
    echo "Setting up Ioncube loaders"
    mv /ioncube.tar.gz/ioncube/ioncube_loader_lin_7.2* /usr/lib/php/20170718
    echo "zend_extension = \"/usr/lib/php/20170718/ioncube_loader_lin_7.2.so\"" > /etc/php/7.2/fpm/conf.d/00-ioncube.ini
    echo "zend_extension = \"/usr/lib/php/20170718/ioncube_loader_lin_7.2.so\"" > /etc/php/7.2/cli/conf.d/00-ioncube.ini
    rm -fr /ioncube.tar.gz

    echo "Adding Filerun php config"
    mv /00-filerun.ini /etc/php/7.2/fpm/conf.d/00-filerun.ini

    mkdir -p /home/appbox/trash
    mkdir -p /home/appbox/thumbnails


    # Is this first install?
    if [ ! -f /home/appbox/public_html/dav.php ]; then
        rm -fr /home/appbox/public_html/index.php

        /usr/sbin/mysqld --defaults-file=/home/appbox/config/mysql/mysqld.cnf --verbose=0 --socket=/run/mysqld/mysqld.sock &
        while !(mysqladmin ping)
        do
           sleep 3
           echo "waiting for mysql ..."
        done

        echo "Downloading Filerun"
        cd /home/appbox/public_html
        unzip /FileRun.zip
        rm -fr /FileRun.zip

cat << EOF >> /home/appbox/public_html/system/data/autoconfig.php
<?php
\$config['db'] = array (
  'type' => NULL,
  'server' => 'localhost',
  'database' => '${DB_NAME}',
  'username' => 'root',
  'password' => '${MYSQL_ROOT_PASSWORD}',
);
EOF

cat << EOF >> /home/appbox/public_html/customizables/config.php
<?php
\$config['path']['trash'] = '/home/appbox/trash';
\$config['path']['thumbnail_cache'] = '/home/appbox/thumbnails';
EOF

        mysql -u root -p${MYSQL_ROOT_PASSWORD} ${DB_NAME} < /db.sql

        rm -fr /db.sql

        php /home/appbox/public_html/cron/reset_superuser_pass.php localhost ${ADMIN_PASS}

        pkill -9 mysqld

        rm -fr /home/appbox/config/nginx/sites-enabled/default-site.conf
        mv /nginx-webdav.conf /home/appbox/config/nginx/sites-enabled/nginx-webdav.conf

        mv /custom_theme.css /home/appbox/public_html/customizables/custom_theme.css

        touch /etc/filerun_installed
    else
        pkill -9 mysqld
        echo "This is an update, do nothing".
    fi
    until [[ $(curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST "https://api.cylo.io/v1/apps/installed/${INSTANCE_ID}" | grep '200') ]]
        do
        sleep 5
    done
##TODO: REMOVE THIS AFTER RELEASE
#mkdir /APPBOX_DATA
#chown -R appbox:appbox /APPBOX_DATA

else
    echo "App is already installed, just start up."
fi

chown -R appbox:appbox /home/appbox/trash
chown -R appbox:appbox /home/appbox/thumbnails
chown -R appbox:appbox /home/appbox/public_html

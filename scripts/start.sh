#!/bin/sh
set -x

if [ ! -f /etc/filerun_installed ]; then
    if [ ! -f /home/appbox/public_html/dav.php ]; then
        # Setup the LEMP Stack.
        /bin/sh /scripts/lemp.sh
        rm -fr /home/appbox/public_html/index.php

        /usr/sbin/mysqld --user=appbox --socket=/run/mysqld/mysqld.sock &

        echo "Setting up Ioncube loaders"
        wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
        tar xvfz ioncube_loaders_lin_x86-64.tar.gz
        mv ioncube/ioncube_loader_lin_7.2* /usr/lib/php/20170718
        echo "zend_extension = \"/usr/lib/php/20170718/ioncube_loader_lin_7.2.so\"" > /etc/php/7.2/fpm/conf.d/00-ioncube.ini
        echo "zend_extension = \"/usr/lib/php/20170718/ioncube_loader_lin_7.2.so\"" > /etc/php/7.2/cli/conf.d/00-ioncube.ini
        rm -fr ioncube*

        echo "Adding Filerun php config"
        mv /00-filerun.ini /etc/php/7.2/fpm/conf.d/00-filerun.ini

        echo "Downloading Filerun"
        cd /home/appbox/public_html
        wget -O FileRun.zip http://www.filerun.com/download-latest
        unzip FileRun.zip
        rm -fr FileRun.zip

cat << EOF >> /home/appbox/public_html/system/data/autoconfig.php
<?php
\$config['db'] = array (
  'type' => NULL,
  'server' => 'localhost',
  'database' => '${DB_NAME}',
  'username' => 'root',
  'password' => '${MYSQL_ROOT_PASS}',
);
EOF

mkdir -p /home/appbox/trash
mkdir -p /home/appbox/thumbnails

cat << EOF >> /home/appbox/public_html/customizables/config.php
<?php
\$config['path']['trash'] = '/home/appbox/trash';
\$config['path']['thumbnail_cache'] = '/home/appbox/thumbnails';
EOF

        mysql -u root -p${MYSQL_ROOT_PASS} ${DB_NAME} < /db.sql

        rm -fr /db.sql
        chown -R appbox:appbox /home/appbox/trash
        chown -R appbox:appbox /home/appbox/thumbnails
        chown -R appbox:appbox /home/appbox/public_html

        php /home/appbox/public_html/cron/reset_superuser_pass.php localhost ${ADMIN_PASS}

        pkill -9 mysqld

        curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST "https://api.cylo.io/v1/apps/installed/$INSTANCE_ID"
        touch /etc/filerun_installed
    else
        pkill -9 mysqld
        echo "This is an update, do nothing".
    fi
else
    echo "App is already installed, just start up."
fi

exec /usr/bin/supervisord -n -c /home/appbox/config/supervisor/supervisord.conf
exec "$@"

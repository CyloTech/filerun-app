#!/bin/bash
set -x

mkdir -p /var/run/mysqld
chown mysql:mysql /var/run/mysqld

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

    if [ ! -f /home/appbox/public_html/dav.php ]; then
        # Setup the LEMP Stack.
        /bin/bash /scripts/lemp.sh
        rm -fr /home/appbox/public_html/index.php

        /usr/sbin/mysqld --user=appbox --socket=/var/run/mysqld/mysqld.sock &

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
  'password' => '${MYSQL_ROOT_PASS}',
);
EOF

cat << EOF >> /home/appbox/public_html/customizables/config.php
<?php
\$config['path']['trash'] = '/home/appbox/trash';
\$config['path']['thumbnail_cache'] = '/home/appbox/thumbnails';
EOF

        mysql -u root -p${MYSQL_ROOT_PASS} ${DB_NAME} < /db.sql

        rm -fr /db.sql

        php /home/appbox/public_html/cron/reset_superuser_pass.php localhost ${ADMIN_PASS}

        pkill -9 mysqld

        touch /etc/filerun_installed
    else
        pkill -9 mysqld
        echo "This is an update, do nothing".
    fi
    until [[ $(curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST "https://api.cylo.io/v1/apps/installed/${INSTANCE_ID}" | grep '200') ]]
        do
        sleep 5
    done
else
    echo "App is already installed, just start up."
fi

chown -R appbox:appbox /home/appbox/trash
chown -R appbox:appbox /home/appbox/thumbnails
chown -R appbox:appbox /home/appbox/public_html

exec /usr/bin/supervisord -n -c /home/appbox/config/supervisor/supervisord.conf
exec "$@"

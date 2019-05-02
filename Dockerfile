FROM repo.cylo.io/baseimage

ENV MYSQL_ROOT_PASSWORD=mysqlr00t \
    APEX_CALLBACK=false \
    INSTALL_MYSQL=true \
    INSTALL_NGINXPHP=true \
    DB_NAME=filerun \
    ADMIN_NAME=superuser \
    ADMIN_PASS=Letmein123

RUN apt update && \
    apt-get -y install \
                php-mbstring \
                php-zip \
                php-curl \
                php-gd \
                php-ldap \
                php-xml \
                unzip \
                imagemagick \
                ffmpeg \
                pngquant

ADD sources/00-filerun.ini /00-filerun.ini
ADD sources/db.sql /db.sql
ADD sources/FileRun.zip /FileRun.zip
ADD sources/ioncube.tar.gz /ioncube.tar.gz
ADD sources/nginx-webdav.conf /nginx-webdav.conf
ADD sources/custom_theme.css /custom_theme.css

ADD scripts/30_filerun.sh /etc/my_init.d/30_filerun.sh
RUN chmod +x /etc/my_init.d/30_filerun.sh
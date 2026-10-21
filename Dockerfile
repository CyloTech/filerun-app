FROM repo.cylo.net/baseimage

ENV MYSQL_ROOT_PASSWORD=mysqlr00t \
    APEX_CALLBACK=false \
    INSTALL_MYSQL=true \
    INSTALL_NGINXPHP=true \
    DB_NAME=filerun \
    ADMIN_NAME=superuser \
    ADMIN_PASS=Letmein123

RUN add-apt-repository -y ppa:libreoffice/ppa && \
    apt update && \
    apt-get -y install \
                libfreetype6-dev \
                libtiff-dev \
                libwebp-dev \
                libgif-dev \
                librsvg2-dev \
                libldap2-dev \
                libzip-dev \
                libcurl4-gnutls-dev \
                libosmesa6-dev \
                libexif-dev \
                libopenexr-dev \
                libde265-dev \
                libheif-dev \
                libopenjp2-7-dev \
                libimagequant-dev \
                libgl1 \
                libraw-dev \
                libraw-bin \
                libltdl-dev \
                libpoppler-glib-dev \
                liborc-0.4-dev \
                libcups2 \
                fftw3-dev \
                ffmpeg \
                pngquant \
                libvips-tools \
                php-mbstring \
                php-zip \
                php-curl \
                php-gd \
                php-ldap \
                php-xml \
                unzip \
                imagemagick \
                ffmpeg \
                pngquant \
                libreoffice \
                libosmesa6-dev \
    && sed -i 's/domain="coder" rights="none"/domain="coder" rights="read|write"/g' /etc/ImageMagick-6/policy.xml

RUN curl -L -o /tmp/stl.deb https://github.com/unlimitedbacon/stl-thumb/releases/download/v0.3.1/stl-thumb_0.3.1_amd64.deb && dpkg -i /tmp/stl.deb

ADD sources/00-filerun.ini /00-filerun.ini
ADD sources/db.sql /db.sql
ADD sources/FileRun.zip /FileRun.zip
ADD sources/ioncube.tar.gz /ioncube.tar.gz
ADD sources/nginx-webdav.conf /nginx-webdav.conf

ADD scripts/30_filerun.sh /etc/my_init.d/30_filerun.sh
RUN chmod +x /etc/my_init.d/30_filerun.sh

EXPOSE 80 443

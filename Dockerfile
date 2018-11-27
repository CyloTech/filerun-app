FROM repo.cylo.io/ubuntu-lemp

# Disable Supervisor on the parent image, this allows us to run commands after the parent has finished installing.
ENV START_SUPERVISOR=false

# Declare Environment variables required by the parent:
ENV MYSQL_ROOT_PASS=mysqlr00t
ENV DB_NAME=filerun
ENV ADMIN_PASS=Letmein123

RUN apt update && \
    apt-get -y install \
                php-mbstring \
                php-zip \
                php-curl \
                php-gd \
                php-ldap \
                php-xml \
                unzip

ADD sources/00-filerun.ini /00-filerun.ini
ADD sources/db.sql /db.sql

ADD scripts/start.sh /scripts/start.sh
RUN chmod -R +x /scripts

ENTRYPOINT [ "/scripts/start.sh" ]
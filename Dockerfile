# FileRun 2022.05.19 on Ubuntu 20.04 with a locally rebuilt php7.4.
#
# Stage 1 rebuilds Ubuntu's php7.4 source package with the patches in
# php74-patches/. Stage 2 is the deployed 2022.05.19-1 image with only its
# php7.4 packages and its init script replaced, so the PHP ABI, the ionCube
# loader, the configuration and the FileRun code stay as they were.
#
# The deployed image was built from repo.cylo.net/baseimage as it stood in
# 2022; that tag now points at a different release, so this build starts from
# the deployed digest instead of rebuilding it.

ARG PHP74_SOURCE_VERSION=7.4.3-4ubuntu2.29
# +cylo1 was used by unpatched trial builds; the release gate refuses it.
ARG PHP74_LOCAL_SUFFIX=+cylo2

FROM ubuntu:20.04@sha256:8feb4d8ca5354def3d8fce243717141ce31e2c428701f6682bd2fafe15388214 AS php74-build
ARG PHP74_SOURCE_VERSION
ARG PHP74_LOCAL_SUFFIX
ENV DEBIAN_FRONTEND=noninteractive DEBFULLNAME="Appbox build" DEBEMAIL=build@localhost

# force-unsafe-io only skips dpkg's fsync calls in this throwaway build stage.
RUN echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02-unsafe-io \
    && sed -i 's/^# deb-src/deb-src/' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends build-essential devscripts dpkg-dev fakeroot quilt \
    && apt-get build-dep -y "php7.4=${PHP74_SOURCE_VERSION}"

WORKDIR /build
RUN apt-get source --only-source "php7.4=${PHP74_SOURCE_VERSION}"
COPY php74-patches/ /build/php74-patches/

# Append each local patch to the package's quilt series and fail the build if
# any of them does not apply cleanly. applied-patches.sha256 records exactly
# which patches went in; the release gate compares it with php74-patches/.
RUN cd php7.4-7.4.3 \
    && export QUILT_PATCHES=debian/patches \
    && : > /build/applied-patches.sha256 \
    && for patch in /build/php74-patches/*.patch; do \
           [ -e "$patch" ] || continue; \
           name=$(basename "$patch"); \
           cp "$patch" debian/patches/; \
           echo "$name" >> debian/patches/series; \
           quilt push "$name"; \
           echo "$(sha256sum < "$patch" | cut -c1-64)  $name" >> /build/applied-patches.sha256; \
       done \
    && dch --newversion "${PHP74_SOURCE_VERSION}${PHP74_LOCAL_SUFFIX}" --distribution focal-security \
           "Appbox: apply local security patches from php74-patches/." \
    && DEB_BUILD_OPTIONS="nocheck parallel=$(nproc)" dpkg-buildpackage -b -uc -us

FROM repo.cylo.net/filerun@sha256:622fc33a1eaf945577ffdf7a6bcbfd0f608a1ba7bfe20960099a78cbd8239d05

# Replace exactly the 28 php7.4 packages the deployed image has installed.
COPY --from=php74-build \
    /build/libapache2-mod-php7.4_*_amd64.deb \
    /build/php7.4_*_all.deb \
    /build/php7.4-bcmath_*_amd64.deb \
    /build/php7.4-bz2_*_amd64.deb \
    /build/php7.4-cgi_*_amd64.deb \
    /build/php7.4-cli_*_amd64.deb \
    /build/php7.4-common_*_amd64.deb \
    /build/php7.4-curl_*_amd64.deb \
    /build/php7.4-dev_*_amd64.deb \
    /build/php7.4-fpm_*_amd64.deb \
    /build/php7.4-gd_*_amd64.deb \
    /build/php7.4-gmp_*_amd64.deb \
    /build/php7.4-imap_*_amd64.deb \
    /build/php7.4-intl_*_amd64.deb \
    /build/php7.4-json_*_amd64.deb \
    /build/php7.4-ldap_*_amd64.deb \
    /build/php7.4-mbstring_*_amd64.deb \
    /build/php7.4-mysql_*_amd64.deb \
    /build/php7.4-opcache_*_amd64.deb \
    /build/php7.4-pgsql_*_amd64.deb \
    /build/php7.4-pspell_*_amd64.deb \
    /build/php7.4-readline_*_amd64.deb \
    /build/php7.4-soap_*_amd64.deb \
    /build/php7.4-sqlite3_*_amd64.deb \
    /build/php7.4-sybase_*_amd64.deb \
    /build/php7.4-xml_*_amd64.deb \
    /build/php7.4-xmlrpc_*_amd64.deb \
    /build/php7.4-zip_*_amd64.deb \
    /tmp/php74/
COPY --from=php74-build /build/applied-patches.sha256 /usr/share/appbox/php74-patches.sha256

# The base installer runs apt on a container's first start (MySQL and
# php-mysql). The pin and the holds keep the rebuilt php7.4 packages in place
# when that happens.
RUN apt-get update \
    && apt-get install -y --no-install-recommends -o Dpkg::Options::=--force-unsafe-io /tmp/php74/*.deb \
    && printf '%s\n' \
           'Package: php7.4 php7.4-* libapache2-mod-php7.4' \
           'Pin: version *+cylo*' \
           'Pin-Priority: 1001' \
           > /etc/apt/preferences.d/cylo-php74 \
    && apt-mark hold $(dpkg-query -W -f='${binary:Package} ${source:Package}\n' | awk '$2 == "php7.4" {print $1}') \
    && rm -rf /tmp/php74 /var/lib/apt/lists/* \
    && php-fpm7.4 -t

COPY scripts/30_filerun.sh /etc/my_init.d/30_filerun.sh
RUN chmod 0755 /etc/my_init.d/30_filerun.sh

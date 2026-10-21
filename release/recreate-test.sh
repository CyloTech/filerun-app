#!/bin/bash
# Usage: release/recreate-test.sh <new image> <deployed image>
#
# Runs on the builder with network access, because the base installer
# installs MySQL with apt when a container first starts, as it does in
# production. api.cylo.io resolves to 127.0.0.1 in every test container so
# no install callback reaches the real API.
#
# 1. Fresh install with the new image, then a restart.
# 2. Update: install with the deployed image, add a marker setting, replace
#    the container with the new image on the same volumes (what
#    `apps update` does), and check that FileRun's database, users, settings
#    and files are kept, the rebuilt php7.4 packages survive the first-start
#    apt run, ionCube loads in PHP-FPM, and a multipart upload through
#    nginx and PHP-FPM works.
set -Eeuo pipefail
export LC_ALL=C

[[ $# -eq 2 ]] || { echo "usage: $0 <new image> <deployed image>" >&2; exit 2; }
new_image=$1
deployed_image=$2
release_dir=$(cd "$(dirname "$0")" && pwd)
expected_packages="${release_dir}/expected-php74-packages.txt"

gate_root=$(mktemp -d /home/appbox/builds/filerun-gate.XXXXXX)
[[ "${gate_root}" =~ ^/home/appbox/builds/filerun-gate\.[A-Za-z0-9]{6}$ ]] || { echo "unexpected gate directory" >&2; exit 1; }
suffix=${gate_root##*.}
fresh=filerun-gate-fresh-${suffix}
legacy=filerun-gate-legacy-${suffix}
updated=filerun-gate-updated-${suffix}

cleanup() {
    docker rm -f "${fresh}" "${legacy}" "${updated}" >/dev/null 2>&1 || true
    if [[ "${gate_root}" =~ ^/home/appbox/builds/filerun-gate\.[A-Za-z0-9]{6}$ ]]; then
        docker run --rm --network none --entrypoint sh -v "${gate_root}:/gate" "${new_image}" \
            -c 'find /gate -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +' >/dev/null 2>&1 || true
        rmdir -- "${gate_root}" || echo "Builder cleanup needed at ${gate_root}" >&2
    fi
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

fail() {
    echo "FAIL: $*" >&2
    for c in "${fresh}" "${legacy}" "${updated}"; do
        docker logs --tail 40 "${c}" 2>&1 | sed "s/^/[${c}] /" >&2 || true
    done
    exit 1
}

mysql_in() {
    local container=$1; shift
    docker exec "${container}" mysql --socket=/run/mysqld/mysqld.sock -uroot -pmysqlr00t -NB filerun -e "$*" 2>/dev/null
}

launch() {
    local container=$1 data=$2 image=$3 skip_callback=$4
    mkdir -p "${data}/public_html" "${data}/mysql" "${data}/config" "${data}/logs" "${data}/appbox_data" "${data}/certs"
    if [[ ! -f "${data}/certs/cert.crt" ]]; then
        openssl req -x509 -newkey rsa:2048 -nodes -days 2 -subj /CN=filerun-gate.local \
            -keyout "${data}/certs/cert.key" -out "${data}/certs/cert.crt" >/dev/null 2>&1
        chmod 0644 "${data}/certs/cert.key"
    fi
    docker run -d --platform linux/amd64 --name "${container}" \
        --add-host api.cylo.io:127.0.0.1 \
        -e INSTANCE_ID=0 -e DOMAIN=filerun-gate.local -e SKIP_APPBOX_CALLBACK="${skip_callback}" \
        -v "${data}/public_html:/home/appbox/public_html" \
        -v "${data}/mysql:/home/appbox/mysql" \
        -v "${data}/config:/home/appbox/config" \
        -v "${data}/logs:/home/appbox/logs" \
        -v "${data}/appbox_data:/APPBOX_DATA" \
        -v "${data}/certs/cert.crt:/etc/ssl/cert.crt:ro" \
        -v "${data}/certs/cert.key:/etc/ssl/cert.key:ro" \
        "${image}" >/dev/null
}

# Ready means: the init script finished, nginx + PHP-FPM serve FileRun's
# login page, which needs the ionCube loader in PHP-FPM, and the MySQL server
# that runit starts after the init script accepts connections (the login page
# is served before it does).
wait_ready() {
    local container=$1
    for _ in $(seq 1 300); do
        if docker exec "${container}" test -f /etc/filerun_installed 2>/dev/null \
            && docker exec "${container}" sh -c 'curl -fsS http://127.0.0.1/ | grep -qi filerun' 2>/dev/null \
            && docker exec "${container}" mysqladmin --socket=/run/mysqld/mysqld.sock -uroot -pmysqlr00t ping >/dev/null 2>&1; then
            return 0
        fi
        [[ "$(docker inspect --format '{{.State.Running}}' "${container}" 2>/dev/null)" == true ]] \
            || fail "${container} stopped"
        sleep 3
    done
    fail "${container} did not serve FileRun"
}

# The deployed image's init script loops on the install callback (which
# cannot reach the API here), so its services never start. Wait for the
# install itself, then run MySQL by hand.
wait_installed() {
    local container=$1
    for _ in $(seq 1 300); do
        docker exec "${container}" test -f /etc/filerun_installed 2>/dev/null && return 0
        [[ "$(docker inspect --format '{{.State.Running}}' "${container}" 2>/dev/null)" == true ]] \
            || fail "${container} stopped"
        sleep 3
    done
    fail "${container} did not finish installing"
}

start_mysql_by_hand() {
    local container=$1
    docker exec -d "${container}" /usr/sbin/mysqld --defaults-file=/home/appbox/config/mysql/mysqld.cnf \
        --verbose=0 --socket=/run/mysqld/mysqld.sock
    for _ in $(seq 1 60); do
        docker exec "${container}" mysqladmin --socket=/run/mysqld/mysqld.sock -uroot -pmysqlr00t ping >/dev/null 2>&1 && return 0
        sleep 2
    done
    fail "MySQL did not start in ${container}"
}

check_php() {
    local container=$1
    docker exec "${container}" dpkg-query -W -f='${db:Status-Abbrev}|${binary:Package}|${source:Package}|${Version}\n' \
        | awk -F'|' '$3 == "php7.4" {print $1 "|" $2 "|" $4}' | sort -t'|' -k2,2 > "${gate_root}/${container}.php"
    awk -F'|' '{print $2}' "${gate_root}/${container}.php" | diff -u "${expected_packages}" - \
        || fail "${container}: php7.4 package set changed after the first start"
    if awk -F'|' '$1 !~ /^[hi]i/ || $3 !~ /\+cylo/' "${gate_root}/${container}.php" | grep -q .; then
        cat "${gate_root}/${container}.php" >&2
        fail "${container}: a php7.4 package is no longer the rebuilt one after the first start"
    fi
    docker exec "${container}" php -r 'exit(extension_loaded("ionCube Loader") ? 0 : 1);' \
        || fail "${container}: ionCube is not loaded in the PHP CLI"
    docker exec -i "${container}" sh -c 'cat > /home/appbox/public_html/appbox-gate-upload.php' <<'PHP'
<?php
echo count($_FILES), ':', $_FILES['f']['size'] ?? -1, ':', $_POST['a'] ?? '', ':', extension_loaded('ionCube Loader') ? 'ioncube' : 'no-ioncube';
PHP
    local result
    result=$(docker exec "${container}" sh -c 'printf hello > /tmp/gate-upload.txt && curl -fsS -F a=b -F f=@/tmp/gate-upload.txt http://127.0.0.1/appbox-gate-upload.php')
    docker exec "${container}" rm -f /home/appbox/public_html/appbox-gate-upload.php /tmp/gate-upload.txt
    [[ "${result}" == "1:5:b:ioncube" ]] \
        || fail "${container}: multipart upload through PHP-FPM returned '${result}', expected '1:5:b:ioncube'"
    echo "${container}: php7.4 rebuilt packages kept, ionCube loaded, multipart upload through PHP-FPM ok"
}

echo "-- fresh install with ${new_image}"
launch "${fresh}" "${gate_root}/fresh" "${new_image}" 1
wait_ready "${fresh}"
[[ "$(mysql_in "${fresh}" "SELECT username FROM df_users WHERE id = 1")" == superuser ]] \
    || fail "fresh install has no superuser"
check_php "${fresh}"
docker restart "${fresh}" >/dev/null
wait_ready "${fresh}"
echo "fresh install and restart ok"
docker rm -f "${fresh}" >/dev/null

echo "-- update from ${deployed_image}"
launch "${legacy}" "${gate_root}/update" "${deployed_image}" 1
wait_installed "${legacy}"
start_mysql_by_hand "${legacy}"
marker=$(openssl rand -hex 16)
mysql_in "${legacy}" "INSERT INTO df_settings (var, val) VALUES ('appbox_release_gate_marker', '${marker}')" \
    || fail "could not add the marker setting"
mysql_in "${legacy}" "INSERT INTO df_users (username, password, activated, name) VALUES ('gate-user', 'x', 1, 'Gate user')" \
    || fail "could not add the marker user"
superuser_hash=$(mysql_in "${legacy}" "SELECT password FROM df_users WHERE id = 1")
[[ -n "${superuser_hash}" ]] || fail "deployed install has no superuser"
docker exec "${legacy}" mysqladmin --socket=/run/mysqld/mysqld.sock -uroot -pmysqlr00t shutdown >/dev/null 2>&1 || true
dav_mtime=$(stat -c %Y "${gate_root}/update/public_html/dav.php")
docker exec "${legacy}" sh -c 'printf keep > /APPBOX_DATA/gate-file.txt'
sleep 5
docker rm -f "${legacy}" >/dev/null

launch "${updated}" "${gate_root}/update" "${new_image}" 1
wait_ready "${updated}"
[[ "$(mysql_in "${updated}" "SELECT val FROM df_settings WHERE var = 'appbox_release_gate_marker'")" == "${marker}" ]] \
    || fail "the update lost FileRun settings"
[[ "$(mysql_in "${updated}" "SELECT COUNT(*) FROM df_users WHERE username = 'gate-user'")" == 1 ]] \
    || fail "the update lost FileRun users"
[[ "$(mysql_in "${updated}" "SELECT password FROM df_users WHERE id = 1")" == "${superuser_hash}" ]] \
    || fail "the update reset the superuser password"
[[ "$(stat -c %Y "${gate_root}/update/public_html/dav.php")" == "${dav_mtime}" ]] \
    || fail "the update re-extracted FileRun into public_html"
[[ "$(cat "${gate_root}/update/appbox_data/gate-file.txt")" == keep ]] || fail "the update lost files"
check_php "${updated}"
docker restart "${updated}" >/dev/null
wait_ready "${updated}"
echo "update from the deployed image kept FileRun users, settings and files"

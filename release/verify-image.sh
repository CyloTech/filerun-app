#!/bin/sh
# Release gate for FileRun 2022.05.19 with the rebuilt php7.4.
#
# Release: release/verify-image.sh repo.cylo.net/filerun:<tag>
# Trial:   release/verify-image.sh local/filerun-trial:<tag> repo.cylo.net/filerun:<tag>
#
# Exits 0 only when the local image passes every check and the registry
# definitively reports that the release tag does not exist yet. Any
# indeterminate registry answer fails. A release run also requires at least
# one patch in php74-patches/ and one check in release/regression/; a trial
# run (an unpushed local/filerun-trial image) only reports their absence.
set -eu
export LC_ALL=C

fail() {
    echo "FAIL: $*" >&2
    exit 1
}

deployed_ref=repo.cylo.net/filerun@sha256:622fc33a1eaf945577ffdf7a6bcbfd0f608a1ba7bfe20960099a78cbd8239d05

case "$#" in
    1) image_ref=$1; release_ref=$1; mode=release ;;
    2) image_ref=$1; release_ref=$2; mode=trial ;;
    *) fail "usage: $0 <image> [<release image>]" ;;
esac
for ref in "$image_ref" "$release_ref"; do
    case "$ref" in
        ''|*[!A-Za-z0-9._/:-]*|*@*) fail "invalid image reference: $ref" ;;
    esac
done
case "$release_ref" in
    repo.cylo.net/filerun:?*) ;;
    *) fail "release image must be repo.cylo.net/filerun:<tag>: $release_ref" ;;
esac
if [ "$mode" = trial ]; then
    case "$image_ref" in
        local/filerun-trial:?*) ;;
        *) fail "trial images must be tagged local/filerun-trial:<tag>" ;;
    esac
fi
release_dir=$(cd "$(dirname "$0")" && pwd)
repo_dir=$(dirname "$release_dir")

dockerfile_arg() {
    sed -n "s/^ARG $1=//p" "$repo_dir/Dockerfile"
}
php_version="$(dockerfile_arg PHP74_SOURCE_VERSION)$(dockerfile_arg PHP74_LOCAL_SUFFIX)"
case "$php_version" in
    7.4.3-4ubuntu2.*+cylo[0-9]*) ;;
    *) fail "unexpected php7.4 version in Dockerfile: $php_version" ;;
esac

run_in_image() {
    docker run --rm --network none --entrypoint "$@"
}

echo "== Mode: $mode ($image_ref, release tag $release_ref)"

echo "== Local patches"
patch_count=$(find "$repo_dir/php74-patches" -maxdepth 1 -name '*.patch' -type f | wc -l)
check_count=$(find "$release_dir/regression" -maxdepth 1 -name '*.sh' -type f | wc -l)
echo "$patch_count patch(es), $check_count regression check(s)"
if [ "$mode" = release ]; then
    [ "$patch_count" -gt 0 ] || fail "php74-patches/ has no patches"
    [ "$check_count" -gt 0 ] || fail "release/regression/ has no checks"
elif [ "$patch_count" -eq 0 ]; then
    echo "TRIAL: no patches; this image only proves the rebuild and the gate"
fi
expected_patches=$(cd "$repo_dir/php74-patches" && for p in *.patch; do
    [ -e "$p" ] || continue
    printf '%s  %s\n' "$(sha256sum < "$p" | cut -c1-64)" "$p"
done)
image_patches=$(run_in_image cat "$image_ref" /usr/share/appbox/php74-patches.sha256)
[ "$image_patches" = "$expected_patches" ] \
    || fail "patches in the image differ from php74-patches/: '$image_patches'"
[ -z "$image_patches" ] || echo "$image_patches"

echo "== PHP packages (expect $php_version)"
packages=$(run_in_image dpkg-query "$image_ref" \
    -W -f='${db:Status-Abbrev}|${binary:Package}|${source:Package}|${Version}\n' \
    | awk -F'|' '$3 == "php7.4" {print $1 "|" $2 "|" $4}' | sort)
echo "$packages"
echo "$packages" | awk -F'|' '{print $2}' | diff -u "$release_dir/expected-php74-packages.txt" - \
    || fail "installed php7.4 packages differ from the deployed set"
echo "$packages" | awk -F'|' -v v="$php_version" '$1 !~ /^ii/ || $3 != v' | grep -q . \
    && fail "some php7.4 packages are not installed at $php_version"
fpm_version=$(run_in_image php-fpm7.4 "$image_ref" -v | head -1)
echo "$fpm_version"
case "$fpm_version" in
    "PHP $php_version "*) ;;
    *) fail "php-fpm7.4 is not the rebuilt $php_version" ;;
esac

echo "== Apt pin and holds"
run_in_image apt-mark "$image_ref" showhold | sort | diff -u "$release_dir/expected-php74-packages.txt" - \
    || fail "held packages differ from the php7.4 set"
run_in_image grep "$image_ref" -qx 'Pin: version \*+cylo\*' /etc/apt/preferences.d/cylo-php74 \
    || fail "apt pin for the rebuilt php7.4 is missing"

echo "== FPM modules"
run_in_image php-fpm7.4 "$image_ref" -m \
    | diff -u "$release_dir/expected-fpm-modules.txt" - \
    || fail "FPM module list differs from the deployed image"

echo "== FPM configuration"
run_in_image php-fpm7.4 "$image_ref" -t || fail "php-fpm7.4 configuration test failed"

echo "== Configuration and FileRun payload unchanged from the deployed image"
docker image inspect "$deployed_ref" >/dev/null 2>&1 || docker pull -q "$deployed_ref" >/dev/null
manifest_paths="/etc/php /etc/nginx /etc/service /scripts /FileRun.zip /db.sql /00-filerun.ini /nginx-webdav.conf /ioncube.tar.gz /etc/my_init.d/00_regen_ssh_host_keys.sh /etc/my_init.d/10_syslog-ng.init /etc/my_init.d/20_installer.sh"
manifest_dir=$(mktemp -d)
trap 'rm -rf "$manifest_dir"' EXIT
# shellcheck disable=SC2086
docker run --rm --network none -v "$release_dir:/release:ro" --entrypoint sh "$deployed_ref" \
    /release/file-manifest.sh $manifest_paths > "$manifest_dir/deployed.txt"
# shellcheck disable=SC2086
docker run --rm --network none -v "$release_dir:/release:ro" --entrypoint sh "$image_ref" \
    /release/file-manifest.sh $manifest_paths > "$manifest_dir/new.txt"
diff -u "$manifest_dir/deployed.txt" "$manifest_dir/new.txt" \
    || fail "configuration or FileRun files differ from the deployed image"
echo "$(wc -l < "$manifest_dir/new.txt") paths identical"
image_script=$(run_in_image sha256sum "$image_ref" /etc/my_init.d/30_filerun.sh | cut -c1-64)
[ "$image_script" = "$(sha256sum < "$repo_dir/scripts/30_filerun.sh" | cut -c1-64)" ] \
    || fail "/etc/my_init.d/30_filerun.sh is not scripts/30_filerun.sh"

echo "== Multipart upload (built-in server)"
docker run --rm --network none -v "$release_dir:/release:ro" --entrypoint sh "$image_ref" \
    /release/multipart-smoke.sh php7.4 \
    || fail "multipart upload smoke test failed"

echo "== Regression checks"
for check in "$release_dir"/regression/*.sh; do
    [ -e "$check" ] || continue
    echo "-- $(basename "$check")"
    docker run --rm --network none -v "$release_dir:/release:ro" --entrypoint sh "$image_ref" \
        "/release/regression/$(basename "$check")" \
        || fail "regression check $(basename "$check") failed"
done

echo "== Fresh install, restart, and update from the deployed image"
"$release_dir/recreate-test.sh" "$image_ref" "$deployed_ref" \
    || fail "install/update test failed"

echo "== Registry tag must not exist"
"$release_dir/registry-absent.sh" "$release_ref" || fail "registry precondition failed"

echo "PASS ($mode): $image_ref"

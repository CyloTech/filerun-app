# Regression checks

Each `*.sh` file here is mounted read-only into the image at
`/release/regression/` and run with `sh`, without network access. It must
exit 0 only when the issue it covers is fixed. Add one for every patch in
`php74-patches/`. `php7.4`, `php-fpm7.4` and `curl` are available in the image.

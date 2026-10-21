# php7.4 patches

Each `*.patch` file here is added to Ubuntu's php7.4 quilt series in name
order, so prefix them with a number (`0001-...`). Patches must apply to the
`php7.4-7.4.3` source tree (Ubuntu 7.4.3-4ubuntu2.29) with `-p1`; the build
fails if one does not. The build records the name and SHA-256 of every
applied patch in `/usr/share/appbox/php74-patches.sha256`, and the release
gate compares that list with this directory.

Bump `PHP74_LOCAL_SUFFIX` in the Dockerfile (`+cylo1`, `+cylo2`, ...) whenever
the set of patches changes after a release has been pushed, and add a
regression check under `release/regression/` for the issue each patch fixes.
A release gate run without a trial image argument refuses to pass while this
directory has no patches or `release/regression/` has no checks.

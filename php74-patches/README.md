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
A release or candidate gate run refuses to pass while this directory has no
patches or `release/regression/` has no checks.

## Patches

- `0001-CVE-2026-109618-109619.patch`: the 21 October 2026 fix for
  GHSA-w8hw-w9fx-j79w (CVE-2026-109618, RCE via OOM corruption during
  multipart parsing) and GHSA-6wmf-4rv5-p3rp (CVE-2026-109619, RCE via stale
  global state). It ports the minimal mitigation php-src published for
  end-of-life branches (1d7dec178a0, reduced from 01a40e89fbfc on PHP-8.2),
  as Canonical shipped it for php8.1 8.1.2-1ubuntu2.28. Its DEP-3 header maps
  every 8.1 hunk to 7.4.3, including the ones that do not apply.
  `Zend/zend_vm_execute.h` in the patch is `Zend/zend_vm_gen.php` output for
  the patched `Zend/zend_vm_def.h`. Checks: `release/regression/cve-2026-*.sh`.

  Behaviour changes: memory exhaustion ends the PHP process (an FPM worker
  exits with status 1, the client gets no response, and shutdown functions
  and destructors do not run; the message is in the FPM log), and
  `session.upload_progress.enabled` no longer has any effect.

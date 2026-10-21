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

## 21 October 2026 security release

PHP 8.2.35, 8.3.36, 8.4.27 and 8.5.12 fix GHSA-w8hw-w9fx-j79w
(CVE-2026-109618, RCE via OOM corruption during multipart parsing) and
GHSA-6wmf-4rv5-p3rp (CVE-2026-109619, RCE via stale global state, with
session upload progress as a confirmed consumer). The fix is the php-src
commit "Avoid state corruption via bailout" (01a40e89fbfc on PHP-8.2). It
replaces the longjmp() out-of-memory bailout with a deferred soft OOM and
resets request globals, and touches more than 300 files (about 10,700 added
lines, most of them tests). It is not a small change to main/rfc1867.c, so a
7.4.3 backport should start from a maintained PHP 7.4 backport rather than
from the 8.2 commit:

- ppa:ondrej/php php7.4 (7.4.33-30 on 21 October 2026; a newer upload
  would carry a 7.4 backport in debian/patches),
- Debian LTS / Freexian ELTS php7.4,
- Ubuntu ESM php7.4 7.4.3-4ubuntu2.29+esmN, if an entitlement may be used.

Until a backport exists, the advisories list partial mitigations:
`memory_limit=-1` enforced administratively, `session.upload_progress.enabled=0`,
a conservative `post_max_size` enforced at the frontend, and lower
`max_input_nesting_level` / `max_input_vars` / `max_file_uploads`. None of
them is a complete fix.

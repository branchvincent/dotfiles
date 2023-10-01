# https://github.com/pkgxdev/pkgx

status is-interactive && command -q pkgx || exit

set -gx PKGX_DIR $XDG_DATA_HOME/pkgx

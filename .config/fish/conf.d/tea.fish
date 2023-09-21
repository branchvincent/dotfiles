# https://github.com/teaxyz/cli

status is-interactive && command -q tea || exit

set -gx TEA_DIR $XDG_DATA_HOME/tea

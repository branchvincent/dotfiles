# https://github.com/direnv/direnv

status is-interactive || exit

set -x DIRENV_LOG_FORMAT
type -q direnv && direnv hook fish | source

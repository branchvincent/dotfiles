# https://github.com/direnv/direnv

status is-interactive || exit

set -gx DIRENV_LOG_FORMAT
type -q direnv && direnv hook fish | source

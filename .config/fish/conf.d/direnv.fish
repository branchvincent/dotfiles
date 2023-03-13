# https://github.com/direnv/direnv

status is-interactive && command -q direnv || exit

set -gx DIRENV_LOG_FORMAT
direnv hook fish | source

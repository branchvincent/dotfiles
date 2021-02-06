# https://github.com/direnv/direnv

set -x DIRENV_LOG_FORMAT
status is-interactive && direnv hook fish | source

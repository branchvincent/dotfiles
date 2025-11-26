# https://github.com/direnv/direnv

status is-interactive && command -q direnv || exit

direnv hook fish | source

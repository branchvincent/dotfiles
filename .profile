# shellcheck shell=sh

# Executed for login bash/dash shells. We may not be able to change our login
# shell, so instead if we are also interactive, just redirect to fish.

case "$-" in
*i*)
    export PATH="/opt/homebrew/bin:/usr/local/bin:/home/linuxbrew/.linuxbrew/bin${PATH+:$PATH}"
    command -v fish >/dev/null 2>&1 && exec fish -il
    ;;
esac

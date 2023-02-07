# shellcheck shell=sh

# Executed for login bash/dash shells. We may not be able to change our login
# shell, so instead if we are also interactive, just redirect to fish.

unset HISTFILE
export PATH="/opt/homebrew/bin:/usr/local/bin:/home/linuxbrew/.linuxbrew/bin${PATH+:$PATH}"

case "$-" in
*i*)
    fish="$(command -v fish)"
    if [ -x "$fish" ] && [ "$fish" != "$SHELL" ]; then
        exec env SHELL="$fish" SHLVL=0 "$fish" -il
    fi
    ;;
esac

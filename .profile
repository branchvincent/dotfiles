# shellcheck shell=sh

# Executed for login bash/dash shells. We may not be able to change our login
# shell, so instead if we are also interactive, just redirect to fish.

unset HISTFILE

case "$-" in
*i*)
    brew_paths=/opt/homebrew/bin:/usr/local/bin:/home/linuxbrew/.linuxbrew/bin
    fish="$(PATH="$brew_paths${PATH+:$PATH}" command -v fish)"
    if [ -x "$fish" ] && [ "$fish" != "$SHELL" ]; then
        printf "\e[33mNOTICE\e[0m: Replacing \e[1m%s\e[0m with \e[1mfish\e[0m\n" "${0#-}"
        exec env SHELL="$fish" "$fish" -il
    fi
    ;;
esac

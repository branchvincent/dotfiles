# https://github.com/teaxyz/cli

status is-interactive && command -q tea || exit

set -gx TEA_PREFIX $XDG_DATA_HOME/tea
test -L $XDG_BIN_HOME/tea || ln -sf $TEA_PREFIX/tea.xyz/v0/bin/tea $XDG_BIN_HOME/tea

# tea --magic
function fish_command_not_found
    tea -- $argv
end

# shellcheck shell=bash
#
# Configure vscode

# Settings
debug "Linking settings"
ln -sfn ~/.config/code/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sfn ~/.config/code/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# Extensions
missing=$(comm -13 <(code --list-extensions | sort) <(sort ~/.config/code/extensions.txt))
if [ -n "$missing" ]; then
    debug "Installing extensions"
    echo "$missing" | sed 's/^/--install-extension /' | xargs code
fi

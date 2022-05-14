# shellcheck shell=bash
#
# Configure vscode

# Settings
debug "Linking settings"
ln -sfn ~/.config/code/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sfn ~/.config/code/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# Extensions
debug "Installing extensions"
sed 's/^/--install-extension /' ~/.config/code/extensions.txt | xargs code

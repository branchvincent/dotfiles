# shellcheck shell=bash
#
# Configure vscode

# Settings
ln -sfn ~/.config/code/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sfn ~/.config/code/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# Extensions
mkdir -p ~/Code
sed 's/^/--install-extension /' ~/.config/code/extensions.txt | xargs code

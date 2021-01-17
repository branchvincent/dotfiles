# shellcheck shell=bash
#
# Install vscode extensions

mkdir -p ~/Code
sed 's/^/--install-extension /' ~/.config/code/extensions.txt | xargs code

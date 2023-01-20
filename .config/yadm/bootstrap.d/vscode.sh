# shellcheck shell=bash
#
# Configure vscode

# Extensions
missing=$(comm -13 <(code --list-extensions | sort) <(sort ~/.config/code/extensions.txt))
if [ -n "$missing" ]; then
    debug "Installing extensions"
    echo "$missing" | sed 's/^/--install-extension /' | xargs code
fi

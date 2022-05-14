# shellcheck shell=bash
#
# Configure fish shell

# Update default login shell
shell=$(command -v fish)
if [ "$SHELL" != "$shell" ]; then
    debug "Updating login shell"
    echo "$shell" | sudo tee -a /etc/shells
    chsh -s "$shell"
fi

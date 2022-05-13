# shellcheck shell=bash
#
# Configure fish shell

# Update default login shell
shell=$(command -v fish)
if [ "$SHELL" != "$shell" ]; then
    echo "$shell" | sudo tee -a /etc/shells
    chsh -s "$shell"
fi

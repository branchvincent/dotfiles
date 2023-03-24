# shellcheck shell=bash
#
# Configure fish shell

# Update default login shell
shell=$(command -v fish)
if ! grep -q "$shell" /etc/shells; then
    debug "Updating login shell"
    echo "$shell" | sudo tee -a /etc/shells >/dev/null
    chsh -s "$shell"
fi

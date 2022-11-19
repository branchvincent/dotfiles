# shellcheck shell=bash
#
# Configure fish shell

# Update default login shell
shell=$(command -v fish)
if ! grep -q "$shell" /etc/shells; then
    debug "Updating login shell"
    echo "$shell" | sudo tee -a /etc/shells
    chsh -s "$shell"
fi

# Enable Touch ID for sudo
if ! grep -q pam_tid.so /etc/pam.d/sudo; then
    debug "Enabling Touch ID for sudo"
    sudo sed -i '' -e "2s/^/auth       sufficient     pam_tid.so\n/" /etc/pam.d/sudo
fi

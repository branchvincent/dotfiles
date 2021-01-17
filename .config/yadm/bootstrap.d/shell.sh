# shellcheck shell=bash
#
# Update default login shell to `fish`

shell=$(command -v fish)
[ "$SHELL" != "$shell" ] || return 0

echo "$shell" | sudo tee -a /etc/shells
chsh -s "$shell"

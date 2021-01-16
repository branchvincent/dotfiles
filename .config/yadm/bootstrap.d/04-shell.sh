# shellcheck shell=bash
#
# Update default login shell to `fish`

shell=$(command -v fish)
[ "$SHELL" != "$shell" ] || return 0

echo "Updating shell to fish"
echo "$shell" | sudo tee -a /etc/shells
chsh -s "$shell"

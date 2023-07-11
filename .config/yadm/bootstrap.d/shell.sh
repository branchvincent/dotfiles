# shellcheck shell=bash
#
# Configure fish shell

# Update default login shell
fish=$(command -v fish || true)
if ! [ -x "$fish" ]; then
    debugw "Skipping due to missing fish"
elif ! grep -q "$fish" /etc/shells; then
    debug "Updating login shell"
    echo "$fish" | sudo tee -a /etc/shells >/dev/null
    chsh -s "$fish"
fi

# shellcheck shell=bash
#
# Update default login shell

fish=$(command -v fish || true)
if ! [ -x "$fish" ]; then
    debugw "Skipping due to missing fish"
    return
fi

if [ "$(uname)" = Darwin ]; then
    shell=$(dscl . -read ~/ UserShell | sed 's/UserShell: //')
else
    shell=$(getent passwd "$(whoami)" | cut -d: -f7)
fi
if [ "$shell" = "$fish" ]; then
    debugw "Login shell is already $shell"
    return
fi

debug "Updating login shell: $shell -> $fish"
grep -q "$fish" /etc/shells || echo "$fish" | sudo tee -a /etc/shells >/dev/null
chsh -s "$fish"

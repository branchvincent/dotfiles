# shellcheck shell=bash
#
# Fetch all secrets from 1Password

# Login
debug "Signing in to 1Password"
eval "$(op signin)"

### docker ###
debug "Fetching Docker credentials"
export PATH="${PATH+$PATH:}/Applications/OrbStack.app/Contents/MacOS/xbin"
op read op://personal/docker/token | docker login --username branchv --password-stdin

## env ###
debug "Creating shell secrets"
GITHUB_TOKEN=$(op read op://personal/github/token)
export GITHUB_TOKEN
cat <<EOF >~/.config/fish/conf.d/secrets.fish
set -gx GITHUB_TOKEN $GITHUB_TOKEN
set -gx NGROK_AUTHTOKEN $(op read op://personal/ngrok/token)
set -gx NPM_TOKEN $(op read op://personal/npm/token)
set -gx UV_PUBLISH_TOKEN $(op read op://personal/pypi/token)
EOF
chmod 600 ~/.config/fish/conf.d/secrets.fish

### git ###
debug "Fetching git credentials"
printf "protocol=https\nhost=github.com\n" | git credential-osxkeychain erase
printf "protocol=https\nhost=github.com\nusername=branchv\npassword=%s\n" "$GITHUB_TOKEN" | git credential-osxkeychain store
test -f ~/Code/workspace.toml && fish -c 'git workspace update'

# shellcheck shell=bash
#
# Fetch all secrets from 1Password

# Login
debug "Signing in to 1Password"
eval "$(op signin)"

### docker ###
debug "Fetching Docker credentials"
op item get docker --fields token | docker login --username branchvincent --password-stdin

## env ###
debug "Creating shell secrets"
GITHUB_TOKEN=$(op item get GitHub --fields token)
export GITHUB_TOKEN
cat <<EOF >~/.config/fish/conf.d/secrets.fish
set -gx GITHUB_TOKEN $GITHUB_TOKEN
set -gx NGROK_AUTHTOKEN $(op item get ngrok --fields token)
set -gx NPM_TOKEN $(op item get NPM --fields token)
EOF
chmod 600 ~/.config/fish/conf.d/secrets.fish

### git ###
debug "Fetching git credentials"
printf "protocol=https\nhost=github.com\n" | git credential-osxkeychain erase
printf "protocol=https\nhost=github.com\nusername=branchvincent\npassword=%s\n" "$GITHUB_TOKEN" | git credential-osxkeychain store
test -f ~/Code/workspace.toml && fish -c 'git workspace update'

### gpg ###
debug "Fetching GPG key"
# shellcheck disable=SC2016
GNUPGHOME=$(fish -c 'echo $GNUPGHOME')
GPG_TTY=$(tty || true)
export GNUPGHOME GPG_TTY
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >"$GNUPGHOME"/gpg-agent.conf
curl -fsSL https://github.com/branchvincent.gpg | gpg -q --import
op document get GPG | gpg -q --import
gpgconf --kill gpg-agent
echo test | gpg --clearsign &>/dev/null

### ssh ###
debug "Fetching SSH key"
op document get SSH >~/.config/ssh/keys/default
chmod 600 ~/.config/ssh/keys/default
ssh-add -q --apple-use-keychain ~/.config/ssh/keys/default

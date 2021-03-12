# shellcheck shell=bash
#
# Fetch all secrets from 1Password

# Login
eval "$(op signin my.1password.com branchevincent@gmail.com)"

### docker ###
op get item docker --fields password | docker login --username branchvincent --password-stdin
op get item quay --fields password | docker login --username branchevincent --password-stdin

## env ###
cat <<EOF >~/.config/fish/conf.d/secrets.fish
set -x AWS_ACCESS_KEY_ID $(op get item AWS --fields api.key)
set -x AWS_SECRET_ACCESS_KEY $(op get item AWS --fields api.secret)
set -x BW_SESSION $(op get item Bitwarden --fields session)
set -x GITHUB_TOKEN $(op get item GitHub --fields token)
set -x NPM_TOKEN $(op get item NPM --fields token)
EOF
chmod 600 ~/.config/fish/conf.d/secrets.fish

### gpg ###
curl -fsSL https://github.com/branchvincent.gpg | gpg --import
gpg --import "$(op get document "GPG Private Key")"
echo "pinentry-program /usr/local/bin/pinentry-mac" >~/.local/share/gnupg/gpg-agent.conf

### ssh ###
prv_key_path="$HOME/.config/ssh/keys/default"
if [ ! -f "$prv_key_path" ]; then
    op get document "SSH Private Key" --output "$prv_key_path"
    ssh-add -K "$prv_key_path"
fi

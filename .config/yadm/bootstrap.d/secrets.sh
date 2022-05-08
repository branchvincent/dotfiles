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
set -x GITHUB_TOKEN $(op get item GitHub --fields token)
set -x NPM_TOKEN $(op get item NPM --fields token)
EOF
chmod 600 ~/.config/fish/conf.d/secrets.fish

### git ###
# shellcheck disable=SC2016
GITHUB_TOKEN=$(fish -c 'echo $GITHUB_TOKEN')
printf "protocol=https\nhost=github.com\n" | git credential-osxkeychain erase
printf "protocol=https\nhost=github.com\nusername=branchvincent\npassword=%s\n" "$GITHUB_TOKEN" | git credential-osxkeychain store

### gpg ###
curl -fsSL https://github.com/branchvincent.gpg | gpg --import
gpg --import "$(op get document "GPG Private Key")"
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >~/.local/share/gnupg/gpg-agent.conf

### ssh ###
prv_key_path="$HOME/.config/ssh/keys/default"
if [ ! -f "$prv_key_path" ]; then
    op get document "SSH Private Key" --output "$prv_key_path"
    ssh-add -K "$prv_key_path"
fi

### all-repos ###
mkdir -p ~/.local/share/all-repos
cat <<EOF >~/.local/share/all-repos/config.json
{
  "output_dir": "$HOME/Code/all",
  "source": "all_repos.source.github_org",
  "source_settings": {
    "api_key": "$GITHUB_TOKEN",
    "org": "ndustrialio",
    "private": true
  },
  "push": "all_repos.push.github_pull_request",
  "push_settings": {
    "api_key": "$GITHUB_TOKEN",
    "username": "branchvincent",
    "fork": false
  }
}
EOF
chmod 600 ~/.local/share/all-repos/config.json

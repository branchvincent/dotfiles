# shellcheck shell=bash
#
# Fetch all secrets from 1Password

# Login
eval "$(op signin)"

### docker ###
op item get docker --fields password | docker login --username branchvincent --password-stdin
op item get quay --fields password | docker login quay.io --username branchevincent --password-stdin

## env ###
cat <<EOF >~/.config/fish/conf.d/secrets.fish
set -x AWS_ACCESS_KEY_ID $(op item get AWS --fields api.key)
set -x AWS_SECRET_ACCESS_KEY $(op item get AWS --fields api.secret)
set -x GITHUB_TOKEN $(op item get GitHub --fields token)
set -x NPM_TOKEN $(op item get NPM --fields token)
EOF
chmod 600 ~/.config/fish/conf.d/secrets.fish

### git ###
# shellcheck disable=SC2016
GITHUB_TOKEN=$(fish -c 'echo $GITHUB_TOKEN')
printf "protocol=https\nhost=github.com\n" | git credential-osxkeychain erase
printf "protocol=https\nhost=github.com\nusername=branchvincent\npassword=%s\n" "$GITHUB_TOKEN" | git credential-osxkeychain store

### gpg ###
GPG_TTY=$(tty)
export GPG_TTY
curl -fsSL https://github.com/branchvincent.gpg | gpg --import
op document get "GPG Private Key" | gpg --import
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >~/.local/share/gnupg/gpg-agent.conf

### ssh ###
prv_key_path="$HOME/.config/ssh/keys/default"
if [ ! -f "$prv_key_path" ]; then
    op document get "SSH Private Key" --output "$prv_key_path"
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

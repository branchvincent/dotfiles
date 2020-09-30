# shellcheck shell=bash
#
# Fetch all secrets from 1Password

# Login
eval "$(op signin my.1password.com branchevincent@gmail.com)"

### docker ###
op get item docker --fields password | docker login --username branchvincent --password-stdin
op get item quay --fields password | docker login --username branchevincent --password-stdin

## env ###
cat <<EOF >"$HOME/.config/fish/conf.d/99-secrets.fish"
set -x AWS_ACCESS_KEY_ID $(op get item AWS --fields api.key)
set -x AWS_SECRET_ACCESS_KEY $(op get item AWS --fields api.secret)
set -x GITHUB_TOKEN $(op get item GitHub --fields token)
set -x NPM_TOKEN $(op get item NPM --fields token)
EOF

### kubeconfig ###
# TODO

### ssh ###
prv_key_path="$HOME/.config/ssh/id_rsa"
if [ ! -f "$prv_key_path" ]; then
    op get document "SSH Private Key" --output "$prv_key_path"
    ssh-add -K "$prv_key_path"
fi

# shellcheck shell=bash
#
# Configure fish shell

# Update default login shell
shell=$(command -v fish)
if [ "$SHELL" != "$shell" ]; then
    echo "$shell" | sudo tee -a /etc/shells
    chsh -s "$shell"
fi

# Install fisher/plugins
fish -c '
if not functions -q fisher
    curl -sL git.io/fisher | source
    fisher install <~/.config/fish/fish_plugins >/dev/null
    printf 1112111y | tide configure >/dev/null
end
'

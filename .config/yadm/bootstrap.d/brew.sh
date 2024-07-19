# shellcheck shell=bash
#
# Install Homebrew and packages

export PATH="/opt/homebrew/bin:/usr/local/bin:/home/linuxbrew/.linuxbrew/bin${PATH+:$PATH}"
if ! has brew; then
    debug "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

debug "Installing Homebrew packages"
export HOMEBREW_BUNDLE_FILE=~/.config/brew/Brewfile
if [ -n "${CI:-}" ]; then
    debugw "Skipping due to \$CI"
elif ! has yadm || ! brew bundle check &>/dev/null; then
    brew bundle install --no-lock
    RUSTUP_HOME=~/.local/share/rustup rustup default stable
fi

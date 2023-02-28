# shellcheck shell=bash
#
# Install Homebrew and packages

export PATH="/opt/homebrew/bin:/usr/local/bin:/home/linuxbrew/.linuxbrew/bin${PATH+:$PATH}"
if ! has brew; then
    debug "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

debug "Checking Homebrew packages"
export HOMEBREW_BUNDLE_FILE=~/.config/brew/Brewfile
if ! has yadm || ! brew bundle check &>/dev/null; then
    debug "Installing Homebrew packages"
    brew bundle install --no-lock
fi

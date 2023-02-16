# shellcheck shell=bash
#
# Install Homebrew and packages

export PATH="/opt/homebrew/bin:/usr/local/bin:/home/linuxbrew/.linuxbrew/bin${PATH+:$PATH}"
if ! has brew; then
    debug "Installing Homebrew"
    NONINTERACTIVE=1 HOMEBREW_INSTALL_FROM_API=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

debug "Checking Homebrew packages"
export HOMEBREW_BUNDLE_FILE=~/.config/brew/Brewfile
if [ ! -e "$HOMEBREW_PREFIX/bin/yadm" ] || ! brew bundle check &>/dev/null; then
    debug "Installing Homebrew packages"
    brew bundle install --no-lock
fi

# Ensure `docker` is in PATH (bundled with Docker.app, which creates symlinks on first boot)
if ! has docker; then
    export PATH="${PATH+$PATH:}/Applications/Docker.app/Contents/Resources/bin"
    open -a Docker
fi

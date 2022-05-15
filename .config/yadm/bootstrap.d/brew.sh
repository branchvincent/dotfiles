# shellcheck shell=bash
#
# Install Homebrew and packages

if ! has brew; then
    debug "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure `brew` is in PATH
case "$(uname -sm)" in
"Darwin arm64") eval "$(/opt/homebrew/bin/brew shellenv)" ;;
"Darwin x86_64") eval "$(/usr/local/bin/brew shellenv)" ;;
"Linux x86_64") eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" ;;
esac

debug "Checking Homebrew packages"
export HOMEBREW_BUNDLE_FILE=~/.config/brew/Brewfile
if ! brew bundle check &>/dev/null; then
    debug "Installing Homebrew packages"
    brew bundle install
fi

# Ensure `docker` is in PATH (bundled with Docker.app, which creates symlinks on first boot)
has docker || PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"

# Symlink default java
if ! test -L /Library/Java/JavaVirtualMachines/openjdk.jdk; then
    debug "Linking java"
    sudo ln -sfn "$(brew --prefix openjdk)"/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
fi

# Symlink repos for development
debug "Linking repos"
mkdir -p ~/Code/Homebrew
ln -sfn "$(brew --repo branchvincent/tap)" ~/Code/Homebrew/homebrew-tap
ln -sfn "$(brew --repo homebrew/core)" ~/Code/Homebrew/homebrew-core
ln -sfn "$(brew --repo homebrew/cask)" ~/Code/Homebrew/homebrew-cask

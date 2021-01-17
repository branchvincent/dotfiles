# shellcheck shell=bash
#
# Install Homebrew and packages

if ! has brew; then
    echo "Installing Homebrew"
    echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "Installing brew packages"
brew bundle install --file=~/.config/brew/Brewfile

# Don't require sudo for tlmgr
sudo chown -R "$(whoami)":admin /usr/local/texlive

# Fix quicklook plugins: https://github.com/sindresorhus/quick-look-plugins#catalina-notes
xattr -dr com.apple.quarantine ~/Library/QuickLook/

# Symlink default java
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

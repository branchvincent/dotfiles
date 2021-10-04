# shellcheck shell=bash
#
# Install Homebrew and packages

has brew || NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install --file=~/.config/brew/Brewfile

# Don't require sudo for tlmgr
sudo chown -R "$(whoami)":admin /usr/local/texlive

# Fix quicklook plugins: https://github.com/sindresorhus/quick-look-plugins#catalina-notes
xattr -dr com.apple.quarantine ~/Library/QuickLook/

# Symlink default java
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Symlink repos for development
mkdir -p ~/Code/Homebrew
ln -sfn "$(brew --repo branchvincent/tap)" ~/Code/Homebrew/homebrew-tap
ln -sfn "$(brew --repo homebrew/core)" ~/Code/Homebrew/homebrew-core
ln -sfn "$(brew --repo homebrew/cask)" ~/Code/Homebrew/homebrew-cask

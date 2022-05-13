# shellcheck shell=bash
#
# Install Homebrew and packages

has brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Ensure `brew` is in PATH
case "$(uname -sm)" in
"Darwin arm64") eval "$(/opt/homebrew/bin/brew shellenv)" ;;
"Darwin x86_64") eval "$(/usr/local/bin/brew shellenv)" ;;
"Linux x86_64") eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" ;;
esac

brew bundle install --file=~/.config/brew/Brewfile

# Fix quicklook plugins: https://github.com/sindresorhus/quick-look-plugins#catalina-notes
xattr -dr com.apple.quarantine ~/Library/QuickLook/

# Symlink default java
sudo ln -sfn "$(brew --prefix openjdk)"/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Symlink repos for development
mkdir -p ~/Code/Homebrew
ln -sfn "$(brew --repo branchvincent/tap)" ~/Code/Homebrew/homebrew-tap
ln -sfn "$(brew --repo homebrew/core)" ~/Code/Homebrew/homebrew-core
ln -sfn "$(brew --repo homebrew/cask)" ~/Code/Homebrew/homebrew-cask

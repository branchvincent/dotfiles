# shellcheck shell=bash
#
# Install desired packages from package managers

has() {
    command -v "$1" &>/dev/null
}

### Homebrew ###
echo "Installing brew packages"
if ! has brew; then
    echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew bundle install --file=~/.config/brew/Brewfile

# Fix a bunch of issues
sudo chown -R "$(whoami)":admin /usr/local/texlive                                                    # don't require sudo for tlmgr
xattr -dr com.apple.quarantine ~/Library/QuickLook/                                                   # fix quicklook plugins: https://github.com/sindresorhus/quick-look-plugins#catalina-notes
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk # symlink default java

### Pipx ###
echo "Installing pipx packages"
xargs -L1 pipx install <~/.config/pipx/packages.txt || true
pipx inject httpie httpie-jwt-auth # TODO: how to store injected packages?

### Rust ###
if ! has rustc; then
    echo "Installing rust toolchain"
    fish -lc 'rustup-init -y --quiet --no-modify-path'
fi

### VS Code ###
echo "Installing vscode extensions"
mkdir -p ~/Code
sed 's/^/--install-extension /' ~/.config/code/extensions.txt | xargs code

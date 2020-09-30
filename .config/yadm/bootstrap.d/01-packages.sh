# shellcheck shell=bash
#
# Install desired packages from package managers

### Homebrew ###
echo "Installing brew packages"
if ! command -v brew &>/dev/null; then
    echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew bundle install --file=~/.config/brew/Brewfile

# Fix a bunch of issues
sudo chown -R "$(whoami)":admin /usr/local/texlive                                                             # don't require sudo for tlmgr
xattr -dr com.apple.quarantine ~/Library/QuickLook/                                                            # fix quicklook plugins: https://github.com/sindresorhus/quick-look-plugins#catalina-notes
find "/Applications/Backup and Sync.app/Contents/Resources" -name folder-mac-yosemite.icns -exec trash "{}" \; # remove Google Drive icon

### Pipx ###
echo "Installing pipx packages"
xargs -L1 pipx install <~/.config/pipx/packages.txt

### VS Code ###
echo "Installing vscode extensions"
sed 's/^/--install-extension /' ~/.config/code/extensions.txt | xargs code

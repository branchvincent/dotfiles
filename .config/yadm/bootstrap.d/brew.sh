# shellcheck shell=bash
#
# Install Homebrew and packages

if [ -n "${CI:-}" ]; then
    debugw "Skipping due to \$CI"
    return
fi

export PATH="/opt/homebrew/bin:/usr/local/bin:/home/linuxbrew/.linuxbrew/bin${PATH+:$PATH}"
if ! has brew; then
    debug "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

debug "Installing Homebrew packages"
export HOMEBREW_BUNDLE_FILE=~/.config/brew/Brewfile
if ! has yadm || ! brew bundle check &>/dev/null; then
    brew bundle install
    [ ! -d /Applications/QLMarkdown.app/ ] || xattr -dr com.apple.quarantine /Applications/QLMarkdown.app/
    [ ! -d /Applications/Syntax\ Highlight.app/ ] || xattr -dr com.apple.quarantine /Applications/Syntax\ Highlight.app/
    ! has rustup || RUSTUP_HOME=~/.local/share/rustup rustup default stable
fi

# shellcheck shell=bash
#
# Install Homebrew and packages

### brew ###
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

### rust ###
if ! has rustup; then
    debug "Installing Rust"
    export CARGO_HOME=~/.local/share/cargo RUSTUP_HOME=~/.local/share/rustup
    curl -fsS https://sh.rustup.rs | sh -s -- -y --quiet --no-modify-path
fi

### vscode ###
if has code; then
    missing=$(comm -13 <(code --list-extensions | sort) <(sort ~/.config/code/extensions.txt))
    if [ -n "$missing" ]; then
        debug "Installing VSCode extensions"
        echo "$missing" | sed 's/^/--install-extension /' | xargs code
    fi
fi

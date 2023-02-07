# shellcheck shell=bash
#
# Install non-brewed packages

### rust ###
if ! has rustup; then
    debug "Rust"
    fish -lc 'curl -fsS https://sh.rustup.rs | sh -s -- -y --quiet --no-modify-path'
fi

### vscode ###
if has code; then
    debug "VSCode"
    missing=$(comm -13 <(code --list-extensions | sort) <(sort ~/.config/code/extensions.txt))
    if [ -n "$missing" ]; then
        debug "Installing extensions"
        echo "$missing" | sed 's/^/--install-extension /' | xargs code
    fi
fi

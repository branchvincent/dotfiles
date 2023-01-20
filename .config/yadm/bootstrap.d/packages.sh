# shellcheck shell=bash
#
# Install non-brewed packages

### pipx ###
if has pipx; then
    debug "Pipx"
    missing=$(comm -13 <(pipx list --json 2>/dev/null | jq -r '.venvs | values[].metadata.main_package.package_or_url' | sort) <(sort ~/.config/pipx/packages.txt))
    echo "$missing" | xargs -rL1 pipx install
fi

### rust ###
if ! has rustup; then
    debug "Rust"
    fish -lc 'rustup-init -y --quiet --no-modify-path'
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

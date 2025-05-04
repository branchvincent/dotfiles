# Enforce XDG compliance
#
# References
# - Spec: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# - Support: https://wiki.archlinux.org/title/XDG_Base_Directory

# NOTE: faster than `mkdir -p` alone, since test is a builtin
function __maybe_mkdir
    test -d "$argv" || mkdir -p "$argv"
end

# Core directories
set -gx XDG_BIN_HOME ~/.local/bin # ok, i made this one up
set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_STATE_HOME ~/.local/state
set -gx --path XDG_BIN_DIRS $XDG_BIN_HOME # this too
set -gx --path XDG_DATA_DIRS /usr/local/share /usr/share

for d in XDG_{BIN,CACHE,CONFIG,DATA,STATE}_HOME
    __maybe_mkdir $$d
end

# brew
set -gx HOMEBREW_BUNDLE_FILE $XDG_CONFIG_HOME/brew/Brewfile
set -gx HOMEBREW_CACHE $XDG_CACHE_HOME/brew
set -gx HOMEBREW_LOGS $XDG_CACHE_HOME/brew/logs

# code: https://github.com/microsoft/vscode/issues/3884

# deno
set -gx DENO_INSTALL_ROOT ~/.local

# go
set -gx GOBIN $XDG_BIN_HOME
set -gx GOPATH $XDG_DATA_HOME/go

# kube
set -gx KUBECONFIG $XDG_DATA_HOME/kube/config.yaml
set -gx KUBECACHEDIR $XDG_CACHE_HOME/kube

# less
set -gx LESSHISTFILE /dev/null

# node
set -gx NODE_REPL_HISTORY /dev/null
set -gx npm_config_cache $XDG_CACHE_HOME/npm
set -gx npm_config_prefix ~/.local
set -gx npm_config_userconfig $XDG_CONFIG_HOME/npm/npmrc

# pip
set -gx PIP_CACHE_DIR $XDG_CACHE_HOME/pip
set -gx PIP_CONFIG_FILE $XDG_CONFIG_HOME/pip/pip.conf

# pkgx
set -gx PKGX_DIR $XDG_DATA_HOME/pkgx

# poetry
set -gx POETRY_CACHE_DIR $XDG_CACHE_HOME/poetry
set -gx POETRY_CONFIG_DIR $XDG_CONFIG_HOME/poetry
set -gx POETRY_DATA_DIR $XDG_DATA_HOME/poetry

# psql
set -gx PSQL_HISTORY /dev/null

# python
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py

# ruby
set -gx BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
set -gx BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle
set -gx BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle
set -gx GEM_HOME $XDG_DATA_HOME/gem
set -gx GEM_SPEC_CACHE $XDG_CACHE_HOME/gem

# rust
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CARGO_INSTALL_ROOT ~/.local
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup

# zsh
set -gx ZDOTDIR $XDG_CONFIG_HOME/zsh

# MANPATH
set -gxp MANPATH : # defer to $PATH

# PATH
if status is-login
    fish_add_path -g --move --path $XDG_BIN_DIRS $HOMEBREW_PREFIX/{,s}bin
    set PATH (path filter -d $PATH)
end

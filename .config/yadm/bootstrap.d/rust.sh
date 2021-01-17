# shellcheck shell=bash
#
# Install rust

has rustc || return 0

echo "Installing rust toolchain"
fish -lc 'rustup-init -y --quiet --no-modify-path'

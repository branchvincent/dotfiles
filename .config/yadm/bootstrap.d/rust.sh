# shellcheck shell=bash
#
# Install rust

has rustc && return 0

fish -lc 'rustup-init -y --quiet --no-modify-path'

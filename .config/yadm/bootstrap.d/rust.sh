# shellcheck shell=bash
#
# Install rust

has rustup && return 0

fish -lc 'rustup-init -y --quiet --no-modify-path'

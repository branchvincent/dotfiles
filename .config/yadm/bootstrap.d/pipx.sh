# shellcheck shell=bash
#
# Install pipx packages

xargs -L1 pipx install --force <~/.config/pipx/packages.txt

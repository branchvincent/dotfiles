# shellcheck shell=bash
#
# Install pipx packages

xargs -L1 pipx install --force <~/.config/pipx/packages.txt
pipx inject httpie httpie-jwt-auth # TODO: how to store injected packages?

# shellcheck shell=bash
#
# Install pipx packages

echo "Installing pipx packages"
xargs -L1 pipx install <~/.config/pipx/packages.txt || true
pipx inject httpie httpie-jwt-auth # TODO: how to store injected packages?

# shellcheck shell=bash
#
# Install pipx packages

missing=$(comm -13 <(pipx list --json | jq -r '.venvs | values[].metadata.main_package.package_or_url' | sort) <(sort ~/.config/pipx/packages.txt))
echo "$missing" | xargs -rL1 pipx install

# shellcheck shell=bash
#
# Configure yadm

yadm gitconfig status.showUntrackedFiles normal
yadm sparse-checkout set '/*' '!/bootstrap'

# Duplicate .gitignore for vscode: https://github.com/microsoft/vscode/issues/38878
echo '{"files.exclude": {"{[^.]*,.cache,.local,.Trash,.vscode}": true}}' >~/.vscode/settings.json

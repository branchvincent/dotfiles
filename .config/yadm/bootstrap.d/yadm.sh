# shellcheck shell=bash
#
# Configure yadm

yadm gitconfig status.showUntrackedFiles normal
yadm sparse-checkout set '/*' '!/bootstrap'

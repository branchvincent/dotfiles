# shellcheck shell=bash
#
# Configure yadm

debug "Updating settings"
yadm gitconfig status.showUntrackedFiles normal
yadm sparse-checkout set '/*' '!/bootstrap'

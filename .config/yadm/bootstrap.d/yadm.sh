# shellcheck shell=bash
#
# Configure yadm

debug "Updating settings"
yadm gitconfig status.showUntrackedFiles normal
(cd ~ && yadm sparse-checkout set --no-cone '/*' '!/bootstrap')

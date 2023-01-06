status is-login || exit

set -gx EDITOR code --wait
set -gx MANPAGER "MANROFFOPT=-c sh -c 'col -bx | bat -l man -p'"
set -gx LESS --ignore-case --Raw-control-chars --quit-if-one-screen
set -gx PAGER less
type -q delta || set -gx GIT_PAGER $PAGER
set -Uq fish_features || set -U fish_features all

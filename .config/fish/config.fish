status is-login || exit

set -Uq fish_features || set -U fish_features all

# Editor
set -gx EDITOR vim
if type -q code
    set -gx EDITOR code --wait
else if type -q helix
    set -gx EDITOR helix
end

# Pagers
set -gx LESS --ignore-case --Raw-control-chars --quit-if-one-screen
set -gx PAGER less
type -q bat && set -gx MANPAGER "MANROFFOPT=-c sh -c 'col -bx | bat -l man -p'"
type -q delta || set -gx GIT_PAGER $PAGER

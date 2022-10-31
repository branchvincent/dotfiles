status is-login || exit

set -gx EDITOR code --wait
set -gx MANPAGER "MANROFFOPT=-c sh -c 'col -bx | bat -l man -p'"
set -gx PAGER less --tabs=4 -RF -+X
set -Uq fish_features || set -U fish_features all

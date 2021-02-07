status is-login || exit

set -x EDITOR code --wait
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x PAGER less -RF --tabs=4
set -Uq fish_features || set -U fish_features 3.0
path_add $XDG_BIN_DIRS /usr/local/{,s}bin

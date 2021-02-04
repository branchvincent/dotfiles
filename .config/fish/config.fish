set -x EDITOR code --wait
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x PAGER less -RF --tabs=4
path_add $XDG_BIN_DIRS /usr/local/{,s}bin

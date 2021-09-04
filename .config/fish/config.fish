status is-login || exit

set -gx EDITOR code --wait
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx PAGER less --tabs=4 -RF -+X
set -Uq fish_features || set -U fish_features 3.{0,1,4}
fish_add_path -gmP $XDG_BIN_DIRS /usr/local/{,s}bin

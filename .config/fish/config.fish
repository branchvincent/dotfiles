set -x EDITOR code --wait
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x PAGER less -RF --tabs=4
path_add $CARGO_HOME/bin $NPM_CONFIG_PREFIX/bin $XDG_BIN_HOME /usr/local/bin /usr/local/sbin

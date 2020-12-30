# Environment variables

### General ###
set -x EDITOR code --wait
set -x PAGER less -RF --tabs=4
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
path_add $CARGO_HOME/bin $NPM_CONFIG_PREFIX/bin $XDG_BIN_HOME /usr/local/bin /usr/local/sbin

### Tools ###
set -x AWS_DEFAULT_REGION us-west-2
set -x FZF_DEFAULT_OPTS "--bind='ctrl-o:execute(code {})+abort'"
set -x GPG_TTY (tty)
set -x PIP_DISABLE_PIP_VERSION_CHECK 1
set -x PIP_REQUIRE_VIRTUALENV 1
set -x POETRY_VIRTUALENVS_IN_PROJECT true
set -x PYTHONDONTWRITEBYTECODE 1

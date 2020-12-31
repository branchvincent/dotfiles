# Enforce XDG compliance
#
# References
# - Spec: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# - Support: https://wiki.archlinux.org/index.php/XDG_Base_Directory

# NOTE: faster than `mkdir -p` alone, since test is a builtin
function __maybe_mkdir
    test -d "$argv" || mkdir -p "$argv"
end

# Core directories
set -x XDG_BIN_HOME ~/.local/bin # ok, i made this one up
set -x XDG_CACHE_HOME ~/.cache
set -x XDG_CONFIG_HOME ~/.config
set -x XDG_DATA_HOME ~/.local/share

for d in $XDG_BIN_HOME $XDG_CACHE_HOME $XDG_CONFIG_HOME $XDG_DATA_HOME
    __maybe_mkdir $d
end

# brew
set -x HOMEBREW_BUNDLE_FILE $XDG_CONFIG_HOME/brew/Brewfile

# code: https://github.com/microsoft/vscode/issues/3884

# cookiecutter: https://github.com/cookiecutter/cookiecutter/issues/104
set -x COOKIECUTTER_CONFIG $XDG_CONFIG_HOME/cookiecutter/config.yaml

# docker: https://github.com/docker/for-mac/issues/2635
set -x DOCKER_CONFIG $XDG_CONFIG_HOME/docker

# gnupg
set -x GNUPGHOME $XDG_DATA_HOME/gnupg
__maybe_mkdir $GNUPGHOME

# go
set -x GOBIN $XDG_BIN_HOME
set -x GOPATH $XDG_DATA_HOME/go

# java
set -x GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set -x JABBA_HOME $XDG_DATA_HOME/jabba
set -x MAVEN_OPTS "-Dmaven.repo.local=$XDG_CACHE_HOME/maven/repository"

# kube
set -x KUBECONFIG $XDG_DATA_HOME/kube/config.yaml
alias kubectl "kubectl --cache-dir=$XDG_CACHE_HOME/kube" # https://github.com/kubernetes/kubernetes/issues/80399

# less
set -x LESSHISTFILE $XDG_DATA_HOME/less/history
__maybe_mkdir (dirname $LESSHISTFILE)

# node
set -x NODE_REPL_HISTORY $XDG_DATA_HOME/node/history
__maybe_mkdir (dirname $NODE_REPL_HISTORY)
set -x NO_UPDATE_NOTIFIER 1 # used by npm: https://github.com/yeoman/update-notifier/issues/180
set -x NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -x NPM_CONFIG_DEVDIR $XDG_DATA_HOME/node-gyp
set -x NPM_CONFIG_INIT_MODULE $XDG_CONFIG_HOME/npm/config/npm-init.js
set -x NPM_CONFIG_PREFIX $XDG_DATA_HOME/npm
set -x NPM_CONFIG_TMP $XDG_CACHE_HOME/npm
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -x NVM_DIR $XDG_DATA_HOME/nvm
alias yarn "yarn --use-yarnrc=$XDG_CONFIG_HOME/yarn/config.yaml" # https://github.com/yarnpkg/yarn/issues/2334

# psql
set -x PSQLRC $XDG_CONFIG_HOME/psql/config.sql
set -x PSQL_HISTORY $XDG_DATA_HOME/psql/history
__maybe_mkdir (dirname $PSQL_HISTORY)

# python
set -x PIPX_HOME $XDG_DATA_HOME/pipx
set -x PYENV_ROOT $XDG_DATA_HOME/pyenv
set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py

# ruby
set -x BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
set -x BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle
set -x BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle
set -x GEM_HOME $XDG_DATA_HOME/gem
set -x GEM_SPEC_CACHE $XDG_CACHE_HOME/gem

# rust
set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -x RUSTUP_HOME $XDG_DATA_HOME/rustup

# ssh
set -x GIT_SSH_COMMAND "ssh -F $XDG_CONFIG_HOME/ssh/config"
alias ssh $GIT_SSH_COMMAND

# starship
set -x STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/config.toml

# zsh
set -x ZDOTDIR $XDG_CONFIG_HOME/zsh

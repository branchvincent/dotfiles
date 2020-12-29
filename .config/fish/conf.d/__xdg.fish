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

# gradle
set -x GRADLE_USER_HOME $XDG_DATA_HOME/gradle

# jabba
set -x JABBA_HOME $XDG_DATA_HOME/jabba

# kube
set -x KUBECONFIG $XDG_DATA_HOME/kube/config.yaml
alias kubectl "kubectl --cache-dir=$XDG_CACHE_HOME/kube" # https://github.com/kubernetes/kubernetes/issues/80399

# less
set -x LESSHISTFILE $XDG_DATA_HOME/less/history
__maybe_mkdir (dirname $LESSHISTFILE)

# maven
set -x MAVEN_OPTS "-Dmaven.repo.local=$XDG_CACHE_HOME/maven/repository"

# node
set -x NODE_REPL_HISTORY $XDG_DATA_HOME/node/history
__maybe_mkdir (dirname $NODE_REPL_HISTORY)

# npm
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -x npm_config_cache $XDG_CACHE_HOME/npm
set -x npm_config_init_module $XDG_CONFIG_HOME/npm/config/npm-init.js
set -x npm_config_prefix $XDG_DATA_HOME/npm
set -x npm_config_tmp $XDG_CACHE_HOME/npm
set -x NO_UPDATE_NOTIFIER 1 # package used by npm: https://github.com/yeoman/update-notifier/issues/180

# nvm
set -x NVM_DIR "$XDG_DATA_HOME/nvm"

# pipx
set -x PIPX_HOME $XDG_DATA_HOME/pipx

# psql
set -x PSQLRC $XDG_CONFIG_HOME/psql/config.sql
set -x PSQL_HISTORY $XDG_DATA_HOME/psql/history
__maybe_mkdir (dirname $PSQL_HISTORY)

# pyenv
set -x PYENV_ROOT "$XDG_DATA_HOME/pyenv"

# python
set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py

# ruby
set -x BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
set -x BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle
set -x BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle
set -x GEM_HOME $XDG_DATA_HOME/gem
set -x GEM_SPEC_CACHE $XDG_CACHE_HOME/gem

# ssh
set -l SSH "ssh -F $XDG_CONFIG_HOME/ssh/config"
alias ssh $SSH
set -x GIT_SSH_COMMAND $SSH

# starship
set -x STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/config.toml

# yadm: https://github.com/TheLocehiliosan/yadm/issues/208
set -x YADM_OVERRIDE_REPO $XDG_DATA_HOME/yadm/repo.git

# yarn: https://github.com/yarnpkg/yarn/issues/2334
alias yarn "yarn --use-yarnrc=$XDG_CONFIG_HOME/yarn/config.yaml"

# zsh
set -x ZDOTDIR $XDG_CONFIG_HOME/zsh

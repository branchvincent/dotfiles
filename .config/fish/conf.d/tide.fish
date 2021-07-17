# https://github.com/IlanCosman/tide

set fish_handle_reflow 0 # https://github.com/fish-shell/fish-shell/issues/1706#issuecomment-803655785

### Prompt items ###
set -g tide_left_prompt_items pwd git newline prompt_char
set -g tide_right_prompt_items status cmd_duration context jobs pulsar k8s go java node python rust direnv

### Custom items ###
function _tide_language_version
    argparse --stop-nonopt "c/color=" "i/icon=" -- $argv || return
    set -l v ($argv 2>&1 | string match -r "\d+\.\d+\.\d+")
    set -q _flag_color[1] || set _flag_color 00AFAF
    echo (set_color $_flag_color)$_flag_icon $v
end

function _tide_item_shlvl --description "Show SHLVL"
    if set -q SHLVL && test "$SHLVL" -gt 2
        echo (set_color blue) (math $SHLVL-1) # subtract one since we are in a subshell
    end
end

function _tide_item_direnv --description "Show Direnv status"
    set -q DIRENV_DIR || return
    set -l color yellow
    direnv status | string match -rq '^Found RC allowed false$' && set color brred
    echo (set_color $color)▼
end

function _tide_item_docker --description "Show if docker containers are running"
    test -f docker-compose.yaml -o -f docker-compose.yml || return
    set -l containers (count (docker-compose ps -q 2>/dev/null)) || return
    printf (set_color blue --bold)
    test $containers -gt 1 && printf " $containers"
end

function _tide_item_k8s --description "Show Kubernetes context"
    set -l namespace /(kubens --current)
    test $namespace = /default && set namespace ""
    echo (set_color magenta)⎈ (kubectl config current-context)$namespace
end

function _tide_item_pulsar --description "Show Pulsar context"
    echo (set_color blue) (pulsarctl context current 2>&1)
end

function _tide_item_go --description "Show Go version"
    test -f go.mod || return
    _tide_language_version -i go version
end

function _tide_item_java --description "Show Java version"
    test -f pom.xml -o -f build.gradle -o -f build.gradle.kts || return
    _tide_language_version -i java -Xinternalversion
end

function _tide_item_node --description "Show Node version"
    test -f package.json || return
    _tide_language_version -i⬢ node --version
end

function _tide_item_python --description "Show Python version"
    test -n "$VIRTUAL_ENV" -o -f pyproject.toml -o -f setup.py || return
    _tide_language_version -i python --version
end

### Show on command ###

set -g tide_show_k8s_on kubectl helm kubens kubectx stern
set -g tide_show_pulsar_on pulsarctl

set -n | string match -r '^tide_show_(.*)_on$' | while read -Ll match item
    set -l func _tide_item_$item
    functions -c $func _$func
    echo "
function $func --description (desc $func)
    set -q _tide_show_$item && __tide_item_$item
end" | source
end

function _tide_show_on_command
    if test (count (commandline -poc)) -eq 0
        set -l cmd (commandline -t)
        abbr -q $cmd && set -l var _fish_abbr_$cmd && set cmd $$var
        set -e (set -n | string match -r '^_tide_show_.*$') 2>/dev/null
        set -n | string match -r '^tide_show_(.*)_on$' | while read -Ll match item
            contains $cmd $$match && set -gx _tide_show_$item
        end
        commandline -f repaint
    end
end

bind ' ' 'commandline -f expand-abbr; _tide_show_on_command; commandline -i " "'

# Terminal prompt: https://github.com/IlanCosman/tide
#
# References:
# - Icons: https://www.nerdfonts.com/cheat-sheet

set fish_handle_reflow 0 # https://github.com/fish-shell/fish-shell/issues/1706#issuecomment-803655785

### Config ###

set -g tide_left_prompt_items pwd git newline prompt_char
set -g tide_right_prompt_items \
    status \
    cmd_duration \
    context \
    jobs \
    gcloud \
    pulsar_context \
    kube_context \
    go \
    java \
    node \
    python \
    rust \
    direnv

set -g tide_show_gcloud_on gcloud
set -g tide_show_kube_context_on kubectl helm kubens kubectx stern
set -g tide_show_pulsar_context_on pulsarctl

### Items ###

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

function _tide_item_direnv --description "Show direnv status"
    set -q DIRENV_DIR || return
    set -l color yellow
    direnv status | string match -rq '^Found RC allowed false$' && set color brred
    echo (set_color $color)▼
end

function _tide_item_docker --description "Show Docker containers"
    test -f docker-compose.yaml -o -f docker-compose.yml || return
    set -l containers (count (docker-compose ps -q 2>/dev/null)) || return
    printf (set_color blue --bold)
    test $containers -gt 1 && printf " $containers"
end

function _tide_item_gcloud --description "Show Google cloud project"
    echo (set_color blue) (gcloud config get-value project)
end

function _tide_item_kube_context --description "Show Kubernetes context"
    set -l namespace /(kubens --current)
    test $namespace = /default && set namespace ""
    echo (set_color magenta)⎈ (kubectl config current-context)$namespace
end

function _tide_item_pulsar_context --description "Show Pulsar context"
    echo (set_color blue) (pulsarctl context current 2>&1)
end

function _tide_item_go --description "Show Go version"
    if set -q tide_go_always_display || test -f go.mod
        _tide_language_version -i go version
    end
end

function _tide_item_java --description "Show Java version"
    if set -q tide_java_always_display || test -f pom.xml -o -f build.gradle -o -f build.gradle.kts
        _tide_language_version -i java -Xinternalversion
    end
end

function _tide_item_node --description "Show Node version"
    if set -q tide_node_always_display || test -f package.json
        _tide_language_version -i⬢ node --version
    end
end

function _tide_item_python --description "Show Python version"
    if set -q tide_python_always_display || test -n "$VIRTUAL_ENV" -o -f pyproject.toml -o -f setup.py
        _tide_language_version -i python --version
    end
end

### Show on command ###

set -n | string match -r '^tide_show_(.*)_on$' | while read -Ll match item
    set -l func _tide_item_$item
    functions -c $func _$func
    echo "
function $func --description (desc $func)
    if set -q _tide_show_$item || set -q tide_"$item"_always_display
        tide_"$item"_always_display=1 __tide_item_$item
    end
end" | source
end

function _tide_show_on_command
    if test (count (commandline -poc)) -eq 0
        set -l cmd (commandline -t)
        abbr -q $cmd && set -l var _fish_abbr_$cmd && set cmd $$var
        set -n | string match -r '^tide_show_(.*)_on$' | while read -Ll match item
            contains $cmd $$match && set -gx _tide_show_$item || set -e _tide_show_$item
        end
        commandline -f repaint
    end
end

bind ' ' 'commandline -f expand-abbr; _tide_show_on_command; commandline -i " "'

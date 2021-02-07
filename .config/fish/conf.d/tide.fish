# https://github.com/IlanCosman/tide

# Configure prompt items
set -g tide_left_prompt_items pwd git newline prompt_char
set -g tide_right_prompt_items status cmd_duration context jobs k8s go java node python rust shlvl direnv

# Define custom prompt items
function _tide_language_version
    argparse --stop-nonopt "c/color=" "i/icon=" -- $argv || return
    set -l v ($argv | string match -r "\d+\.\d+\.\d+")
    set -q _flag_color[1] || set _flag_color 00AFAF
    echo (set_color $_flag_color)$_flag_icon $v
end

function _tide_item_shlvl --description "Show SHLVL"
    if set -q SHLVL && test "$SHLVL" -gt 2
        echo (set_color blue) (math $SHLVL-1) # subtract one since we are in a subshell
    end
end

function _tide_item_direnv --description "Show Direnv status"
    set -q DIRENV_DIR || return
    set -l color yellow
    direnv status | string match -rq '^Found RC allowed false$' && set color brred
    echo (set_color $color)▼
end

function _tide_item_k8s --description "Show Kubernetes context"
    set -q tide_show_k8s || return
    set -l namespace /(kubens --current)
    test $namespace = "/default" && set namespace ""
    echo (set_color magenta)⎈ (kubectl config current-context)$namespace
end

function _tide_item_go --description "Show Go version"
    test -f go.mod || return
    _tide_language_version -i go version
end

function _tide_item_java --description "Show Java version"
    test -f pom.xml || return
    _tide_language_version -i java -Xinternalversion
end

function _tide_item_node --description "Show Node version"
    test -f package.json || return
    _tide_language_version -i⬢ node --version
end

function _tide_item_python --description "Show Python version"
    set -q VIRTUAL_ENV || return
    _tide_language_version -i python --version
end

function _tide_show_on_command
    if test (count (commandline -poc)) -eq 0
        switch (commandline -t)
            case kubectl helm kubens kubectx
                set -U tide_show_k8s
                commandline -f repaint
            case '*'
                set -e tide_show_k8s
                commandline -f repaint
        end
    end
end

bind ' ' '_tide_show_on_command; commandline -i " "'

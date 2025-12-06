status is-login || exit

# Environment
set -gx BAT_THEME TwoDark
set -gx EDITOR hx
set -gx FZF_DEFAULT_OPTS --marker="*" --preview-window=wrap
set -gx GIT_MERGE_AUTOEDIT no # accept default merge commit message
set -gx GIT_WORKSPACE ~/Code
set -gx LESS --ignore-case --Raw-control-chars --quit-if-one-screen
set -gx man_bold --bold $fish_color_command
set -gx man_standout --reverse $fish_color_search_match
set -gx man_underline --underline $fish_color_param
set -gx PAGER less
set -l socket ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
path is $socket && set -gx SSH_AUTH_SOCK $socket

set -Uq fish_features || set -U fish_features all
set -Uq fish_history || set -U fish_history (yadm config local.class)
string match -q "$TERM_PROGRAM" vscode && set -gx EDITOR code --wait
command -q docker podman || functions -e docker

# Daily update
up --auto

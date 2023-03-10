status is-login || exit

# Environment
set -gx BAT_THEME TwoDark
set -gx EDITOR hx
set -gx GIT_MERGE_AUTOEDIT no # accept default merge commit message
set -gx GIT_WORKSPACE ~/Code
set -gx LESS --ignore-case --Raw-control-chars --quit-if-one-screen
set -gx man_bold --bold $fish_color_command
set -gx man_standout --reverse $fish_color_search_match
set -gx man_underline --underline $fish_color_param
set -gx PAGER less

set -Uq fish_features || set -U fish_features all
string match -q "$TERM_PROGRAM" vscode && set -gx EDITOR code --wait
command -q delta || set -gx GIT_PAGER $PAGER
command -q docker || functions -e docker

# Daily update
up --auto

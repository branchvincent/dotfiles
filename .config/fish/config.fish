status is-login || exit

set -Uq fish_features || set -U fish_features all
command -q docker || functions -e docker

# Environment
set -gx BAT_THEME TwoDark
set -gx EDITOR vim
if command -q code
    set -gx EDITOR code --wait
else if command -q hx
    set -gx EDITOR hx
end
set -gx GIT_MERGE_AUTOEDIT no # accept default merge commit message
set -gx GIT_WORKSPACE ~/Code
set -gx LESS --ignore-case --Raw-control-chars --quit-if-one-screen
set -gx PAGER less
command -q delta || set -gx GIT_PAGER $PAGER

# Daily update
up --auto

# Custom keybindings

status is-interactive || exit

bind \cc 'commandline ""'
bind \cl "
clear; printf '\e[3J'; commandline -f repaint
if functions -q tide_prompt_at_bottom
    tide_prompt_at_bottom
end
"
bind \cg 'gh pr view --web &>/dev/null || gh repo view --web &>/dev/null'
bind \co workon
bind \cp 'workon --exec cd; commandline -f repaint'
bind \cu '
if not set -e GIT_DIR GIT_WORK_TREE
    set -gx GIT_DIR "$XDG_DATA_HOME/yadm/repo.git"
    set -gx GIT_WORK_TREE ~
end
commandline -f repaint
'
fzf_configure_bindings --directory=\cf

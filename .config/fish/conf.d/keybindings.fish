# Custom keybindings

status is-interactive || exit

bind \cc 'commandline ""'
bind \a 'gh pr view --web &>/dev/null || gh repo view --web &>/dev/null'
bind \cO workon
bind \cP 'workon --exec cd; commandline -f repaint'
bind \cU '
if not set -e GIT_DIR GIT_WORK_TREE
    set -gx GIT_DIR "$XDG_DATA_HOME/yadm/repo.git"
    set -gx GIT_WORK_TREE ~
end
commandline -f repaint
'

# Custom keybindings

status is-interactive || exit

bind \cc 'commandline ""' # Ctrl-C -> clear line
bind \cP '
if not set -e GIT_DIR GIT_WORK_TREE
    set -gx GIT_DIR "$XDG_DATA_HOME/yadm/repo.git"
    set -gx GIT_WORK_TREE ~
end
commandline -f repaint
'

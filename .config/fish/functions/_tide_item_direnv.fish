function _tide_item_direnv --description 'Show direnv status'
    set -q DIRENV_DIR || return
    set -l color yellow
    direnv status | string match -rq '^Found RC allowed false$' && set color brred
    tide_direnv_color=$color tide_direnv_bg_color=normal \
        _tide_print_item direnv ▼
end

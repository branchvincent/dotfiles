function _tide_item_direnv --description 'Show direnv status'
    set -q DIRENV_DIR || return
    set -q tide_direnv_color_denied && direnv status | string match -rq '^Found RC allowed false$' \
        && set -lx tide_direnv_color $tide_direnv_color_denied
    _tide_print_item direnv ▼
end

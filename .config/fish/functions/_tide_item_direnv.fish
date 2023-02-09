function _tide_item_direnv --description 'Show direnv status'
    set -q DIRENV_DIR || return
    set -q tide_direnv_denied_color && direnv status | string match -rq '^Found RC allowed false$' \
        && set -lx tide_direnv_color $tide_direnv_denied_color
    _tide_print_item direnv ▼
end

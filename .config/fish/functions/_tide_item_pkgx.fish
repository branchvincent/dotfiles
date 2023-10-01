function _tide_item_pkgx --description "Show pkgx status"
    set -q PKGX_DIR && string match -q "*:$PKGX_DIR/*:*" ":$PATH:" && _tide_print_item pkgx 󰶞
end

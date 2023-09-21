function _tide_item_tea --description "Show tea status"
    set -q TEA_DIR && string match -q "*:$TEA_DIR/*:*" ":$PATH:" && _tide_print_item tea 󰶞
end

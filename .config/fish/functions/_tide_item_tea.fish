function _tide_item_tea --description "Show tea status"
    set -q TEA_PREFIX && string match -q "*:$TEA_PREFIX/*:*" ":$PATH:" && _tide_print_item tea 󰶞
end

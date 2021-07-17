function _tide_sub_items --description "List available items"
    functions -a | string match -r '^_tide_item_(.*)' | while read -Ll func item
        set -l color green
        contains $item $tide_left_prompt_items $tide_right_prompt_items || set color yellow
        printf "%-30s %s\n" (set_color $color)$item(set_color normal) (desc $func | string replace "n/a" "")
    end
end

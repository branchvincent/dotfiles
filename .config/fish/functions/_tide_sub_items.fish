function _tide_sub_items --description "List available items"
    argparse p/preview -- $argv || return

    functions -a | string match -r '^_tide_item_(.*)' | while read -Ll func item
        set -l color green
        contains $item $tide_left_prompt_items $tide_right_prompt_items || set color yellow
        set -l output
        if set -q _flag_preview
            set output (fish -c 'tide_'$item'_always_display=1 _tide_item_'$item'' 2>/dev/null || echo (set_color red)err)
        end
        printf "%-26s %-35s %s\n" (set_color $color)$item(set_color normal) (desc $func | string replace "n/a" "") $output(set_color normal)
    end
end

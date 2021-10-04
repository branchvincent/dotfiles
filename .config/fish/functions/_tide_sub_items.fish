complete tide -x -n __fish_use_subcommand -a items -d "List available items"
complete tide -x -n '__fish_seen_subcommand_from items' -a "(functions -a | string match -rg '^_tide_item_(.*)')"

function _tide_sub_items --description "List available items"
    argparse p/preview t/timings -- $argv || return

    if set -q argv[1]
        __tide_show_item "$argv[1]"
    else
        __tide_show_items
    end
end

function __tide_show_item -a item --no-scope-shadowing
    not functions -q _tide_item_$item && fish_log -e "$item not found" && return 1

    if set -q _flag_preview
        set -lx tide_"$item"_always_display 1
        printf "%-20s %s\n" preview (_tide_item_$item | string trim)
        set_color reset
    end

    printf "%-20s %s\n" state (__tide_item_state $item)

    set -n | string match -r '^tide_'$item'_(.*)$' | while read -Ll var config
        set -l value $$var
        string match -q '*color*' $config && set value (set_color $value)$value(set_color normal)
        printf "%-20s %s\n" $config "$value"
    end
end

function __tide_show_items --no-scope-shadowing
    functions -a | string match -r '^_tide_item_(.*)' | while read -Ll func item
        set -l color green
        contains $item $tide_left_prompt_items $tide_right_prompt_items || set color yellow
        set -l output
        if set -q _flag_preview
            set output (fish -c 'tide_'$item'_always_display=1 _tide_item_'$item'' 2>/dev/null || echo (set_color red)err)
        end
        printf "%-16s %-35s %s\n" $item (__tide_item_state $item | string sub -l 35) $output(set_color normal)
    end
end

function __tide_item_state -a item
    if not contains $item $tide_left_prompt_items $tide_right_prompt_items
        echo (set_color red)off(set_color reset)
        return
    end

    set -l var tide_show_"$item"_on
    if set -q $var
        echo (set_color yellow)dynamic(set_color reset) #"(""$$var"")"
    else
        echo (set_color green)on(set_color reset)
    end
end

function fish_log --description "Logger for fish scripts"
    argparse "i/info" "w/warn" "e/error" -- $argv || return

    if set -q _flag_error
        echo (set_color red)"Error: "(set_color normal)"$argv"
    else if set -q _flag_warn
        echo (set_color yellow)"Warning: "(set_color normal)"$argv"
    else
        echo (set_color green)"$argv"(set_color normal)
    end
end

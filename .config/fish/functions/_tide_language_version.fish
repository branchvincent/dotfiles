function _tide_language_version
    argparse --stop-nonopt "c/color=" "i/icon=" -- $argv || return
    set -l v ($argv 2>&1 | string match -r "\d+\.\d+\.\d+")
    set -q _flag_color[1] || set _flag_color 00AFAF
    set -l item $argv[1]
    set -g tide_"$item"_color $_flag_color
    set -g tide_"$item"_bg_color normal
    _tide_print_item $item $_flag_icon' ' $v
end

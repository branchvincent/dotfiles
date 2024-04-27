function _tide_item_python --description 'Show Python version'
    set -l context ''
    if set -q VIRTUAL_ENV
        path dirname $VIRTUAL_ENV | path resolve | read -l dirname
        path basename $dirname | read -l basename
        contains -- $dirname (path resolve $_tide_parent_dirs) || set context (set_color bryellow)"  $basename"
    else if path is $_tide_parent_dirs/{pyproject.toml,setup.py}
        set context (set_color bryellow)" "
    else
        return
    end
    _tide_print_item python $tide_python_icon' ' (python3 --version | string match -r "[\d.]+")$context
end

# TODO: send upstream
function _tide_parent_dirs --on-variable PWD
    set -g _tide_parent_dirs (string escape (
        for dir in (string split / -- $PWD)
            set -fa parts $dir
            string join / -- $parts
        end))
end

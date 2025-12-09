test -d ~/.config/work/fish || return

set --prepend fish_complete_path ~/.config/work/fish/completions
set --prepend fish_function_path ~/.config/work/fish/functions
for file in ~/.config/work/fish/conf.d/*.fish
    builtin source $file 2>/dev/null
end

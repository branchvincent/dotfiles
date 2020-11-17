# Fisher: https://github.com/jorgebucaran/fisher

# Isolate fisher-managed packages
set -g fisher_path $XDG_DATA_HOME/fish/vendor
set -p fish_function_path $fish_function_path[1] $fisher_path/functions
set -p fish_complete_path $fish_complete_path[1] $fisher_path/completions

# Install
if not functions -q fisher && status is-login
    curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
end

# Source conf.d snippets
for file in $fisher_path/conf.d/*.fish
    builtin source $file 2>/dev/null
end

# Fisher: https://github.com/jorgebucaran/fisher

# Isolate fisher-managed packages
set -g fisher_path $XDG_DATA_HOME/fisher
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

# Install
if not functions -q fisher && status is-interactive
    # Ensure we are noninteractive to avoid tide's prompt to configure
    set -l fish (status fish-path)
    $fish -c 'curl -sL git.io/fisher | source && fisher update >/dev/null'
end

# Source conf.d snippets
for file in $fisher_path/conf.d/*.fish
    builtin source $file 2>/dev/null
end

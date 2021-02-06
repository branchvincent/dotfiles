# https://github.com/IlanCosman/tide

# Configure prompt items
set -g tide_left_prompt_items pwd git newline prompt_char
set -g tide_right_prompt_items status cmd_duration context jobs k8s node python rust direnv

# Define custom prompt items
function _tide_item_direnv
    set -q DIRENV_DIR && echo (set_color yellow)▼
end

function _tide_item_k8s
    set -l namespace /(kubens --current)
    test $namespace = "/default" && set namespace ""
    echo (set_color magenta)⎈ (kubectl config current-context)$namespace
end

function _tide_item_node
    test -f package.json && echo (set_color 00AFAF)⬢ (node --version | string replace v "")
end

function _tide_item_python
    set -q VIRTUAL_ENV && echo (set_color 00AFAF) (python --version | string replace "Python " "")
end

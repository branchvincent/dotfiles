function _tide_item_node --description 'Show Node version'
    if set -q tide_node_always_display || test -f package.json
        _tide_language_version -i⬢ node --version
    end
end

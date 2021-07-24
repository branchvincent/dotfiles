function _tide_item_python --description 'Show Python version'
    if set -q tide_python_always_display || test -n "$VIRTUAL_ENV" -o -f pyproject.toml -o -f setup.py
        _tide_language_version -i python --version
    end
end

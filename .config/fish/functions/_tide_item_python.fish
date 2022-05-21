function _tide_item_python --description 'Show Python version'
    if set -q tide_python_always_display || test -n "$VIRTUAL_ENV" -o -f pyproject.toml -o -f setup.py
        test -n "$VIRTUAL_ENV" && set color 4584B6 || set color red
        _tide_language_version -i -c$color python3 --version
    end
end

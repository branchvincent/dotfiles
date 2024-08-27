function __fish_pytest
    pytest -c /dev/null --disable-warnings --collect-only $argv 2>/dev/null
end

function __fish_pytest_files
    __fish_pytest -qq | string replace -r ': (\d+)' '\t$1 tests'
end

function __fish_pytest_cases
    __fish_pytest -q | string split -f1 '[' | uniq -c | string replace -r '\s+(\d+) (.*)' '$2\t$1 tests'
end

function __fish_pytest_ids
    __fish_pytest -q
end

# FIXME: builtin completions don't work?
# complete pytest -fa '(__fish_argcomplete_complete pytest)'
complete pytest -fa '(__fish_pytest_files)'
complete pytest -f -n 'string match "*::*" -- (commandline -ct)' -a '(__fish_pytest_cases)'
complete pytest -f -n 'string match "*::*[*" -- (commandline -ct)' -a '(__fish_pytest_ids)'

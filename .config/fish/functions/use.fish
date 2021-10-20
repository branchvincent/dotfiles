function use --description "Manage language versions"
    argparse h/help i/installed -- $argv || return

    if set -q _flag_help
        __use_help
    else if functions -q __use_$argv[1]
        set -l lang $argv[1]
        set -l fzf_opts --exact --no-sort --tac --layout=reverse --border --height=90%
        set -l ver (__use_$lang)
        if test $status -eq 0
            echo "use $lang $ver" >.envrc
            direnv allow
        end
    else
        fish_log -e "Unknown language '$argv[1]'"
        return 1
    end
end

function __use_help --description "Print this help message"
    echo "\
Usage: use [options] command

  "(desc v)"

Options:
  -h, --help       "(desc __use_help)"
  -i, --installed  Use installed version

Commands:"
    for cmd in (functions -a | string replace -rf "^__use_(?!help)" "")
        printf "  %-13""s %s\n" $cmd (desc __use_$cmd)
    end
end

function __use_java --description Java --no-scope-shadowing
    set -l cmd ls-remote
    set -q _flag_installed && set cmd ls
    jabba $cmd | string match -rg 'openjdk@1.(\S+)' | fzf $fzf_opts
end

function __use_nodejs --description Node --no-scope-shadowing
    set -l cmd ls-remote
    set -q _flag_installed && set cmd ls
    fnm $cmd | string match -r '\d+\.\d+\.\d+' | fzf $fzf_opts
end

function __use_python --description Python --no-scope-shadowing
    set -l cmd install --list
    set -q _flag_installed && set cmd versions
    pyenv $cmd | string match -r '^\W+3\.\d+\.\d+' | string trim | fzf $fzf_opts
end

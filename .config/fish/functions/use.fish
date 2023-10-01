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

  "(desc use)"

Options:
  -h, --help       "(desc __use_help)"
  -i, --installed  Use installed version

Commands:"
    for cmd in (functions -a | string replace -rf "^__use_(?!pkgx|help)" "")
        printf "  %-13""s %s\n" $cmd (desc __use_$cmd)
    end
end

function __use_pkgx -a pkg --no-scope-shadowing
    if set -q _flag_installed
        path filter --type=dir $PKGX_DIR/$pkg/* | string match -r '\d+\.\d+\.\d+'
    else
        set -l os (uname | string lower)
        set -l arch (uname -m | string replace "arm64" "aarch64")
        curl -fsSL https://dist.pkgx.dev/$pkg/$os/$arch/versions.txt
    end
end

function __use_nodejs --description Node --no-scope-shadowing
    __use_pkgx nodejs.org | fzf $fzf_opts
end

function __use_python --description Python --no-scope-shadowing
    __use_pkgx python.org | fzf $fzf_opts
end

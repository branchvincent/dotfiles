function pvm --description "Python version manager"
    argparse --stop-nonopt h/help -- $argv || return

    mkdir -p ~/.local/share/pvm/

    if set -q _flag_help || not set -q argv[1]
        __pvm_help
    else if functions -q __pvm_$argv[1]
        __pvm_$argv[1] $argv[2..]
    else
        fish_log -e "Unknown command '$argv[1]'"
        return 1
    end
end

function __pvm_help --description "Print this help message"
    echo "\
Usage: pvm [options] command

  "(desc pvm)"

Options:
  -h, --help    "(desc __pvm_help)"

Commands:"
    for cmd in (functions -a | string replace -rf "^__pvm_(?!help)" "")
        printf "  %-13""s %s\n" $cmd (desc __pvm_$cmd)
    end
end

function __pvm_ls --description "List local versions"
    command ls ~/.local/share/pvm/ | string split " " || true
end

function __pvm_ls-remote --description "List remote versions"
    # TODO
    fish_log -w "Not implemented"
end

function __pvm_install --description "Install a version"
    set -q argv[1] && set v $argv[1] || set v 3.10.4
    set dest ~/.local/share/pvm/$v
    mkdir -p $dest
    # TODO: map version -> url
    curl --location --progress-bar https://github.com/indygreg/python-build-standalone/releases/download/20220528/cpython-$v+20220528-aarch64-apple-darwin-install_only.tar.gz | tar -xzC $dest
end

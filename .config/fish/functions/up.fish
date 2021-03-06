function up --description "Update software to the latest version"
    argparse --stop-nonopt h/help -- $argv || return

    if set -q _flag_help
        __up_help
    else if not set -q argv[1]
        __up_all
    else if functions -q __up_$argv[1]
        __up_$argv[1] $argv[2..]
    else
        fish_log -e "Unknown command '$argv[1]'"
        return 1
    end
end

function __up_help --description "Print this help message"
    echo "\
Usage: up [options] command

  "(desc up)"

Options:
  -h, --help    "(desc __up_help)"

Commands:"
    for cmd in (functions -a | string replace -rf "^__up_(?!help)" "")
        printf "  %-13""s %s\n" $cmd (desc __up_$cmd)
    end
end

function __up_all --description "Update everything"
    for cmd in (functions -a | string replace -rf "^__up_(?!all|help)" "")
        fish_log "Updating $cmd..."
        __up_$cmd
        echo
    end
end

function __up_brew --description "Update Homebrew and its packages"
    brew upgrade -q
    brew autoremove -q
    brew cleanup -q
    brew doctor
end

function __up_dotfiles --description "Update dotfiles"
    # Update repo
    yadm pull --quiet

    # Update package lists
    brew bundle dump --force
    code --list-extensions >$XDG_CONFIG_HOME/code/extensions.txt
    pipx list --json | jq -r '.venvs | keys[]' >$XDG_CONFIG_HOME/pipx/packages.txt

    # Trash non-xdg cache
    for path in ~/.{bash_history,docker,k3d,k8slens,kube}
        test -e $path && trash $path
    end
    # Trash Google Drive's folder icon
    if test -f ~/Documents/Icon\r
        trash ~/Documents/Icon\r
        for icn in "/Applications/Backup and Sync.app/Contents/Resources"**/folder-mac-yosemite.icns
            sudo mv $icn $icn.bak
        end
        trash /var/folders/*/*/*/com.apple.dock.iconcache
        killall Dock
    end

    echo "Everything is up-to-date"
end

function __up_gcloud --description "Update gcloud components"
    gcloud components update --quiet
end

function __up_mas --description "Update apps from App Store"
    mas upgrade
end

function __up_os --description "Update macOS"
    softwareupdate --install --all
end

function __up_pipx --description "Update pipx packages"
    pipx upgrade-all
end

function __up_rust --description "Update Rust components"
    rustup update
end

function __up_shell --description "Update shell packages and completions"
    fisher update >/dev/null
    fish_update_completions >/dev/null
    echo "Everything is up-to-date"
end

function __up_tex --description "Update LaTeX packages"
    tlmgr update --self --all --reinstall-forcibly-removed >/dev/null
    echo "Everything is up-to-date"
end

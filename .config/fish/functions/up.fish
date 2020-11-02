function up --description "Update software to the latest version"
    argparse --stop-nonopt "h/help" -- $argv || return

    if set -q _flag_help
        __up_help
    else if not set -q argv[1]
        __up_all
    else if functions -q __up_$argv[1]
        __up_$argv[1] $argv[2..-1]
    else
        fish_log -e "Unknown command '$argv[1]'"
        return 1
    end
end

function __up_help --description "Print this help message"
    set -l cmd (set_color $fish_color_command)
    set -l param (set_color $fish_color_param)
    set -l n (set_color normal)

    echo "\
Usage:$cmd up$n [options]$param command$n

  "(desc up)"

Options:
  -h, --help    "(desc __up_help)"

Commands:"
    for cmd in (functions -a | string replace -f "__up_" "")
        printf "  %-13""s %s\n" $cmd (desc __up_$cmd)
    end
end

function __up_all --description "Update everything"
    set -l ignored all help
    for cmd in (functions -a | string replace -f "__up_" "")
        contains $cmd $ignored && continue
        fish_log "Updating $cmd..."
        __up_$cmd
        echo
    end
end

function __up_brew --description "Update Homebrew and its packages"
    brew upgrade
    brew cleanup
    brew doctor
end

function __up_cmpl --description "Update fish completions"
    fish_update_completions
end

function __up_dotfiles --description "Update dotfiles"
    # Update repo
    yadm pull --quiet

    # Update package lists
    brew bundle dump --force
    code --list-extensions >$XDG_CONFIG_HOME/code/extensions.txt
    ls $PIPX_HOME/venvs >$XDG_CONFIG_HOME/pipx/packages.txt

    # Trash non-xdg cache
    for path in ~/.{bash_history,docker,k3d,kube}
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

    # Output local modifications
    yadm status --short --untracked-files=normal

    echo "Everything is up-to-date"
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

function __up_tex --description "Update LaTeX packages"
    tlmgr update --self --all
end

function up --description "Update software to the latest version"
    # Parse args
    argparse "h/help" -- $argv || return
    set -l cmds brew cmpl dotfiles mas os pipx tex
    set -q _flag_help && printf "Usage: up [-h] [%s]\n" (string join "|" $cmds) && return 0
    set -q argv[1] || set -l argv $cmds

    # Update everything
    for cmd in $argv
        test "$cmd" != "$argv[1]" && echo
        set -q argv[2] && fish_log "Updating $cmd..."
        switch $cmd
            case brew
                brew upgrade
                brew cleanup
                brew doctor
            case cmpl
                fish_update_completions
            case dotfiles
                # Update repo
                yadm pull --quiet
                # Update package lists
                brew bundle dump --force
                code --list-extensions >$XDG_CONFIG_HOME/code/extensions.txt
                pipx list | grep "   package " | cut -d' ' -f5 >$XDG_CONFIG_HOME/pipx/packages.txt
                # Output local modifications
                yadm status --short --untracked-files=normal
                # Take out the trash
                for path in ~/.{bash_history,docker,k3d,kube}
                    test -e $path && trash $path
                end
                echo "Everything is up-to-date"
            case mas
                mas upgrade
            case os
                softwareupdate --install --all
            case pipx
                pipx upgrade-all
            case tex
                tlmgr update --self --all
            case \*
                fish_log -e "Unknown command '$cmd'" && return 1
        end
    end
end

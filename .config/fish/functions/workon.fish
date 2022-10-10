function workon --description "Open a project"
    argparse --stop-nonopt exec= -- $argv || return
    if set -q _flag_exec
        set cmd $_flag_exec
    else
        set cmd code
    end

    set taps (string replace $HOMEBREW_PREFIX/Library/Taps/ ./  $HOMEBREW_PREFIX/Library/Taps/*/*)
    set choices ./homebrew/brew $taps (git workspace list)
    set chosen (string split ' ' $choices | sort -u | fzf -q "$argv")
    set -e GIT_DIR GIT_WORK_TREE
    switch "$chosen"
        case ./branchvincent/dotfiles
            set -gx GIT_DIR "$XDG_DATA_HOME/yadm/repo.git"
            set -gx GIT_WORK_TREE ~
            $cmd ~
        case ./homebrew/brew
            $cmd $HOMEBREW_REPOSITORY
        case $taps
            $cmd $HOMEBREW_PREFIX/Library/Taps/$chosen
        case ''
            return
        case \*
            $cmd $GIT_WORKSPACE/$chosen
    end
end

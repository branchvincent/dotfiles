function workon --description "Open a project"
    set taps (string replace $HOMEBREW_PREFIX/Library/Taps/ ./  $HOMEBREW_PREFIX/Library/Taps/*/*)
    set choices ./homebrew/brew $taps (git workspace list)
    set chosen (string split ' ' $choices | sort -u | fzf -q "$argv")
    switch "$chosen"
        case ./branchvincent/dotfiles
            yadm enter code ~
        case ./homebrew/brew
            env -u GIT_DIR -u GIT_WORK_TREE code $HOMEBREW_REPOSITORY
        case $taps
            env -u GIT_DIR -u GIT_WORK_TREE code $HOMEBREW_PREFIX/Library/Taps/$chosen
        case ''
            return
        case \*
            env -u GIT_DIR -u GIT_WORK_TREE code $GIT_WORKSPACE/$chosen
    end
end

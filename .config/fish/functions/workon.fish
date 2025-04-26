function workon --description "Open a project"
    string replace "$HOMEBREW_REPOSITORY"/Library/Taps/ ./ $HOMEBREW_REPOSITORY/Library/Taps/*/* | read -laz taps
    set choices ./homebrew/brew $taps (git workspace list 2>/dev/null)
    set chosen (string split ' ' $choices | sort -u | fzf -q "$argv")

    if string length -q -- (commandline)
        set cmd commandline --current-token --replace
    else if string match -q ./branchvincent/dotfiles "$chosen"
        set cmd yadm enter code
    else
        set cmd env -u GIT_DIR -u GIT_WORK_TREE code
    end

    switch "$chosen"
        case ./branchvincent/dotfiles
            $cmd ~
        case ./homebrew/brew
            $cmd $HOMEBREW_REPOSITORY
        case $taps
            $cmd $HOMEBREW_REPOSITORY/Library/Taps/$chosen
        case ''
            return
        case \*
            $cmd $GIT_WORKSPACE/$chosen
    end
end

function workon --description "Open a project"
    set -e GIT_DIR GIT_WORK_TREE || true
    set choices ./Homebrew/homebrew-{cask,core} (git workspace list)
    set chosen (echo $choices | string split ' ' | fzf -q "$argv")
    switch "$chosen"
        case ./branchvincent/dotfiles
            yadm enter code ~
        case ./Homebrew/homebrew-\* ./branchvincent/homebrew-tap
            code $HOMEBREW_PREFIX/Library/Taps(string trim --left --chars=. $chosen)
        case ''
            return
        case \*
            code $GIT_WORKSPACE/$chosen
    end
end

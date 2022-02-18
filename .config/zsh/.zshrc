### Z4H ###
# https://github.com/romkatv/zsh4humans/blob/v5/README.md
zstyle ':z4h:' auto-update 'yes'
zstyle ':z4h:' auto-update-days '7'
zstyle ':z4h:' prompt-at-bottom 'yes'
zstyle ':z4h:bindkey' keyboard 'mac'
zstyle ':z4h:' term-shell-integration 'no'
zstyle ':z4h:autosuggestions' forward-char 'accept'
zstyle ':z4h:fzf-complete' recurse-dirs 'no'
zstyle ':z4h:direnv' enable 'yes'
zstyle ':z4h:direnv:success' notify 'no'
zstyle ':z4h:ssh:*' enable 'no'
z4h init || return

### Env ###
export HISTFILE="$XDG_DATA_HOME/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

### Key bindings ###
z4h bindkey undo Ctrl+/ Shift+Tab      # undo the last command line change
z4h bindkey redo Option+/              # redo the last undone command line change
z4h bindkey z4h-cd-back Shift+Left     # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right # cd into the next directory
z4h bindkey z4h-cd-up Shift+Up         # cd into the parent directory
z4h bindkey z4h-cd-down Shift+Down     # cd into a child directory

### Shell options ###
# https://zsh.sourceforge.io/Doc/Release/Options.html
setopt glob_dots    # no special treatment for file names with a leading dot
setopt no_auto_menu # require an extra TAB press to open the completion menu

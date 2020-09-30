# shellcheck shell=bash
# NOTE: lying to shellcheck https://github.com/koalaman/shellcheck/issues/809

__maybe_source() {
    [[ -r "$1" ]] && source "$1"
}

### Theme ###
__maybe_source ~/.cache/p10k-instant-prompt-"$USER".zsh
__maybe_source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
__maybe_source ~/.config/zsh/.p10k.zsh

### Env ###
export HISTFILE="$XDG_DATA_HOME/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

### Plugins ###
__maybe_source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
__maybe_source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
__maybe_source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
eval "$(direnv hook zsh)"

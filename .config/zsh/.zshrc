__maybe_source() {
  [[ -r "$1" ]] && source "$1"
}

### Theme ###
__maybe_source ~/.cache/p10k-instant-prompt-"$USER".zsh
__maybe_source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
__maybe_source ~/.config/zsh/p10k.zsh

### Env ###
export HISTFILE="$XDG_DATA_HOME/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

### Completions ###
fpath+=($XDG_CONFIG_HOME/zsh/completions)
mkdir -p "$XDG_CACHE_HOME/zsh"
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
autoload -Uz bashcompinit && bashcompinit

### Plugins ###
for plugin in autosuggestions syntax-highlighting history-substring-search; do
  __maybe_source /usr/local/share/zsh-$plugin/zsh-$plugin.zsh
done
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
eval "$(direnv hook zsh)"

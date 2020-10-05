# Abbreviations and aliases

status is-interactive || exit

### Abbreviations ###
abbr -ag b "brew"
abbr -ag d "docker"
abbr -ag dc "docker-compose"
abbr -ag df "yadm enter code ~"
abbr -ag dprune "docker system prune --all --volumes --force"
abbr -ag dstop "docker ps --quiet | xargs docker stop"
abbr -ag g "git"
abbr -ag h "helm"
abbr -ag k "kubectl"
abbr -ag kc "kubectx"
abbr -ag kn "kubens"
abbr -ag n "npm"
abbr -ag p "poetry"
abbr -ag py "python3"
abbr -ag urldecode "string unescape --style=url"
abbr -ag urlencode "string escape --style=url"
abbr -ag y "yadm"

### Aliases ###
alias cat "bat"
alias clrfmt "pbpaste | pbcopy" # clear formatting from clipboard
alias ls "exa"
alias ll "exa --long"
alias la "exa --long --all"
alias lg "exa --long --all --git --git-ignore"
alias lt "exa --tree"
alias preview "fzf --preview 'bat --color always {}'"
alias prvkey "pbcopy <$XDG_CONFIG_HOME/ssh/id_rsa | echo Private key copied to clipboard!"
alias pubkey "pbcopy <$XDG_CONFIG_HOME/ssh/id_rsa.pub | echo Public key copied to clipboard!"
alias reload "exec fish"

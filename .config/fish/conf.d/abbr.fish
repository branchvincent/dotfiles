# Abbreviations and aliases

status is-interactive || exit

### Abbreviations ###
abbr -ag b brew
abbr -ag d docker
abbr -ag dc "docker compose"
abbr -ag dprune "docker system prune --all --volumes --force"
abbr -ag drun "docker run --rm -it"
abbr -ag dstop "docker ps --quiet | xargs docker stop"
abbr -ag g git
abbr -ag k kubectl
abbr -ag kc kubectx
abbr -ag kn kubens
abbr -ag p poetry
abbr -ag pc pbcopy
abbr -ag pp pbpaste
abbr -ag py python3
abbr -ag urldecode "string unescape --style=url"
abbr -ag urlencode "string escape --style=url"

### Aliases ###
alias cat bat
alias ls exa
alias ll "exa --header --long"
alias la "exa --header --long --all"
alias lg "exa --header --long --all --git --git-ignore"
alias lt "exa --tree --level=2"
alias rm trash
alias top glances
alias watch viddy

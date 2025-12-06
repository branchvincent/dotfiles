# Abbreviations and aliases

status is-interactive || exit

### Abbreviations ###
abbr b brew
abbr d docker
abbr dc "docker compose"
abbr dprune "docker system prune --all --volumes --force"
abbr drun "docker run --rm -it"
abbr dstop "docker ps --quiet | xargs docker stop"
abbr g git
abbr k kubectl
abbr kc kubectx
abbr kn kubens
abbr p poetry
abbr pc pbcopy
abbr pp pbpaste
abbr py python3
abbr urldecode "string unescape --style=url"
abbr urlencode "string escape --style=url"
abbr y yadm

### Aliases ###
function _alias
    command -q $argv[2] && alias $argv
end
_alias cat bat
command -q docker || _alias docker podman
_alias hg chg
if command -q lsd
    alias ls "lsd --icon=never"
    alias ll "ls -l --header --date=relative --blocks=permission,size,user,date,name"
    alias la "ll -A"
    alias lt "ls --tree --depth=2"
end
_alias rm trash
_alias top glances
alias yadmp "yadm --yadm-repo ~/.local/share/yadm/repo-private.git"

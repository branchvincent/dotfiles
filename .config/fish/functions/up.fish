function up --description "Update software to the latest version"
    argparse --stop-nonopt h/help auto -- $argv || return

    if set -q _flag_help
        __up_help
    else if set -q _flag_auto
        __up_auto
    else if not set -q argv[1]
        __up_all
    else if functions -q __up_$argv[1]
        __up_$argv[1] $argv[2..]
    else
        fish_log -e "Unknown command '$argv[1]'"
        return 1
    end
end

function __up_help --description "Print this help message"
    echo "\
Usage: up [options] command

  "(desc up)"

Options:
  -h, --help    "(desc __up_help)"

Commands:"
    for cmd in (functions -a | string replace -rf "^__up_(?!auto|help)" "")
        printf "  %-13""s %s\n" $cmd (desc __up_$cmd)
    end
end

function __up_auto --description "Update everything daily"
    status is-login && status is-interactive || return
    set -l file ~/.cache/fish/last-updated
    if [ -e "$file" ] && find "$file" -mtime +1d | not string match -q "$file"
        return
    end
    __up_all
    set -l fish (status fish-path)
    exec "$fish" -il
end

function __up_all --description "Update everything"
    mkdir -p ~/.cache/fish
    touch ~/.cache/fish/last-updated
    for cmd in (functions -a | string replace -rf "^__up_(?!all|auto|docker|help)" "")
        echo (set_color blue)"dotfiles"(set_color normal): updating (set_color --bold)$cmd(set_color normal) >&2
        __up_$cmd
    end
end

function __up_apt --description "Update apt packages"
    sudo apt update -qqq
    sudo apt upgrade -qqq
    sudo apt autoremove -qqq
end

function __up_brew --description "Update Homebrew packages"
    brew upgrade -q
    brew autoremove -q
    brew cleanup -q
    brew doctor -q >/dev/null # FIXME
end

function __up_docker --description "Update Docker images"
    docker images --format '{{.Repository}}:{{.Tag}}' | xargs -n1 docker pull -q
    docker system prune -f
end

function __up_dotfiles --description "Update dotfiles"
    # Update repo
    yadm pull -q

    # Update package lists
    type -q brew && brew bundle dump --force
    type -q code && code --list-extensions >$XDG_CONFIG_HOME/code/extensions.txt
    type -q pipx && pipx list --json 2>/dev/null | jq -r '.venvs | values[].metadata.main_package.package_or_url' >$XDG_CONFIG_HOME/pipx/packages.txt

    # Trash non-xdg cache
    command rm -rf ~/.{android,bash_history,bundle,config/configstore,docker,k3d,k8slens,kube,node,npm,rustup,yarnrc}
end

function __up_fisher --description "Update fish packages and completions"
    fisher update >/dev/null
    fish_update_completions >/dev/null
end

function __up_gcloud --description "Update gcloud components"
    gcloud components update -q &>/dev/null
end

function __up_git --description "Update git repositories"
    git workspace update &>/dev/null
    env -u GIT_DIR -u GIT_WORK_TREE git workspace switch-and-pull &>/dev/null
    git workspace run touch .envrc &>/dev/null
end

function __up_mas --description "Update apps from App Store"
    mas outdated | grep -q " " && mas upgrade
end

function __up_os --description "Update macOS"
    softwareupdate --list &| grep -q "No new" || softwareupdate --install --all
end

function __up_pipx --description "Update pipx packages"
    pipx upgrade-all >/dev/null
end

function __up_rustup --description "Update Rust components"
    rustup check &| grep -q available && rustup update
end

function __up_tea --description "Update tea"
    env -u GIT_DIR -u GIT_WORK_TREE tea --sync --silent +tea.xyz true
end

# Remove any unfound items
for item in (functions -a | string replace -rf "^__up_(?!all|auto|help)" "")
    set -l cmd $item
    switch $item
        case apt
            set cmd apt-get
        case dotfiles
            set cmd yadm
        case git
            set cmd git-workspace
        case os
            set cmd softwareupdate
    end
    type -q $cmd || functions -e __up_$item
end

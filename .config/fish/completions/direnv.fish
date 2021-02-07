# Options
complete -c direnv -f
complete -c direnv -n __fish_use_subcommand -l help -d "Show this help"
complete -c direnv -n __fish_use_subcommand -l version -a version -d "Show the version"

# Commands
complete -c direnv -n __fish_use_subcommand -a allow -d "Allow loading .envrc"
complete -c direnv -n __fish_use_subcommand -a deny -d "Deny loading .envrc"
complete -c direnv -n __fish_use_subcommand -a edit -d "Edit and load .envrc"
complete -c direnv -n __fish_use_subcommand -a exec -d "Load .envrc and execute a command"
complete -c direnv -n __fish_use_subcommand -a fetchurl -d "Fetch a given URL into direnv's CAS"
complete -c direnv -n __fish_use_subcommand -a help -d "Show this help"
complete -c direnv -n __fish_use_subcommand -a hook -d "Print the shell hook"
complete -c direnv -n __fish_use_subcommand -a prune -d "Remove old allowed files"
complete -c direnv -n __fish_use_subcommand -a reload -d "Trigger an env reload"
complete -c direnv -n __fish_use_subcommand -a status -d "Print debug information"
complete -c direnv -n __fish_use_subcommand -a stdlib -d "Print the stdlib"
complete -c direnv -n __fish_use_subcommand -a version -d "Show the version"

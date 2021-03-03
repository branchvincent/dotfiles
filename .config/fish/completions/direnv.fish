# Options
complete direnv -f
complete direnv -n __fish_use_subcommand -l help -d "Show this help"
complete direnv -n __fish_use_subcommand -l version -a version -d "Show the version"

# Commands
complete direnv -n __fish_use_subcommand -a allow -d "Allow loading .envrc"
complete direnv -n __fish_use_subcommand -a deny -d "Deny loading .envrc"
complete direnv -n __fish_use_subcommand -a edit -d "Edit and load .envrc"
complete direnv -n __fish_use_subcommand -a exec -d "Load .envrc and execute a command"
complete direnv -n __fish_use_subcommand -a fetchurl -d "Fetch a given URL into direnv's CAS"
complete direnv -n __fish_use_subcommand -a help -d "Show this help"
complete direnv -n __fish_use_subcommand -a hook -d "Print the shell hook"
complete direnv -n __fish_use_subcommand -a prune -d "Remove old allowed files"
complete direnv -n __fish_use_subcommand -a reload -d "Trigger an env reload"
complete direnv -n __fish_use_subcommand -a status -d "Print debug information"
complete direnv -n __fish_use_subcommand -a stdlib -d "Print the stdlib"
complete direnv -n __fish_use_subcommand -a version -d "Show the version"

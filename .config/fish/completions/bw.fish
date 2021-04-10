function __fish_list_item_names
    bw list items | jq -r .[].name
end

# Options
complete bw -f
complete bw -l pretty -d "Format output. JSON is tabbed with two spaces"
complete bw -l raw -d "Return raw output instead of a descriptive message"
complete bw -l response -d "Return a JSON formatted version of response output"
complete bw -l quiet -d "Don't return anything to stdout"
complete bw -l nointeraction -d "Do not prompt for interactive user input"
complete bw -l session -d "Pass session key instead of reading from env"
complete bw -s v -l version -d "output the version number"
complete bw -s h -l help -d "output usage information"

# Commands

# completion
complete bw -n __fish_use_subcommand -a completion -d "Generate shell completions"
# TODO: [options]

# config
complete bw -n __fish_use_subcommand -a config -d "Configure CLI settings"
# TODO: [options]

# confirm
complete bw -n __fish_use_subcommand -a confirm -d "Confirm an object to the organization"
# TODO: [options]

# create
complete bw -n __fish_use_subcommand -a create -d "Create an object in the vault"
# TODO: [options]

# delete
complete bw -n __fish_use_subcommand -a delete -d "Delete an object from the vault"
# TODO: [options]

# edit
complete bw -n __fish_use_subcommand -a edit -d "Edit an object from the vault"
# TODO: [options]

# encode
complete bw -n __fish_use_subcommand -a encode -d "Base 64 encode stdin"

# export
complete bw -n __fish_use_subcommand -a export -d "Export vault data to a CSV or JSON file"
# TODO: [options]

# generate
complete bw -n __fish_use_subcommand -a generate -d "Generate a password/passphrase"
# TODO: [options]

# get
complete bw -n __fish_use_subcommand -a get -d "Get an object from the vault"
complete bw -n "__fish_seen_subcommand_from get item" -a '(__fish_list_item_names)'
# TODO: [options]

# import
complete bw -n __fish_use_subcommand -a import -d "Import vault data from a file"
# TODO: [options]

# list
complete bw -n __fish_use_subcommand -a list -d "List an array of objects from the vault"
# TODO: [options]

# lock
complete bw -n __fish_use_subcommand -a lock -d "Lock the vault and destroy active session keys"

# login
complete bw -n __fish_use_subcommand -a login -d "Log into a user account"
# TODO: [options]

# logout
complete bw -n __fish_use_subcommand -a logout -d "Log out of the current user account"

# restore
complete bw -n __fish_use_subcommand -a restore -d "Restores an object from the trash"

# share
complete bw -n __fish_use_subcommand -a share -d "Share an item to an organization"

# status
complete bw -n __fish_use_subcommand -a status -d "Show server, last sync, user information, and vault status"

# sync
complete bw -n __fish_use_subcommand -a sync -d "Pull the latest vault data from server"
# TODO: [options]

# unlock
complete bw -n __fish_use_subcommand -a unlock -d "Unlock the vault and return a new session key"
# TODO: [options]

# update
complete bw -n __fish_use_subcommand -a update -d "Check for updates"

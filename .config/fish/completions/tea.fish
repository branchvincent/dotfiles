function __fish_tea_bins
    set dir (tea --prefix)/tea.xyz/var/pantry/projects
    tea -s yq .provides "$dir"/**/package.yml | string match -rg -- '^- bin/([^{}]*)$'
end

function __fish_tea_packages
    set dir (tea --prefix)/tea.xyz/var/pantry/projects
    string match -rg "$dir/(.*)/package.yml" "$dir"/**/package.yml
end

function __fish_tea_complete_command -a bin
    set -l cmd (commandline -opc) (commandline -ct)
    set cmd $cmd[(contains -i -- "$bin" $cmd)..] # trim leading tea-specific args
    complete -C"$cmd"
end

complete tea -f

# Modes
complete tea -n __fish_use_subcommand -s h -l help -d 'print help'
complete tea -n __fish_use_subcommand -l magic -d 'print shell hook magic'
complete tea -n __fish_use_subcommand -l version -d 'print version'
complete tea -n __fish_use_subcommand -l prefix -d 'print prefix'
complete tea -n __fish_use_subcommand -l provides -d 'check if packages are provided'

# Flags
complete tea -n __fish_use_subcommand -s S -l sync -d 'sync pantries'
complete tea -n __fish_use_subcommand -s E -l env -d 'inject the local environment'
complete tea -n __fish_use_subcommand -s n -l dry-run -d 'don\'t execute, just print'
complete tea -n __fish_use_subcommand -s k -l keep-going -d 'keep going after errors'
complete tea -n __fish_use_subcommand -s v -l verbose -d 'enable verbosity'
complete tea -n __fish_use_subcommand -s s -l silent -d 'no chat, no errors'
complete tea -n __fish_use_subcommand -s C -l cd -d 'change directory first'
complete tea -n __fish_use_subcommand -l chaste -d 'abstain from networking'

# Packages
complete tea -f -n __fish_use_subcommand -a '(__fish_tea_bins)'
complete tea -f -n '__fish_use_subcommand && string match "+*" -- (commandline -ct)' -a '+(__fish_tea_packages)'
for bin in (__fish_tea_bins)
    complete tea -n "__fish_seen_subcommand_from $bin" -a '(__fish_tea_complete_command '(string escape $bin)')'
end

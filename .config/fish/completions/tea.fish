function __fish_tea_bins
    set dir $TEA_DIR/tea.xyz/var/pantry/projects
    tea --silent yq .provides "$dir"/**/package.yml | string match -rg -- '^- bin/([^{}]*)$'
end

function __fish_tea_packages
    set dir $TEA_DIR/tea.xyz/var/pantry/projects
    string match -rg "$dir/(.*)/package.yml" "$dir"/**/package.yml
end

function __fish_tea_complete_command -a bin
    set -l cmd (commandline -opc) (commandline -ct)
    set cmd $cmd[(contains -i -- "$bin" $cmd)..] # trim leading tea-specific args
    complete -C"$cmd"
end

complete tea -f

# Modes
complete tea -n __fish_use_subcommand -l help -d 'print help'
complete tea -n __fish_use_subcommand -l provider -d 'prints provider'
complete tea -n __fish_use_subcommand -l shell-completion -d 'prints shell completions'
complete tea -n __fish_use_subcommand -l shellcode -d 'print shellcode'
complete tea -n __fish_use_subcommand -l version -d 'print version'

# Flags
complete tea -n __fish_use_subcommand -l sync -d 'sync pantry'
complete tea -n __fish_use_subcommand -l update -d 'update the pkg env'
complete tea -n __fish_use_subcommand -l verbose -d 'enable verbosity'
complete tea -n __fish_use_subcommand -l silent -d 'no chat, no errors'
complete tea -n __fish_use_subcommand -l quiet -d 'minimal chat'

# Packages
complete tea -f -n __fish_use_subcommand -a '(__fish_tea_bins)'
complete tea -f -n 'string match "+*" -- (commandline -ct)' -a '+(__fish_tea_packages) +(__fish_tea_bins)'
for bin in (__fish_tea_bins)
    complete tea -n "__fish_seen_subcommand_from $bin" -a '(__fish_tea_complete_command '(string escape $bin)')'
end

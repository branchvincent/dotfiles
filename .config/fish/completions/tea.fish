function __fish_tea_bins
    set dir (tea --prefix)/tea.xyz/var/pantry/projects
    tea -s yq .provides "$dir"/**/package.yml | string match -rg -- '^- bin/([^{}]*)$'
end

function __fish_tea_packages
    set dir (tea --prefix)/tea.xyz/var/pantry/projects
    string match -rg "$dir/(.*)/package.yml" "$dir"/**/package.yml
end

complete tea -f

# Modes
complete tea -s h -l help -d 'print help'
complete tea -l magic -d 'print shell hook magic'
complete tea -l version -d 'print version'
complete tea -l prefix -d 'print prefix'

# Flags
complete tea -s S -l sync -d 'sync pantries'
complete tea -s E -l env -d 'inject the local environment'
complete tea -s n -l dry-run -d 'don\'t execute, just print'
complete tea -s k -l keep-going -d 'keep going after errors'
complete tea -s v -l verbose -d 'enable verbosity'
complete tea -s s -l silent -d 'no chat, no errors'
complete tea -s C -l cd -d 'change directory first'

# Packages
complete tea -f -a '(__fish_tea_bins)'
complete tea -f -n 'string match "+*" -- (commandline -ct)' -a '+(__fish_tea_packages)'

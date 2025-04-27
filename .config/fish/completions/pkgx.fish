function __fish_pkgx_data_dir
    path filter -d ~/Library/Application\ Support/pkgx ~/.local/share/pkgx
end

function __fish_pkgx_bins
    pkgx --query | string match -v '*{{*'
end

function __fish_pkgx_packages
    set -l dir (__fish_pkgx_data_dir)[1]/pantry/projects || return
    string match -rg "$dir/(.*)/package.yml" "$dir"/**/package.yml
end

function __fish_pkgx_complete_command -a bin
    set -l cmd (commandline -opc) (commandline -ct)
    set cmd $cmd[(contains -i -- "$bin" $cmd)..] # trim leading pkgx-specific args
    complete -C"$cmd"
end

complete pkgx -f

# Flags
complete pkgx -n __fish_use_subcommand -l help -d 'print help'
complete pkgx -n __fish_use_subcommand -l silent -d 'no chat, no errors'
complete pkgx -n __fish_use_subcommand -l version -d 'print version'
complete pkgx -n __fish_use_subcommand -s Q -l query -d 'query for packages'
complete pkgx -n __fish_use_subcommand -s j -l json -d 'json output'
complete pkgx -n __fish_use_subcommand -s q -l quiet -d 'minimal chat'

# Packages
complete pkgx -f -n __fish_use_subcommand -a '(__fish_pkgx_bins)'
complete pkgx -f -n 'string match "+*" -- (commandline -ct)' -a '+(__fish_pkgx_packages) +(__fish_pkgx_bins)'
for bin in (__fish_pkgx_bins)
    complete pkgx -n "__fish_seen_subcommand_from $bin" -a '(__fish_pkgx_complete_command '(string escape $bin)')'
end

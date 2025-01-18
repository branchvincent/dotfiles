function __fish_pkgx_cache_dir
    path filter -d ~/Library/Caches/pkgx ~/.cache/pkgx
end

function __fish_pkgx_bins
    set -l dir (__fish_pkgx_cache_dir)/pantry/projects || return
    pkgx --silent yq .provides "$dir"/**/package.yml | string match -rg -- '^- bin/([^{}]*)$'
end

function __fish_pkgx_packages
    set -l dir (__fish_pkgx_cache_dir)/pantry/projects || return
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
complete pkgx -n __fish_use_subcommand -s j -l json -d 'json output'
complete pkgx -n __fish_use_subcommand -s q -l quiet -d 'minimal chat'

# Packages
complete pkgx -f -n __fish_use_subcommand -a '(__fish_pkgx_bins)'
complete pkgx -f -n 'string match "+*" -- (commandline -ct)' -a '+(__fish_pkgx_packages) +(__fish_pkgx_bins)'
for bin in (__fish_pkgx_bins)
    complete pkgx -n "__fish_seen_subcommand_from $bin" -a '(__fish_pkgx_complete_command '(string escape $bin)')'
end

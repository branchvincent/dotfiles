function __fish_pkgx_bins
    set dir $PKGX_DIR/pantry/projects
    pkgx --silent yq .provides "$dir"/**/package.yml | string match -rg -- '^- bin/([^{}]*)$'
end

function __fish_pkgx_packages
    set dir $PKGX_DIR/pantry/projects
    string match -rg "$dir/(.*)/package.yml" "$dir"/**/package.yml
end

function __fish_pkgx_complete_command -a bin
    set -l cmd (commandline -opc) (commandline -ct)
    set cmd $cmd[(contains -i -- "$bin" $cmd)..] # trim leading pkgx-specific args
    complete -C"$cmd"
end

complete pkgx -f

# Modes
complete pkgx -n __fish_use_subcommand -l help -d 'print help'
complete pkgx -n __fish_use_subcommand -l provider -d 'prints provider'
complete pkgx -n __fish_use_subcommand -l shell-completion -d 'prints shell completions'
complete pkgx -n __fish_use_subcommand -l shellcode -d 'print shellcode'
complete pkgx -n __fish_use_subcommand -l version -d 'print version'

# Flags
complete pkgx -n __fish_use_subcommand -l sync -d 'sync pantry'
complete pkgx -n __fish_use_subcommand -l update -d 'update the pkg env'
complete pkgx -n __fish_use_subcommand -l verbose -d 'enable verbosity'
complete pkgx -n __fish_use_subcommand -l silent -d 'no chat, no errors'
complete pkgx -n __fish_use_subcommand -l quiet -d 'minimal chat'

# Packages
complete pkgx -f -n __fish_use_subcommand -a '(__fish_pkgx_bins)'
complete pkgx -f -n 'string match "+*" -- (commandline -ct)' -a '+(__fish_pkgx_packages) +(__fish_pkgx_bins)'
for bin in (__fish_pkgx_bins)
    complete pkgx -n "__fish_seen_subcommand_from $bin" -a '(__fish_pkgx_complete_command '(string escape $bin)')'
end

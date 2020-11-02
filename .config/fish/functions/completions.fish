function completions --description "Caches remote completions"
    set -l cmd $argv[1]
    set -l url $argv[2]

    set -l file $XDG_DATA_HOME/fish/downloaded_completions/$cmd.fish
    if not test -f $file
        mkdir -p (dirname $file)
        curl -fsSL $url --output $file
    end
    echo $file
end

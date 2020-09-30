function path_add --description "Add to PATH, if necessary"
    # NOTE: reverse argv, so path_add a b c --> a:b:c:$PATH
    for path in $argv[-1..1]
        test -d "$path" || continue
        set -l idx (contains -i -- $path $PATH) && set -e PATH[$idx]
        set -xp PATH $path
    end
end

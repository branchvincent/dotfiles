function gitio --description "Create a shortened git.io URL"
    # Parse args
    argparse --max-args=1 h/help "c/code=" -- $argv || return
    set -l src https://git.io/$_flag_code
    set -l dest $argv[1]

    # Check or create url
    if ! string length -q $src $dest
        # Display help
        echo "Usage: gitio [-h] [--code CODE] url"
    else if ! set -q dest[1]
        # Check availability
        set -l regex '^[A-Za-z0-9.,+!*\'()$@_-]+$'
        if ! string match -rq $regex $_flag_code
            fish_log -e "code must match $regex"
            return 1
        end
        set -l dest (http --headers $src | sed -n 's/^Location: //p')
        echo "$src -> $dest"
    else
        # Create url
        echo "Creating $src -> $dest"
        http --form --headers https://git.io url=$dest code=$_flag_code |
            sed -En 's/^HTTP\/1.1 ([0-9]{3}) .*$/\1/p; s/^Location: //p' |
            string trim |
            read -lL http_code src_actual

        switch "$http_code: $src_actual"
            case "201: $src"
                fish_log "Success!"
            case "201: *"
                fish_log -e "$src_actual already points to url"
            case "422: *"
                fish_log -e "Either $src in use or $dest invalid"
            case \*
                fish_log -e "Request failed"
        end
    end
end

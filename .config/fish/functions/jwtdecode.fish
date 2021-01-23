function jwtdecode --description "Decode a JWT"
    isatty stdin || read -a argv
    echo $argv | jq -R 'gsub("-"; "+") | gsub("_"; "/") | split(".") | .[1] | @base64d | fromjson'
end

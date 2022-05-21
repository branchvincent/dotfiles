function sha256 -a url --description "Compute SHA-256 for given url"
    curl -fsSL $url | shasum -a 256 | string split -f1 " " | string collect | pbcopy
end

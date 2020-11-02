function desc --description "Print a function's description" --argument-names func
    set -l details (functions --details --verbose $func)
    echo $details[5]
end

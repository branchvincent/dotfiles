function desc --wraps functions --description "Print a function's description" --argument-names func
    echo (functions --details --verbose $func)[5]
end

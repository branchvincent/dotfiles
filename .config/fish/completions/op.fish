function __fish_op_get_accounts
    jq -r .accounts[].shorthand ~/.config/op/config
end

# Options
complete op -f

# signin
complete op -n __fish_use_subcommand -a signin -d "Sign in to a 1Password account"
complete op -n "__fish_seen_subcommand_from signin" -xa '(__fish_op_get_accounts)' -d Account
# eval (security find-generic-password -a <passoword entry name> -w | op signin my

# TODO: finish me

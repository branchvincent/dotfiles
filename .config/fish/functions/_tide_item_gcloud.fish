function _tide_item_gcloud --description "Show Google cloud project"
    type -q gcloud || return
    set -q CLOUDSDK_CONFIG || set -l CLOUDSDK_CONFIG ~/.config/gcloud
    # Get active config
    path is $CLOUDSDK_CONFIG/active_config || return
    read -l config <$CLOUDSDK_CONFIG/active_config
    # Get active project
    path is $CLOUDSDK_CONFIG/configurations/config_$config || return
    string match -rg '^project = (.*)' <$CLOUDSDK_CONFIG/configurations/config_$config | read -l project &&
        _tide_print_item gcloud ' ' $project
end

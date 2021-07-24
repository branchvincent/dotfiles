# Terminal prompt: https://github.com/IlanCosman/tide
#
# References:
# - Icons: https://www.nerdfonts.com/cheat-sheet

not status is-interactive && not status is-login && exit

set fish_handle_reflow 0 # https://github.com/fish-shell/fish-shell/issues/1706#issuecomment-803655785

# Items
set tide_left_prompt_items pwd git newline character
set tide_right_prompt_items \
    status \
    cmd_duration \
    context \
    jobs \
    gcloud \
    pulsarctl \
    kubectl \
    go \
    java \
    node \
    python \
    rustc \
    direnv

# Show on command
set -gx tide_show_gcloud_on gcloud
set -gx tide_show_kubectl_on kubectl helm kubens kubectx stern
set -gx tide_show_pulsarctl_on pulsarctl

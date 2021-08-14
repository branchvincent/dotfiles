# Terminal prompt: https://github.com/IlanCosman/tide
#
# References:
# - Icons: https://www.nerdfonts.com/cheat-sheet

status is-interactive && status is-login || exit

fish_config theme choose "One Dark"
set -gx fish_greeting
set -g fish_handle_reflow 0 # https://github.com/fish-shell/fish-shell/issues/1706#issuecomment-803655785
set -gx tide_direnv_color yellow
set -gx tide_direnv_bg_color normal
set -gx tide_direnv_denied_color brred
set -gx tide_kubectl_icon ﴱ
set -gx tide_node_icon 
set -gx tide_node_color 68A063
set -gx tide_rustc_icon R

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

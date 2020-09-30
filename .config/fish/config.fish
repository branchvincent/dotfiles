### Plugins ###
if status is-interactive
    direnv hook fish | sed 's/fish_postexec/fish_prompt/' | source # https://github.com/direnv/direnv/issues/583
    starship init fish | source
end

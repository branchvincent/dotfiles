function _tide_item_vcs
    # HACK: tide special cases the `git` item
    # https://github.com/IlanCosman/tide/blob/main/functions/_tide_cache_variables.fish
    set_color $tide_git_color_branch | read -gx _tide_location_color
    if path is -d $_tide_parent_dirs/.hg
        _tide_item_hg
    else if path is -d $_tide_parent_dirs/.jj
        _tide_item_jj
    else
        _tide_item_git
    end
end

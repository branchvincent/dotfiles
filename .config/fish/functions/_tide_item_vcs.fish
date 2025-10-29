function _tide_item_vcs
    if path is -d $_tide_parent_dirs/.hg
        _tide_item_hg
    else if path is -d $_tide_parent_dirs/.jj
        _tide_item_jj
    else
        _tide_item_git
    end
end

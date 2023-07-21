function _tide_item_hg
    path filter -d $_tide_parent_dirs/.hg | read -l location || return

    # Branch
    if path filter -d $_tide_parent_dirs/.citc | read -l citc
        path dirname $citc | path basename | read -f branch
    else
        read -f branch <$location/branch
    end

    # Stash
    path filter -f $location/shelved/*.shelve | count | read -l stash
    test $stash -eq 0 && set stash

    # TODO: support all git metadata
    string shorten -"$tide_git_truncation_strategy"m$tide_git_truncation_length $branch | read -l location
    set location $_tide_location_color$location
    _tide_print_item git $_tide_location_color$tide_git_icon' ' (set_color white; echo -ns $location
        set_color $tide_git_color_operation; echo -ns ' '$operation ' '$step/$total_steps
        set_color $tide_git_color_upstream; echo -ns ' ⇣'$behind ' ⇡'$ahead
        set_color $tide_git_color_stash; echo -ns ' *'$stash
        set_color $tide_git_color_conflicted; echo -ns ' ~'$conflicted
        set_color $tide_git_color_staged; echo -ns ' +'$staged
        set_color $tide_git_color_dirty; echo -ns ' !'$dirty
        set_color $tide_git_color_untracked; echo -ns ' ?'$untracked)
end

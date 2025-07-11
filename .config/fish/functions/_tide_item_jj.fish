function _tide_item_jj
    path filter -d $_tide_parent_dirs/.jj | read -l root || return

    # Branch
    if path filter -d $_tide_parent_dirs/.citc | read -l citc
        path dirname $citc | path basename | read -f branch
    else if jj log -r@ -n1 --no-graph --template=bookmarks | read -f bookmarks
        set -f branch $bookmarks
    else
        set -f branch default
    end
    string shorten -"$tide_git_truncation_strategy"m$tide_git_truncation_length $branch | read -l location
    set location $_tide_location_color$location

    # TODO: Operation
    # if test -f $root/shelvedstate
    #     set -f operation merge
    # else if test -f $root/merge/state
    #     set -f operation merge
    # end

    # Status
    set -l stat (jj log -r@ -n1 --no-graph --template='separate("\n", diff.summary(), if(conflict, "UU"))')
    string match -qr '(0|(?<stash>.*))\n(0|(?<conflicted>.*))\n(0|(?<dirty>.*))\n(0|(?<untracked>.*))(\n(0|(?<behind>.*))\t(0|(?<ahead>.*)))?' \
        "$(echo 0
        string match -r ^UU $stat | count
        string match -r ^[ACDMR!] $stat | count
        string match -r '^\?' $stat | count
        : 2>/dev/null)" # TODO: ahead/behind

    if test -n "$operation$conflicted"
        set -g tide_git_bg_color $tide_git_bg_color_urgent
    else if test -n "$staged$dirty$untracked"
        set -g tide_git_bg_color $tide_git_bg_color_unstable
    end

    _tide_print_item git $_tide_location_color$tide_git_icon' ' (set_color white; echo -ns $location
        set_color $tide_git_color_operation; echo -ns ' '$operation ' '$step/$total_steps
        set_color $tide_git_color_upstream; echo -ns ' ⇣'$behind ' ⇡'$ahead
        set_color $tide_git_color_stash; echo -ns ' *'$stash
        set_color $tide_git_color_conflicted; echo -ns ' ~'$conflicted
        set_color $tide_git_color_dirty; echo -ns ' !'$dirty
        set_color $tide_git_color_untracked; echo -ns ' ?'$untracked)
end

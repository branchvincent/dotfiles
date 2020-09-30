function extend --description "Extends a command with custom subcommands"
    set -l callable $argv[1]_(string replace -a - _ -- $argv[2])
    if test "$argv[2]" = "alias"
        set -l prefix $argv[1]_
        functions | grep $prefix | sed "s/$prefix//" | sed 's/_/-/'
    else if type -q $callable
        # Detected external callable, invoke it
        $callable $argv[3..-1]
    else
        # Fallback to builtin
        command $argv
    end
end

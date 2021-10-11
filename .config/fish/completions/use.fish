complete use -f

# Options
use --help | string match -r -- '-(.), --(\S+) (.+)' | while read -Ll match short long desc
    complete use -s $short -l $long -d $desc
end

# Commands
use --help | sed -e '1,/^Commands:/d' | while read -l arg desc
    complete use -a $arg -d $desc
end

complete up -f

# Options
up --help | string match -r -- '-(.), --(\S+) (.+)' | while read -Ll match short long desc
    complete up -s $short -l $long -d $desc
end

# Commands
up --help | sed -e '1,/^Commands:/d' | while read -l arg desc
    complete up -a $arg -d $desc
end

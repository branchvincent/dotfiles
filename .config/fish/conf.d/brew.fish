command -q brew || exit

set -gx HOMEBREW_AUTOREMOVE 1
set -gx HOMEBREW_BAT 1
set -gx HOMEBREW_NO_ENV_HINTS 1

# Faster `brew shellenv`
if not set -q HOMEBREW_PREFIX
    switch "$(uname -sm)"
        case "Darwin arm64"
            set -Ux HOMEBREW_PREFIX /opt/homebrew
            set -Ux HOMEBREW_REPOSITORY $HOMEBREW_PREFIX
        case "Linux x86_64"
            set -Ux HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
            set -Ux HOMEBREW_REPOSITORY $HOMEBREW_PREFIX/Homebrew
        case '*'
            set -Ux HOMEBREW_PREFIX /usr/local
            set -Ux HOMEBREW_REPOSITORY $HOMEBREW_PREFIX/Homebrew
    end
end
set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
set -q MANPATH || set MANPATH ''
set -gxp MANPATH $HOMEBREW_PREFIX/share/man
set -q INFOPATH || set INFOPATH
set -gxp INFOPATH $HOMEBREW_PREFIX/share/info

# Register completions (for non-brewed fish)
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-fish
set -l comp_dir $HOMEBREW_PREFIX/share/fish/vendor_completions.d
if not contains $comp_dir $fish_complete_path
    set -l idx (contains -i $__fish_data_dir/completions $fish_complete_path)
    set fish_complete_path $fish_complete_path[..(math $idx - 1)] $comp_dir $fish_complete_path[$idx..]
end

# Tell build tools about our special prefix
# https://docs.brew.sh/Homebrew-and-Python#brewed-python-modules
if test $HOMEBREW_PREFIX != /usr/local
    set -gx CFLAGS -I$HOMEBREW_PREFIX/include
    set -gx CPPFLAGS -I$HOMEBREW_PREFIX/include
    set -gx LDFLAGS -L$HOMEBREW_PREFIX/lib
end

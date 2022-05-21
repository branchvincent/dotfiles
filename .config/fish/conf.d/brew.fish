set -gx HOMEBREW_BAT 1
set -gx HOMEBREW_NO_ENV_HINTS 1

# Faster `brew shellenv`
if not set -q HOMEBREW_PREFIX
    switch "$(uname -sm)"
        case "Darwin arm64"
            set -U HOMEBREW_PREFIX /opt/homebrew
        case "Linux x86_64"
            set -U HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
        case '*'
            set -U HOMEBREW_PREFIX /usr/local
    end
end
set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX
set -gxp MANPATH $HOMEBREW_PREFIX/share/man
set -gxp INFOPATH $HOMEBREW_PREFIX/share/info
status is-login && fish_add_path -gmP $XDG_BIN_DIRS $HOMEBREW_PREFIX/{,s}bin

# Tell build tools about our special prefix
# https://docs.brew.sh/Homebrew-and-Python#brewed-python-modules
if test $HOMEBREW_PREFIX != /usr/local
    set -gx CFLAGS -I$HOMEBREW_PREFIX/include
    set -gx CPPFLAGS -I$HOMEBREW_PREFIX/include
    set -gx LDFLAGS -L$HOMEBREW_PREFIX/lib
end

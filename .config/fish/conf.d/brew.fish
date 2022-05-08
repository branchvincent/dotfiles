set -gx HOMEBREW_BAT 1
set -gx HOMEBREW_NO_ENV_HINTS 1

# Faster `brew shellenv`
set -q HOMEBREW_PREFIX || set -U HOMEBREW_PREFIX (brew --prefix)
set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX/Homebrew
set -gxp MANPATH $HOMEBREW_PREFIX/share/man
set -gxp INFOPATH $HOMEBREW_PREFIX/share/info

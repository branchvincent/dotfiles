function gpip --wraps pip3 --description "Global pip"
    PIP_REQUIRE_VIRTUALENV=0 $HOMEBREW_PREFIX/bin/pip3 $argv
end

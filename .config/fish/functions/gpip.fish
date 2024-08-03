function gpip --wraps pip3 --description "Global pip"
    PIP_REQUIRE_VIRTUALENV=0 PIP_BREAK_SYSTEM_PACKAGES=1 "$HOMEBREW_PREFIX"/bin/pip3 $argv
end

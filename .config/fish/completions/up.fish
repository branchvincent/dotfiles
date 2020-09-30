# Options
complete -c up -s h -l help -d "Display help"

# Subcommands
complete -c up -f
complete -c up -a brew -d "Update homebrew and its packages"
complete -c up -a cmpl -d "Update fish completions"
complete -c up -a dotfiles -d "Update dotfiles"
complete -c up -a mas -d "Update apps from App Store"
complete -c up -a os -d "Update macOS"
complete -c up -a pipx -d "Update pipx packages"
complete -c up -a tex -d "Update LaTeX packages"

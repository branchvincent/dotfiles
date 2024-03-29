# Dotfiles [![CI](https://github.com/branchvincent/dotfiles/workflows/CI/badge.svg)](https://github.com/branchvincent/dotfiles/actions?query=workflow%3ACI)

- [fish shell](http://fishshell.com/) on macOS
- [XDG spec](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)-compliant (where possible)
- [yadm](https://yadm.io/) for management
- [1Password](https://1password.com/downloads/command-line/) for secrets

## Installation

If you already have `yadm`:

```sh
yadm clone --bootstrap https://github.com/branchvincent/dotfiles.git
```

Otherwise:

```sh
curl -fsSL https://raw.githubusercontent.com/branchvincent/dotfiles/main/bootstrap | bash
```

## Acknowledgements

- [@benmezger](https://github.com/benmezger/dotfiles)
- [@davidosomething](https://github.com/davidosomething/dotfiles)
- [@matchai](https://github.com/matchai/dotfiles)
- [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
- [@MikeMcQuaid](https://github.com/MikeMcQuaid/dotfiles)
- [@seanbreckenridge](https://github.com/seanbreckenridge/dotfiles)

## References

- [Shell initialization](https://github.com/rbenv/rbenv/wiki/unix-shell-initialization)
- [Shell comparisons](https://hyperpolyglot.org/unix-shells)

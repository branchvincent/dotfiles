# Dotfiles [![CI](https://github.com/branchvincent/dotfiles/workflows/CI/badge.svg)](https://github.com/branchvincent/dotfiles/actions?query=workflow%3ACI)

## Overview

- [fish shell](http://fishshell.com/) on macOS
- [XDG spec](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)-compliant (where possible)
- [yadm](https://yadm.io/) for management
- [1Password CLI](https://1password.com/downloads/command-line/) and [Google Drive](https://drive.google.com/) for secrets

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
- [@joeyhoer](https://github.com/joeyhoer/starter)
- [@matchai](https://github.com/matchai/dotfiles)
- [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
- [@MikeMcQuaid](https://github.com/MikeMcQuaid/dotfiles)
- [@seanbreckenridge](https://github.com/seanbreckenridge/dotfiles)

## References

- [Shell initialization](https://github.com/rbenv/rbenv/wiki/unix-shell-initialization)
- [Shell comparisons](https://hyperpolyglot.org/unix-shells)

## TODOs

- Move fish completions upstream ([example](https://github.com/Homebrew/homebrew-core/pull/59433))
- Shorten bootstrap url (`bvincent`, `branchv`, `bvstrap`)
- Make zsh more fish-like ([abbr](https://github.com/IlanCosman/zsh-abbr))
- Consider [chezmoi](https://github.com/twpayne/chezmoi), `most` pager, and more [modern unix replacements](https://remysharp.com/2018/08/23/cli-improved)
- Backup more macOS settings (see [Mackup](https://github.com/lra/mackup))
- Investiate [NixOS](https://nixos.org)
- Update [\$PATH for apps](https://docs.brew.sh/FAQ#my-mac-apps-dont-find-usrlocalbin-utilities): `sudo launchctl config user path $PATH`
- Create own domain and [custom URL shorterner](https://github.com/seanbreckenridge/no-db-static-shorturl)
- Try out different [deployment tools](https://documentation.codeship.com/#deploying)

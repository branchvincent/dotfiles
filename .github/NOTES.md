# Notes

## SSH

1. List and delete current keys

   ```sh
   ssh-add -l
   ssh-add -D
   ```

1. Generate a new key pair

   ```sh
   ssh-keygen -t ed25519 -f ~/.config/ssh/keys/default -C "branchevincent@gmail.com"
   ssh-add ~/.config/ssh/keys/default
   pbcopy ~/.config/ssh/keys/default.pub
   ```

1. Add the public key to [GitHub](https://github.com/settings/ssh/new)

1. Verify it works

   ```sh
   ssh -T git@github.com
   ```

For more information, see [GitHub's guide](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/connecting-to-github-with-ssh).

**_Fun fact_**: GitHub exposes public keys at github.com/branchvincent.keys

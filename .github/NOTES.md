# Notes

## ssh

1. Generate a new key pair

   ```sh
   ssh-keygen -t ed25519 -f ~/.config/ssh/id -C "branchevincent@gmail.com"
   ssh-add ~/.config/ssh/id
   pbcopy ~/.config/ssh/id.pub
   ```

1. Add the public key to [GitHub](https://github.com/settings/ssh/new).

For more information, see [GitHub's guide](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/connecting-to-github-with-ssh).

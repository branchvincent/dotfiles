# Notes

<!-- TOC depthfrom:2 -->

- [GPG Keys](#gpg-keys)
- [SSH Keys](#ssh-keys)
- [AWS Elastic Kubernetes Service](#aws-elastic-kubernetes-service)

<!-- /TOC -->

## GPG Keys

1. List and delete current keys

   ```sh
   gpg --list-secret-keys --keyid-format LONG
   gpg –-delete-secret-keys branchevincent@gmail.com
   gpg –-delete-keys branchevincent@gmail.com
   ```

1. Generate a new key pair

   ```sh
   gpg --full-generate-key
   gpg --armor --export branchevincent@gmail.com | pbcopy
   ```

1. Add the public key to [GitHub](https://github.com/settings/gpg/new)

1. Verify it works

   ```sh
   git commit --allow-empty --gpg-sign
   ```

For more information, see [GitHub's guide](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/managing-commit-signature-verification).

**_Fun fact_**: GitHub exposes the public key at <https://github.com/branchvincent.gpg>

## SSH Keys

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

**_Fun fact_**: GitHub exposes the public keys at <https://github.com/branchvincent.keys>

## AWS Elastic Kubernetes Service

1. List available clusters

   ```sh
   aws eks list-clusters
   ```

2. Add a cluster to your kubeconfig

   ```sh
   aws eks update-kubeconfig --name <cluster_name> --alias <cluster_alias>
   ```

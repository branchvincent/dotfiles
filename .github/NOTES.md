# Notes

<!--TOC-->

- [GitHub](#github)
  - [GPG Keys](#gpg-keys)
  - [SSH Keys](#ssh-keys)
- [Postgres](#postgres)
- [Kubernetes](#kubernetes)
- [Tricks](#tricks)

<!--TOC-->

## GitHub

### GPG Keys

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
   echo test | gpg --clearsign
   git commit -m 'test' --allow-empty --gpg-sign
   ```

For more information, see [GitHub's guide](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/managing-commit-signature-verification).

**_Fun fact_**: GitHub exposes the public key at <https://github.com/branchvincent.gpg>

### SSH Keys

1. List and delete current keys

   ```sh
   ssh-add -l
   ssh-add -D
   ```

1. Generate a new key pair

   ```sh
   ssh-keygen -t ed25519 -f ~/.config/ssh/keys/default -C "branchevincent@gmail.com"
   ssh-add ~/.config/ssh/keys/default
   ```

1. Add the public key to [GitHub](https://github.com/settings/ssh/new)

   ```sh
   gh ssh-key add --title cmd-line ~/.config/ssh/keys/default.pub
   ```

1. Verify it works

   ```sh
   ssh -T git@github.com
   ```

For more information, see [GitHub's guide](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/connecting-to-github-with-ssh).

**_Fun fact_**: GitHub exposes the public keys at <https://github.com/branchvincent.keys>

## Postgres

1. Clone database from another

   ```sh
   pg_dump -Ox <source> | psql <target>
   ```

1. Show running queries

   ```sql
   select pid, age(clock_timestamp(), query_start), datname, usename, query, state
   from pg_stat_activity
   where state not like 'idle%' and query not ilike '%pg_stat_activity%'
   order by query_start desc;
   ```

1. Log all queries

   ```sql
   alter system set log_statement = 'all';
   select pg_reload_conf();
   ```

1. Show table stats

   ```sql
   select * from pg_stat_user_tables;
   ```

## Kubernetes

1. Add EKS cluster to kubeconfig

   ```sh
   aws eks list-clusters
   aws eks update-kubeconfig --name <cluster_name> --alias <cluster_alias>
   ```

1. Dump secret to `.env`

   ```sh
   kubectl get secrets/<name> -o json | jq -r '.data | map_values(@base64d) | to_entries[] | "\(.key)=\(.value)"' >>.env
   ```

1. Dump pod environment to `.env`

   ```sh
   kubectl get pod/<name> -o json | jq -r '.spec.containers[0].env[] | "\(.name)=\(.value)"' >>.env
   ```

## Tricks

1. Enable TouchID for `sudo` auth

   ```sh
   echo -e "auth sufficient pam_tid.so\n$(cat /etc/pam.d/sudo)" >/etc/pam.d/sudo
   ```

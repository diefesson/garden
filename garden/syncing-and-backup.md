# Syncing and Backup

# [Rclone](https://rclone.org)

> The Swiss army knife of cloud storage

Rclone is a tool to manage files in cloud storage with backends for more than 70 providers and protocols, including Google Drive, Mega, SFTP, WebDAV and S3. It has equivalent to popular commands like `ls`, `cp`, `mv`, `rm`, `tree` and `ncdu`. It's features also include mounting, serving (eg: SFTP, DLNA, HTTP) and virtual backends (eg: crypt, compress, union).

Use `rclone config` to start a interactive session to setup remotes and optionally set a config password. Rclone accepts paths in the form `remote:path` where `remote` is the name of a configured remote. When `remote:` is omitted Rclone will use the local filesystem.

When doing operations like `move` or `sync` Rclone checks modification time and hashes whenever supported to avoid unnecessary operations. When doing significant changes it's a good practice to use `-n` (`--dry-run`) to do a trial run and verify operations, furthermore `-i` (`--interactive`) allows the user to interactively approve or skip each operation. `-P` (`--progress`) shows the progress for the overall process and sub operations.

## Help commands

| Command                          | Description                              |
| -------------------------------- | ---------------------------------------- |
| `rclone help` or `rclone --help` | Lists all commands                       |
| `rclone help flags`              | Lists all flags. It has a very long text |
| `rclone help backends`           | Lists all backends                       |
| `rclone <command> --help`        | Get help for a specific command          |

## Common commands

| Command      | Description                                                       | Example                                          |
| ------------ | ----------------------------------------------------------------- | ------------------------------------------------ |
| `about`      | Get quota information from the remote                             | `rclone about remote:path`                       |
| `cat`        | Concatenates any files and sends them to stdout                   | `rclone cat remote:path`                         |
| `check`      | Checks the files in the source and destination match              | `rclone check remote:path remote:path`           |
| `checksum`   | Checks the files in the destination against a SUM file            | `rclone checksum sha1 remote:path checksum_file` |
| `config`     | Enter an interactive configuration session.                       | `rclone config`                                  |
| `copy`       | Copy files from source to dest, skipping identical files          | `rclone copy remote:path remote:path`            |
| `copyto`     | Copy files from source to dest, skipping identical files          | `rclone copyto remote:path remote:path`          |
| `dedupe`     | Interactively find duplicate filenames and delete/rename them     | `rclone dedupe  remote:path`                     |
| `delete`     | Remove the files in path                                          | `rclone delete remote:path`                      |
| `deletefile` | Remove a single file from remote                                  | `rclone deletefile remote:path`                  |
| `hashsum`    | Produces a hashsum file for all the objects in the path           | `rclone hashsum sha1 remote:path`                |
| `help`       | Show help for rclone commands, flags and backends                 | `rclone help`                                    |
| `lsf`        | List directories and objects in remote:path formatted for parsing | `rclone lsf remote:path`                         |
| `mkdir`      | Make the path if it doesn't already exist                         | `rclone mkdir remote:path`                       |
| `mount`      | Mount the remote as file system on a mountpoint                   | `rclone mount remote:path local_path`            |
| `move`       | Move files from source to dest                                    | `rclone move remote:path remote:path`            |
| `moveto`     | Move file or directory from source to dest                        | `rclone moveto remote:path remote:path`          |
| `ncdu`       | Explore a remote with a text based user interface                 | `rclone ncdu remote:path`                        |
| `rmdir`      | Remove the empty directory at path                                | `rclone rmdir remote:path`                       |
| `serve`      | Serve a remote over a protocol                                    | `rclone serve dlna remote:path`                  |
| `sync`       | Make source and dest identical, modifying destination only        | `rclone sync remote:path remote:path`            |
| `touch`      | Create new file or change file modification time                  | `rclone touch remote:path`                       |
| `tree`       | List the contents of the remote in a tree like fashion            | `rclone tree remote:path`                        |

## Common flags

| Short option | Long option                         | Description                                                                                 |
| ------------ | ----------------------------------- | ------------------------------------------------------------------------------------------- |
| `-n`         | `--dry-run`                         | Do a trial run with no permanent changes                                                    |
| `-i`         | `--interactive`                     | Enable interactive mode                                                                     |
| `-P`         | `--progress`                        | Show progress during transfer                                                               |
|              | `--track-renames`                   | When synchronizing, track file renames and do a server-side move if possible                |
|              | `--track-renames-strategy strategy` | Strategies to use when synchronizing using track-renames hash/modtime/leaf (default "hash") |
|              | `--transfers count`                 | Number of file transfers to run in parallel (default 4)                                     |
|              | `--max-depth depth`                 | If set limits the recursion depth to this (default -1)                                      |

# Restic

Restic is a modern backup tool with support for many storage types such as local, self-hosted, SFTP, S3 and Rclone. It uses chunk based deduplication to efficiently store data and reduce transfers.

To create a new repository use `restic init -r repo_path`, you will be prompted for a password (**losing it means you will be able to recover your data**). If you have Rclone configured you can use `rclone:remote:path` access a repository inside a Rclone remote. 

Before creating or restoring complex snapshots, it's a good practice to use `-n` (`--dry-run`) to verify the changes. When creating backups or selecting them, the `--tag` option can be used to, respectively, add tags to the new snapshot or filter by tag. `latest` can be used to represent the latest matching snapshot, for example `restic ls --tag abc latest` will list all files inside the latest snapshot tagged with "abc".

## Help commands

| Command                                              | Example                         |
| ---------------------------------------------------- | ------------------------------- |
| `restic help` or `restic --help`                     | List all commands               |
| `resitc help <command>` or `restic <command> --help` | Get help for a specific command |

## Common commands

| Command     | Description                                     | Example                               |
| ----------- | ----------------------------------------------- | ------------------------------------- |
| `backup`    | Create a new backup of files and/or directories | `restic backup --tag tag path1 path2` |
| `check`     | Check the repository for errors                 | `restic check`                        |
| `diff`      | Show differences between two snapshots          | `restic diff from to`                 |
| `find`      | Find a file, a directory or restic IDs          | `restic find pattern`                 |
| `forget`    | Remove snapshots from the repository            | `restic forget snapshot-id`           |
| `init`      | Initialize a new repository                     | `restic init -r repository`           |
| `ls`        | List files in a snapshot                        | `restic ls --tag tag snapshot`        |
| `restore`   | Extract the data from a snapshot                | `restic restore `                     |
| `snapshots` | List all snapshots                              | `restic snapshots --tag tag`          |

## Common flags

| Short option | Long option            | Description                                                                |
| ------------ | ---------------------- | -------------------------------------------------------------------------- |
| `-n`         | `--dry-run`            | do not upload or write any data, just show what would be done              |
| `-r`         | `--repo repository`    | repository to backup to or restore from (default: $RESTIC_REPOSITORY)      |
| `-p`         | `--password-file file` | file to read the repository password from (default: $RESTIC_PASSWORD_FILE) |
|              | `--tag tag1,tag2,tag3` | Add tags for new backups, and filter existing ones                         |

## Common environment variables

| Variable          | Description                            |
| ----------------- | -------------------------------------- |
| RESTIC_REPOSITORY | Location of repository (replaces -r)   |
| RESTIC_PASSWORD   | The actual password for the repository |

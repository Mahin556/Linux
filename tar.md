* `tar` = Tape ARchiver
* It collects multiple files/directories into a single archive file (usually .tar).
* Can also compress archives using gzip, bzip2, xz, or zstd.

```bash
.tar          → Uncompressed archive
.tar.gz / .tgz → Gzip-compressed archive
.tar.bz2       → Bzip2-compressed archive
.tar.xz        → XZ-compressed archive
.tar.zst       → Zstandard-compressed archive
```
```bash
tar -cvf archive.tar file1 file2 dir1
```
| Option | Meaning                                               | Example                           |
| ------ | ----------------------------------------------------- | --------------------------------- |
| `-c`   | **Create** a new archive                              | `tar -cvf backup.tar /home/user`  |
| `-x`   | **Extract** an archive                                | `tar -xvf backup.tar`             |
| `-t`   | **List** contents of archive                          | `tar -tvf backup.tar`             |
| `-r`   | **Append** files to an existing archive               | `tar -rvf backup.tar newfile.txt` |
| `-u`   | **Update** files in an archive (add newer files only) | `tar -uvf backup.tar file.txt`    |
| `-A`   | **Concatenate** tar files                             | `tar -Af part1.tar part2.tar`     |
| `-d`   | **Compare** archive with filesystem                   | `tar -df backup.tar`              |


| Option       | Compression Type          | Description         |
| ------------ | ------------------------- | ------------------- |
| `-z`         | gzip                      | `.tar.gz` or `.tgz` |
| `-j`         | bzip2                     | `.tar.bz2`          |
| `-J`         | xz                        | `.tar.xz`           |
| `--zstd`     | Zstandard                 | `.tar.zst`          |
| `--lzma`     | LZMA                      | `.tar.lzma`         |
| `--lzip`     | Lzip                      | `.tar.lz`           |
| `--lzop`     | LZOP                      | `.tar.lzo`          |
| `--compress` | traditional UNIX compress | `.tar.Z`            |

```bash
tar -czf archive.tar.gz folder/
tar -cJf archive.tar.xz folder/
tar -cf - folder/ | zstd -o archive.tar.zst
```

| Archive Type       | Command                        |
| ------------------ | ------------------------------ |
| `.tar`             | `tar -xvf file.tar`            |
| `.tar.gz` / `.tgz` | `tar -xvzf file.tar.gz`        |
| `.tar.bz2`         | `tar -xvjf file.tar.bz2`       |
| `.tar.xz`          | `tar -xvJf file.tar.xz`        |
| `.tar.zst`         | `tar --zstd -xvf file.tar.zst` |

```bash
tar -xvf backup.tar -C /target/path
```

| Command                 | Description             |                       |
| ----------------------- | ----------------------- | --------------------- |
| `tar -tvf file.tar`     | List files in archive   |                       |
| `tar -tvzf file.tar.gz` | List compressed archive |                       |
| `tar -tvf file.tar      | grep "file.txt"`        | Search inside archive |

```bash
tar -cvf project.tar project_dir/ #Include directory recursively
tar -cvf data.tar dir1 dir2 dir3 #Add multiple directories
tar -cvf all.tar .* #Add hidden files
tar -xvf backup.tar file1.txt file2.txt #Extract Specific Files
tar -cvf archive.tar /home/user --exclude=/home/user/cache --exclude='*.log' #Exclude Files or Directories
tar -cvzf - /data | split -b 500M - backup.tar.gz.part- #Split Large Archives
#To restore:
cat backup.tar.gz.part-* > backup.tar.gz
tar -xvzf backup.tar.gz

tar -dvf backup.tar #Compare with filesystem

tar -xvpf backup.tar #Extract While Preserving Permissions

tar -rvf archive.tar newfile.txt #Append new files
tar -uvf archive.tar project/ #Update newer files only

tar -Af part1.tar part2.tar #Concatenate Tar Files

tar --delete -f archive.tar file.txt #Delete Files From an Archive

tar cf - folder | gzip > folder.tar.gz
gzip -dc folder.tar.gz | tar xvf -

tar --selinux --same-owner -xvf archive.tar #Preserve Ownership and SELinux Context

#Show Progress and Size
tar -cvf archive.tar folder --checkpoint=.1000 
tar -cvf archive.tar folder --totals #

tar -czf - /home/user | ssh user@remote 'cat > /backup/home.tar.gz' #Create and transfer directly
ssh user@remote 'cat /backup/home.tar.gz' | tar -xzf - #Restore remotely

tar --listed-incremental=snapshot.file -cvf full-backup.tar /home #Incremental Backups
tar --listed-incremental=snapshot.file -cvf incr1.tar /home #Next incremental backup
```

| Option                     | Description                                  |
| -------------------------- | -------------------------------------------- |
| `--transform='s/old/new/'` | Rename files during extraction               |
| `--wildcards`              | Extract files matching pattern               |
| `--remove-files`           | Delete files after adding to archive         |
| `--same-owner`             | Keep original ownership on extract           |
| `--same-permissions`       | Keep permissions                             |
| `--no-same-owner`          | Don’t change ownership on extract            |
| `--directory=<path>`       | Change directory before archiving            |
| `--strip-components=N`     | Skip N leading path elements when extracting |
| `--one-file-system`        | Stay within one filesystem                   |
| `--numeric-owner`          | Use numeric user/group IDs                   |
| `--show-transformed-names` | Show renamed paths                           |
| `--recursion`              | Include directories recursively (default on) |
| `--no-recursion`           | Don’t recurse into directories               |



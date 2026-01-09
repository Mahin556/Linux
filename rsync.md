• Rsync (remote sync) is a local and remote file synchronization tool
• Uses delta-transfer algorithm (copies only changed parts of files)
• Network-enabled syncing tool
• Syntax is similar to cp, scp, ssh
• Source is always first, destination is always second
• Works over TCP (commonly via SSH)
• rsync must be installed on both local and remote systems
```bash
sudo dnf install rsync      # RHEL / CentOS / Rocky / Alma
sudo apt install rsync      # Debian / Ubuntu
```
```bash
rsync SOURCE DEST                         # basic rsync command to copy files/directories

rsync -r SOURCE DEST                      # recursive copy (required for directories)
rsync -a SOURCE DEST                      # archive mode (recursive, preserve perms, owner, group, time, links)
rsync -v SOURCE DEST                      # verbose output
rsync -z SOURCE DEST                      # compress data during transfer
rsync -h SOURCE DEST                      # human-readable output
rsync -P SOURCE DEST                      # show progress and keep partially transferred files
rsync --progress SOURCE DEST              # show progress of transfer
rsync --partial SOURCE DEST               # keep partially transferred files if interrupted

rsync -av SOURCE DEST                     # most commonly used (archive + verbose)
rsync -avz SOURCE DEST                    # archive + verbose + compression
rsync -avh SOURCE DEST                    # archive + verbose + human-readable

rsync -av SOURCE/ DEST/                   # copy contents of SOURCE directory
rsync -av SOURCE DEST                     # copy SOURCE directory itself into DEST

rsync -u SOURCE DEST                      # skip files that are newer on destination
rsync -c SOURCE DEST                      # use checksum to compare files (slow but accurate)
rsync -W SOURCE DEST                      # copy whole files (disable delta transfer)

rsync --delete SOURCE DEST                # delete files in DEST that no longer exist in SOURCE
rsync --dry-run SOURCE DEST               # show what would be copied (no actual changes)
rsync --ignore-existing SOURCE DEST       # skip files that already exist at destination

rsync -t SOURCE DEST                      # preserve modification times
rsync -p SOURCE DEST                      # preserve permissions
rsync -o SOURCE DEST                      # preserve owner (root only)
rsync -g SOURCE DEST                      # preserve group
rsync -l SOURCE DEST                      # preserve symbolic links
rsync -A SOURCE DEST                      # preserve ACLs
rsync -X SOURCE DEST                      # preserve extended attributes
rsync -H SOURCE DEST                      # preserve hard links

rsync --exclude="*.log" SOURCE DEST       # exclude files matching pattern
rsync --exclude-from=file.txt SOURCE DEST # exclude patterns listed in a file
rsync --include="*.conf" SOURCE DEST      # include specific files
rsync --filter='- *.tmp' SOURCE DEST      # advanced include/exclude filtering

rsync -e ssh SOURCE DEST                  # use SSH as transport
rsync -av -e ssh SOURCE user@host:/path   # copy files to remote host
rsync -av user@host:/path DEST            # copy files from remote host
rsync -av -e "ssh -p 2222" SOURCE DEST    # use SSH with custom port

rsync --numeric-ids SOURCE DEST           # copy numeric UID/GID without name mapping
rsync --stats SOURCE DEST                 # show detailed transfer statistics
rsync --inplace SOURCE DEST               # update destination file in-place
rsync --bwlimit=1000 SOURCE DEST          # limit bandwidth usage (KB/s)

rsync --link-dest=/old/backup SOURCE DEST # create incremental backups using hard links
rsync --checksum SOURCE DEST              # force checksum comparison instead of size/time

rsync --timeout=30 SOURCE DEST            # set I/O timeout in seconds
rsync --ignore-errors SOURCE DEST         # delete even if there are I/O errors

rsync --help                              # show help
rsync --version                           # show rsync version

# Push (local → remote)
rsync -a ~/dir1 user@remote_host:/path/to/destination

# Pull (remote → local)
rsync -a user@remote_host:/home/user/dir1 /local/path

# Use custom SSH port
rsync -av -e "ssh -p 2222" dir1/ user@remote_host:/path

# Compression
rsync -az source destination          # compress data during transfer

# Progress + resume
rsync -azP source destination         # --progress + --partial

# Delete extra files at destination
rsync -an --delete source destination # dry-run (recommended first)
rsync -a  --delete source destination # actual delete

# Exclude files or directories
rsync -a --exclude="*.log" source destination
rsync -a --exclude="cache/" source destination

# Include files
rsync -a --exclude="*" --include="*.txt" source/ destination/
# excludes all files, includes only .txt files

# Order matters
# include/exclude rules are processed left → right
# first matching rule wins

# Backup changed/deleted files
rsync -a --delete --backup --backup-dir=/path/to/backup source/ destination/

# Bandwidth limit
rsync -a --bwlimit=1000 source destination   # KB/s

# Checksum comparison (slow but accurate)
rsync -ac source destination

# Preserve additional attributes
rsync -aAXH source destination       # ACLs + xattrs + hard links

# Incremental backups (hard links)
rsync -a --link-dest=/old/backup source/ new/backup/

# List files using rsync
rsync source/

# Copy like cp (no remote specified)
rsync -avh foo/ bar/

```
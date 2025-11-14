* Shows how much disk space directories and files are USING.
* Unlike df (filesystem-level), du works inside directories.

```bash

du
# Shows disk usage for current directory (default block size = 1K)
# Not human-friendly; output is in 1KB blocks.


du -h
# -h = human-readable (KB, MB, GB)
# Most commonly used format.


du -sh /path/to/dir
# -s = summary (show only total size)
# -h = human-readable
# Shows ONLY the total size of the directory, NOT subdirectories.


du -h /path
# Lists disk usage of ALL subfolders under /path.

du -h --max-depth=1 /var
# or shorter:
du -h -d1 /var
# Show only top-level folders inside /var (depth = 1).
# Helps quickly identify which subdir consumes space.


du -h -d1 /var | sort -hr | head
# Sort from largest to smallest (-r)
# -h → sort human readable size
# head → show top 10 results
# BEST COMMAND FOR DISK TROUBLESHOOTING.


du -h -d1 / | sort -hr | head
# Find large folders starting from root directory.


du -h filename
# Shows disk usage of a single file.


du -ah /path
# -a = include files as well as directories.


du -ch /var/log /tmp | grep total
# -c = include a "total" at the end
# grep total → filter the final total line.


du -hL /path
# -L = follow symlinks and calculate real disk usage.
# Use carefully; it may count duplicates.



du -h --exclude=node_modules
# Skip large or irrelevant dirs.


du -h --exclude="*.log"
# Exclude all .log files.


du -d1 /var | sort -n
# Useful when sizes are small (no -h).


du -ah /var | sort -hr | head
# Show the largest files AND directories under /var.


du -h / | grep "G"
# Simple filtering for GB-sized items.


du -h 2>/dev/null
# Suppress permission denied errors.


find /var -type f -size +100M -exec du -h {} \;
# Find files larger than 100MB and show their sizes.


kubectl exec -it <pod> -- du -sh /var/log
# Check log size inside pod.


kubectl exec -it <pod> -- du -sh /demo
# Check emptyDir volume usage.


docker exec -it <container> du -sh /usr
# Check filesystem usage inside container.


du -sh /tmp
# Good for cleanup audits.


du -h -d1 / | sort -hr | head
# Find who is filling the disk.

du -sh /var/log/*
# Inspect folder-by-folder.

du -ah /var | sort -hr | head
# Find biggest individual files.
```
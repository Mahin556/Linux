rmdir — remove empty directories

```bash
rmdir demo
rmdir -p a/b/c   # remove c, then b if empty, then a if empty, Only removes directories that contain no files or subdirs.
rmdir /home/user/emptydir #Remove a single empty directory
rmdir dir1 dir2 dir3 #Remove multiple directories at once

rmdir -v dir #Verbose output
# Output: rmdir: removed directory, 'dir'

rmdir --ignore-fail-on-non-empty dir1 dir2 #Ignore non-empty directories

mv /tmp/files/* /backup/
rmdir -p /tmp/files/old_dir

for d in dir1 dir2 dir3; do
  rmdir "$d" 2>/dev/null
done

find /home/user -type d -empty -exec rmdir {} \;

```
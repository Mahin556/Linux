```bash
rm file.txt #Removing a file

rm file1.txt file2.txt file3.txt #removing a multiple  files

rm *.txt #Removing a text files

rm -r mydir #Remove a Directory Recursively->Deletes directory and everything inside it.

rm -f file.txt #Force Remove Without Prompt

rm -rf mydir #Force Remove Directory->Most dangerous: deletes everything inside mydir without asking.

rm -i file1 file2 #Interactive Deletion

rm -I *.log #Safe Deletion of Multiple Files->Prompt (only once)

rm -I file[[:digit:]]* #delete file1 etc

rm -d emptydir #Delete Empty Directory

rm -rv mydir #Verbose Deletion

rm -rf ./* #Remove Everything in Current Directory

rm -ir mydir/ #Delete Files Safely with Prompt

# Deleting directories with names that contain spaces/special chars
rm -r "My Folder"
rm -r My\ Folder
# or use -- to mark end of options if name starts with -
rm -r -- "-weirdname"

```
* Delete Files Older Than X Days (with find)
```bash
find /var/log -type f -name "*.log" -mtime +7 -exec rm {} \; #Removes all .log files older than 7 days.
```

---

# **1. `--one-file-system`**

```bash
rm -r --one-file-system /mnt/data
```

* Prevents `rm -r` from **recursing into directories that are on different filesystems** than the starting point.
* Useful if `/mnt/data` contains mounted filesystems (like NFS, separate partitions) and you **don’t want to accidentally delete files outside the target filesystem**.

**Example:**

```
/mnt/data       -> ext4
/mnt/data/usb   -> vfat
```

```bash
rm -r --one-file-system /mnt/data
```

* Deletes only `/mnt/data` contents on ext4.
* Skips `/mnt/data/usb` because it’s a different filesystem.

---

# **2. `--preserve-root` (default)**

```bash
rm -rf /
```

* **Blocked by default** to prevent catastrophic deletion of the root filesystem.
* `--preserve-root` is **enabled by default** in modern Linux.

Behavior:

```
rm: it is dangerous to operate recursively on '/'
rm: use --no-preserve-root to override this failsafe
```

---

# **3. `--no-preserve-root` (dangerous!)**

```bash
rm -rf --no-preserve-root /
```

* Overrides the safety check.
* Will **delete everything on the root filesystem**.
* ⚠️ Can destroy the entire OS. Only used in rare recovery or containerized environments.

---

# **Key Notes**

| Option               | Purpose                                        | Safety Level        |
| -------------------- | ---------------------------------------------- | ------------------- |
| `--one-file-system`  | Avoid deleting mounted or separate filesystems | Safe                |
| `--preserve-root`    | Prevent deletion of `/`                        | Very safe (default) |
| `--no-preserve-root` | Allow deletion of `/`                          | Extremely dangerous |

---

✅ **Summary**

* Use `--one-file-system` for safe deletion on mounted directories.
* Never use `--no-preserve-root` on a production machine.
* `rm -rf /` is blocked by default.

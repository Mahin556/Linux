## **What is `ln`?**

* `ln` = **link** command.
* Used to create **hard links** and **symbolic (soft) links**.
* Links are like **shortcuts or references** to files, but with some key differences.

---

## **Syntax**

```bash
ln [OPTION] TARGET [LINK_NAME]
```

* **TARGET** = the original file/directory you’re linking to.
* **LINK_NAME** = the name of the new link.

---

## **Types of Links**

### 1. **Hard Link** (default)

* Points directly to the **inode** (the actual data structure on disk).
* The file and its hard link are indistinguishable — both share the same inode number.
* If the original is deleted, the data still exists as long as one link remains.
* Restrictions:

  * Cannot span across different filesystems.
  * Cannot be made for directories (except by the system).

**Example:**

```bash
ln file1.txt file2.txt
```

Now `file1.txt` and `file2.txt` point to the same inode.

---

### 2. **Symbolic Link (Soft Link)**

* Like a **shortcut**. It points to the filename (not the inode).
* If the original is deleted, the symlink becomes **broken**.
* Can cross filesystems.
* Works for directories too.

**Example:**

```bash
ln -s /path/to/original.txt shortcut.txt
```

Now `shortcut.txt` points to `/path/to/original.txt`.

---

## **Options of `ln`**

* `-s` → Create symbolic (soft) link.
* `-f` → Force (remove existing destination before linking).
* `-i` → Prompt before overwriting existing links.
* `-n` → Treat link name as normal file if it’s a symlink to a directory.
* `-v` → Verbose (show what’s happening).
* `-T` → Always treat LINK_NAME as a file, never as a directory.
* `-b` → Backup existing destination before linking.
* `-L` → Dereference symlinks (link to the target they point to).
* `-P` → Never follow symlinks (default).

---

## **Examples**

1. **Hard link**

```bash
ln file1.txt file2.txt
ls -li file1.txt file2.txt
```

Both have the same inode number.

2. **Symbolic link**

```bash
ln -s file1.txt shortcut.txt
ls -l
```

You’ll see:

```
shortcut.txt -> file1.txt
```

3. **Force overwrite**

```bash
ln -sf newfile.txt shortcut.txt
```

4. **Link to a directory**

```bash
ln -s /var/log logs_link
```

5. **Verbose linking**

```bash
ln -sv file1.txt shortcut.txt
```

6. **Unlink a symlink**
```bash
unlink <path-to-symlink>
```

7. **To remove the symlink**
```bash
rm <path-to-symlink>
```

8. **Finding a deleted and broken symlink**
```bash
find /home/james -xtype l
```
```bash
find /home/james -xtype l -delete
```

---

## **Checking Links**

* Show inode numbers (to see hard links):

```bash
ls -li
```

* Count links:

```bash
stat file1.txt
```

Look at the `Links:` field.

* Check symlink target:

```bash
readlink shortcut.txt
```

---

## **Use Cases**

* **Hard links**: Keep multiple filenames for the same data (backup, safety).
* **Symbolic links**:

  * Shortcuts to long paths.
  * Pointing to versioned files (e.g., `python` → `python3.12`).
  * Linking config files (`~/.vimrc` → `/etc/vim/vimrc`).
  * Pointing web directories (`/var/www/html` → `/home/user/project`).

---

✅ **Quick Summary**

* `ln file link` → hard link (same inode).
* `ln -s file link` → symbolic link (like a shortcut).
* Options: `-s` (soft), `-f` (force), `-i` (interactive), `-v` (verbose), `-n` (don’t follow symlink).


### References:
- https://www.freecodecamp.org/news/symlink-tutorial-in-linux-how-to-create-and-remove-a-symbolic-link/
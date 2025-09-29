# **Hard Link vs Symbolic Link**

| Feature                         | **Hard Link**                                                                     | **Symbolic (Soft) Link**                                 |
| ------------------------------- | --------------------------------------------------------------------------------- | -------------------------------------------------------- |
| **Definition**                  | A direct reference to the same **inode** as the original file.                    | A pointer to the **filename/path** of the original file. |
| **Inode**                       | Shares the same inode as the target file.                                         | Has its own inode, pointing to the target’s path.        |
| **File Systems**                | Must be on the **same filesystem**.                                               | Can span across **different filesystems**.               |
| **Directories**                 | Cannot link to directories (except by root/system).                               | Can link to directories.                                 |
| **If original file is deleted** | Data still exists as long as at least one hard link remains (file survives).      | Becomes a **broken link** (dangling symlink).            |
| **Storage**                     | Takes almost no extra space (just another directory entry pointing to the inode). | Very small space used (stores the path of target).       |
| **Identification**              | Same inode number as target (use `ls -li`).                                       | Different inode number, shows `->` when listed.          |
| **Use case**                    | Data redundancy without extra storage, backups.                                   | Shortcuts, cross-filesystem linking, convenience.        |

---

# **Exercises to Explore**

Here’s a hands-on set of commands you can run:

---

### **1. Create a test file**

```bash
echo "Hello, World!" > original.txt
```

---

### **2. Create a Hard Link**

```bash
ln original.txt hardlink.txt
```

Check inode numbers:

```bash
ls -li original.txt hardlink.txt
```

👉 Both files should have the same inode number.

---

### **3. Create a Symbolic Link**

```bash
ln -s original.txt symlink.txt
```

Check inode numbers and symlink:

```bash
ls -li symlink.txt
ls -l
```

👉 `symlink.txt -> original.txt` (different inode).

---

### **4. Modify through Hard Link**

```bash
echo "Hard link test" >> hardlink.txt
cat original.txt
```

👉 The content is updated in both, because they share the same inode.

---

### **5. Modify through Symbolic Link**

```bash
echo "Symlink test" >> symlink.txt
cat original.txt
```

👉 The content also updates, because symlink redirects to the original.

---

### **6. Delete the Original File**

```bash
rm original.txt
```

Check behavior:

* Hard link:

```bash
cat hardlink.txt
```

👉 Still works (data survives).

* Symlink:

```bash
cat symlink.txt
```

👉 Broken: `No such file or directory`.

---

### **7. Extra Exploration**

* Check number of hard links:

```bash
stat hardlink.txt
```

Look for the `Links:` field.

* Create a symlink to a directory:

```bash
ln -s /etc etc_link
ls -l
```

---

✅ After doing this, you’ll clearly see:

* Hard links = multiple names for the same file **data**.
* Soft links = shortcuts to the **path**.


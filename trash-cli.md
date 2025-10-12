
`trash-cli` is a command-line utility for managing files and directories in a “trash can” instead of deleting them permanently. It follows the **FreeDesktop.org Trash specification**, meaning trashed files are stored in `~/.local/share/Trash` (for normal users) or `/root/.local/share/Trash` (for root).

**Advantages over `rm`:**

* Safe deletion — files can be restored.
* Organizes trashed files with metadata (original path + deletion date).
* Supports commands for listing, restoring, and emptying trash.

---

## **Installation**
**Ubuntu/Debian:**
```bash
sudo apt install trash-cli
```

**RHEL/CentOS/Fedora:**
```bash
sudo dnf install trash-cli
# or
sudo yum install trash-cli
```

---

## **Commands in `trash-cli`**
### **a) `trash-put`**
Move files/directories to trash instead of permanent deletion.
```bash
# Trash a single file
trash-put file.txt

# Trash multiple files
trash-put file1.txt file2.txt

# Trash a directory recursively
trash-put myfolder/
```

**Notes:**
* Works like `rm`, but safer.
* Supports wildcards:
```bash
trash-put *.log
```

---

### **b) `trash-list`**
Show all trashed items with **index, deletion date, and original path**.
```bash
trash-list
```
Example output:
```bash
   0 2025-10-11 12:17:43 /home/mahin/demo
   1 2025-10-11 12:30:10 /home/mahin/test.txt
```
**Columns:**
* Index → number used in `trash-restore`.
* Date → when file was trashed.
* Original path → where it was deleted from.

---

### **c) `trash-restore`**
Restore trashed items to their original location.
```bash
trash-restore
```
**Workflow:**
1. Lists trashed items with their index.
2. Prompts you:
```
What file to restore [0..1]:
```
3. Enter the **index number**, not the path:
```bash
What file to restore [0..1]: 0
```
**Tip:** You can restore multiple items by running `trash-restore` multiple times.

---

### **d) `trash-empty`**
Permanently delete items from trash. You can do:
```bash
# Empty all trashed files
trash-empty

# Empty trashed files older than N days
trash-empty 30
```

* `trash-empty 0` → deletes **everything immediately**.
* Use carefully, especially as root.

---

### **e) `trash-info`**

Check details about a specific trashed file.

```bash
trash-info ~/.local/share/Trash/files/demo.txt
```

Shows:

* Original location
* Deletion date
* File size

---

### **f) `trash-rm`**

Permanently remove a file from trash by specifying the path.

```bash
trash-rm ~/.local/share/Trash/files/demo.txt
```

---

## **4. Example Workflow**

```bash
# Trash a file
trash-put important.txt

# Verify it's in trash
trash-list

# Restore it safely
trash-restore   # Enter index when prompted

# Empty trash older than 7 days
trash-empty 7
```

---

## **5. Tips and Best Practices**

1. **Always check `trash-list`** before restoring or emptying.
2. **Do not type paths in `trash-restore`**, use the index.
3. **Use wildcards carefully** with `trash-put`.
4. **Root user trash location:** `/root/.local/share/Trash`.
5. **Integration with scripts:** You can alias `rm` to `trash-put` for safety:

```bash
alias rm='trash-put'
```

6. **Audit trashed files:** Metadata in `~/.local/share/Trash/info/` contains `.trashinfo` files with original path and deletion timestamp.

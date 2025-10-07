### 🧠 What is `stat`?

* The `stat` command in Linux **displays detailed information about a file or file system**.
  * File size, permission, ownership, timestamp, 
* Unlike `ls -l`, which gives a short summary, `stat` shows **metadata** — such as inode number, permissions, timestamps, file type, links, and more.

---

### 🧩 Basic Syntax

```bash
stat [OPTION]... FILE...
```

Example:

```bash
stat filename.txt
```

---

### 📋 Default Output Example

```bash
$ stat example.txt
```

Output:

```
  File: example.txt
  Size: 1234       Blocks: 8          IO Block: 4096   regular file
Device: 803h/2051d Inode: 131083      Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/  user)   Gid: ( 1000/  user)
Access: 2025-10-07 20:34:56.000000000 +0530
Modify: 2025-10-06 15:12:00.000000000 +0530
Change: 2025-10-06 15:12:00.000000000 +0530
 Birth: 2025-10-06 14:00:00.000000000 +0530
```

---

### 📘 Explanation of Each Field

* **File**: Name of the file.
* **Size**: File size in bytes.
* **Blocks**: Number of disk blocks allocated.
* **IO Block**: Filesystem block size.
* **File type**: e.g., regular file, directory, symbolic link, etc.
* **Device**: Device number where the file resides.
* **Inode**: Unique identifier for the file in the filesystem.
* **Links**: Number of hard links to the file.
* **Access (permissions)**: Numeric and symbolic representation of permissions.
* **Uid/Gid**: User and group ownership (numeric + name).
* **Access time (atime)**: Last time file was read.
* **Modify time (mtime)**: Last time file content was modified.
* **Change time (ctime)**: Last time file’s metadata was changed.
* **Birth time (crtime)**: File creation time (not available on all filesystems).

---

* **File: example.txt**
  • Name of the file being examined.

* **Size: 1234**
  • The total size of the file in bytes (here, 1234 bytes).

* **Blocks: 8**
  • Number of filesystem blocks actually allocated to the file.
  • Each block generally represents 512 or 4096 bytes depending on the filesystem.

* **IO Block: 4096**
  • The filesystem’s block size for I/O operations (in bytes).
  • Data is read and written in multiples of this size.

* **regular file**
  • Type of file. It can be a regular file, directory, symbolic link, socket, etc.

* **Device: 803h/2051d**
  • The device number on which the file resides (in hexadecimal and decimal).
  • Identifies the storage device.

* **Inode: 131083**
  • Unique identifier (inode number) assigned by the filesystem.
  • Each file has an inode that stores metadata about the file.

* **Links: 1**
  • Number of hard links pointing to this inode.
  • A value greater than 1 means the same file data is linked to multiple filenames.

* **Access: (0644/-rw-r--r--)**
  • File permissions in both octal and symbolic form:

  * `0644` means:

    * Owner: read & write (6 → rw-)
    * Group: read only (4 → r--)
    * Others: read only (4 → r--)
  * Symbolic form: `-rw-r--r--`

* **Uid: (1000/user)**
  • User ID and username of the file owner.

* **Gid: (1000/user)**
  • Group ID and group name associated with the file.

* **Access: 2025-10-07 20:34:56.000000000 +0530**
  • The **last access time** — when the file was last read.

* **Modify: 2025-10-06 15:12:00.000000000 +0530**
  • The **last modification time** — when the file content was last changed.

* **Change: 2025-10-06 15:12:00.000000000 +0530**
  • The **last status change time** — when file metadata (like permissions or ownership) last changed.

* **Birth: 2025-10-06 14:00:00.000000000 +0530**
  • The **creation time** (if supported by the filesystem).
  • Shows when the file was originally created.
---

### ⚙️ Commonly Used Options

| Option                  | Description                                                 |
| ----------------------- | ----------------------------------------------------------- |
| `-c` or `--format`      | Display output in a custom format.                          |
| `--printf`              | Similar to `--format` but no newline added automatically.   |
| `-f` or `--file-system` | Display filesystem information instead of file information. |
| `--help`                | Show help message.                                          |
| `--version`             | Show version information.                                   |

---

### 🧾 Format Sequences (`--format` or `--printf`)

You can customize output with format specifiers.

**Common format specifiers:**

| Specifier | Description                    |
| --------- | ------------------------------ |
| `%n`      | File name                      |
| `%s`      | Size in bytes                  |
| `%F`      | File type                      |
| `%i`      | Inode number                   |
| `%h`      | Number of hard links           |
| `%U`      | User name of owner             |
| `%G`      | Group name of owner            |
| `%a`      | Access rights (octal)          |
| `%A`      | Access rights (human-readable) |
| `%x`      | Last access time               |
| `%y`      | Last modification time         |
| `%z`      | Last change time               |
| `%w`      | Birth time (creation)          |

**Example:**

```bash
stat --format="%n: %s bytes, owner=%U, perms=%A" example.txt
```

Output:

```
example.txt: 1234 bytes, owner=user, perms=-rw-r--r--
```

---

### 🧱 Show Filesystem Information

To display filesystem (not file) info:

```bash
stat -f /
```

Output:

```
  File: "/"
    ID: 903c7d2bdaaa7f72 Namelen: 255     Type: ext4
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 30531533   Free: 17671569   Available: 16230000
Inodes: Total: 7766016    Free: 7603212
```
The information we get for the filesystem from the stat 
 - File: The name of provided file.
 - ID: File system ID in hexadecimal format.
 - Namelen: The maximum length (number of characters) of a file name.
 - Fundamental block size: Total size of each block on the file system.
 - Blocks:
   - Total: Total number of blocks in the file system
   - Free: Total number of free blocks in the file system
   - Available: Total number of free blocks available for non-root users
 - Inodes:
   - Total: Total number of inodes in the file system.
   - Free: Total number of free inodes in the file system.

---
```bash
stat locale.conf  login.defs
```

## Display Information in Terse Form
The stat command can produce terse (concise) output using the -t option.
This output contains all essential file information but without formatting (no line breaks, no extra spaces, no labels).
```bash
stat -t MyFile

MyFile 1024 8 4096 803 393219 1 1000 1000 100644 0 2025-10-07 17:12:55.000000000 +0530 2025-10-06 12:33:40.000000000 +0530 2025-10-06 12:33:40.000000000 +0530 2025-10-06 12:30:00.000000000 +0530
```
🔹 Explanation:
   - MyFile → filename
   - 1024 → size in bytes
   - 8 → blocks allocated
   - 4096 → I/O block size
   - 803 → device number (hex/decimal)
   - 393219 → inode number
   - 1 → number of hard links
   - 1000 1000 → user ID and group ID
   - 100644 → access permissions in octal
   - The remaining fields → access, modify, change, and birth timestamps
 🧠 Use Case:
  This terse format is very handy for scripts, where you need compact data to parse programmatically.
---

### 🧰 Useful Practical Examples

* **Check when a file was last modified:**

  ```bash
  stat -c %y file.txt
  ```

* **Show only file size:**

  ```bash
  stat -c %s file.txt
  ```

* **Display inode number:**

  ```bash
  stat -c %i file.txt
  ```

* **Show file permissions in octal format:**

  ```bash
  stat -c %a file.txt
  ```

* **Display last access, modify, and change times together:**

  ```bash
  stat -c "Access: %x  Modify: %y  Change: %z" file.txt
  ```

* **Check creation (birth) time:**

  ```bash
  stat -c %w file.txt
  ```

  (If empty, your filesystem doesn’t support it.)

* **Display only filename and owner:**

  ```bash
  stat -c "File: %n Owner: %U" file.txt
  ```

* **Get file info for multiple files:**

  ```bash
  stat file1.txt file2.txt file3.txt
  ```

---

### 🧮 Combine with Other Commands

* **Get all file sizes in a directory:**

  ```bash
  for f in *; do stat -c "%n %s" "$f"; done
  ```

* **Sort files by modification time:**

  ```bash
  stat -c "%Y %n" * | sort -n
  ```

  (`%Y` gives modification time in Unix epoch format.)

---

### 🧩 Filesystem Metadata (`stat -f`)

Shows information about the filesystem on which the file resides.

Example:

```bash
stat -f /home
```

Output:

```
  File: "/home"
    ID: 903c7d2bdaaa7f72 Namelen: 255     Type: ext4
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 30531533   Free: 17671569   Available: 16230000
Inodes: Total: 7766016    Free: 7603212
```

---

### ⚡ Bonus: Compare `stat` with `ls -l`

| Command          | Information Level                                      | Example         |
| ---------------- | ------------------------------------------------------ | --------------- |
| `ls -l file.txt` | Summary (permissions, owner, size, modification time)  | Simple listing  |
| `stat file.txt`  | Detailed metadata (inode, timestamps, filesystem info) | Deep inspection |


Perfect 👍 — here’s a **complete, clear, and well-structured explanation of the Linux `stat` command (updated and expanded version of what you shared)** with **examples and sample outputs** for every section.

---


## 🔗 Dereferencing Symbolic Links

By default, `stat` shows information about the **link itself**, not its target.

### Example

```bash
stat /etc/localtime
```

Output (symbolic link):

```
  File: /etc/localtime -> /usr/share/zoneinfo/Asia/Kolkata
  Size: 33          Blocks: 0          IO Block: 4096   symbolic link
  ...
```

To **dereference (follow)** the symbolic link, use the **`-L`** or **`--dereference`** option:

```bash
stat -L /etc/localtime
```

Output (target file):

```
  File: /usr/share/zoneinfo/Asia/Kolkata
  Size: 2857       Blocks: 8          IO Block: 4096   regular file
  ...
```

---

## 📉 Display Terse Output

The **`-t`** or **`--terse`** option prints information in a **single line**, useful for scripting.

Example:

```bash
stat -t /etc/passwd
```

Output:

```
/etc/passwd 2683 8 4096 803 393219 1 1000 1000 100644 0 2025-10-07 17:12:55.000000000 +0530 2025-10-05 21:50:45.000000000 +0530 2025-10-05 21:50:45.000000000 +0530 2025-10-05 21:48:00.000000000 +0530
```

---

## ⏰ Understanding the Timestamps

| Timestamp          | Description                                        |
| ------------------ | -------------------------------------------------- |
| **Access (atime)** | Last time file was read                            |
| **Modify (mtime)** | Last time file contents changed                    |
| **Change (ctime)** | Last time file metadata (like permissions) changed |
| **Birth (crtime)** | File creation time (if supported)                  |

**Example:**

```
Access: 2025-10-06 17:12:55.000000000 +0530
Modify: 2025-10-05 21:50:45.000000000 +0530
Change: 2025-10-05 21:50:45.000000000 +0530
Birth:  2025-10-05 21:48:00.000000000 +0530
```

---

### 🧰 **Common Use Cases of `stat` Command**

* **Check file modification time for backups or synchronization**
  • Compare “Modify” time to decide whether a file needs to be backed up or copied.
  • Useful in automation scripts (e.g., only copy files modified after a certain date).

* **Verify file ownership and permissions**
  • Use `Uid` and `Gid` fields to confirm if the correct user/group owns a file.
  • Check `Access` permissions before troubleshooting “Permission denied” errors.

* **Monitor file access patterns**
  • The “Access” time tells you when a file was last read.
  • Helps identify stale or unused files (useful in log rotation or cleanup scripts).

* **Detect configuration or metadata changes**
  • The “Change” time updates when ownership, permissions, or links are altered — even if file data doesn’t change.
  • Useful for detecting tampering or unexpected permission changes.

* **File creation audit**
  • The “Birth” time lets you know exactly when the file was created (if the filesystem supports it).
  • Important for forensic analysis or compliance logging.

* **Identify disk usage and fragmentation**
  • “Blocks” and “IO Block” fields help you understand how the file occupies disk space.
  • Useful for performance analysis or low-level storage debugging.

* **Track file links and hard link usage**
  • The “Links” field tells if a file is linked elsewhere.
  • Crucial in deduplication and storage management.

* **Check inode information**
  • The “Inode” and “Device” numbers are used in low-level file tracking, especially during filesystem repairs or forensic work.

---

### 💡 **Practical Examples**

* **Example 1: Check if a file has been modified recently**

  ```bash
  find /etc -type f -newermt "2025-10-06" -exec stat {} \;
  ```

  → Lists files modified after a specific date.

* **Example 2: Detect if a config file’s permissions changed**

  ```bash
  stat /etc/passwd
  ```

  → Compare “Change” time to last known safe value.

* **Example 3: Use in scripts for automated actions**

  ```bash
  if [[ $(stat -c %Y myfile.txt) -gt $(date -d "1 day ago" +%s) ]]; then
      echo "File modified within last 24 hours"
  fi
  ```

  → `stat -c %Y` gives modification time in seconds since epoch — perfect for comparisons.

* **Example 4: Audit ownership**

  ```bash
  stat -c "%n owned by %U (%G)" /var/log/*
  ```

  → Helps check that log files are owned by the correct user/group.

---

### 🚀 **In Summary — What You Can Do**

* Monitor file integrity and detect tampering.
* Automate backups and cleanups based on timestamps.
* Diagnose permission issues quickly.
* Analyze filesystem performance and usage.
* Perform security or forensic audits.


### References:
- https://www.geeksforgeeks.org/linux-unix/stat-command-in-linux-with-examples/
- https://phoenixnap.com/kb/linux-stat
- https://man7.org/linux/man-pages/man1/stat.1.html

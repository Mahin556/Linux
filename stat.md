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

Here, `+0530` indicates **Indian Standard Time (5 hours 30 minutes ahead of UTC)**.


### References:
- https://www.geeksforgeeks.org/linux-unix/stat-command-in-linux-with-examples/
- https://phoenixnap.com/kb/linux-stat
- https://man7.org/linux/man-pages/man1/stat.1.html

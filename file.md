
# **`file` Command in Linux — Complete Reference**

---

## **What is the `file` Command?**

The **`file`** command in Linux is used to **determine the type of a file**.
Instead of relying on file extensions (like `.txt`, `.jpg`), it **examines the file’s actual content** using “magic numbers” and system information.

> It tells you *what a file really is*, not just what its name suggests.

---

## **Syntax**

```bash
file [OPTION]... [FILE]...
```

If no file is given, `file` reads from **standard input (stdin)**.

---

## **Basic Example**

```bash
file filename
```

**Output Example:**

```
filename: ASCII text
```

✅ The command checks the contents and tells you it’s plain text.

---

## 🧩 **Common Examples**

### Identify a single file type

```bash
file /etc/passwd
```

Output:

```
/etc/passwd: ASCII text
```

---

### 2Identify multiple files

```bash
file file1.txt file2.jpg file3.sh
```

Output:

```
file1.txt: ASCII text
file2.jpg: JPEG image data
file3.sh: Bourne-Again shell script, ASCII text executable
```

---

### Identify type of a binary/executable file

```bash
file /bin/ls
```

Output:

```
/bin/ls: ELF 64-bit LSB executable, x86-64, dynamically linked, stripped
```

📘 **ELF** → Executable and Linkable Format (Linux binary format)

---

### Identify a compressed file

```bash
file archive.tar.gz
```

Output:

```
archive.tar.gz: gzip compressed data, was "archive.tar"
```

---

### Identify a directory

```bash
file /etc
```

Output:

```
/etc: directory
```

---

### Identify symbolic link targets

```bash
file mylink
```

Output:

```
mylink: symbolic link to `/usr/local/bin/script.sh`
```

---

### Identify content from stdin

```bash
echo "hello world" | file -
```

Output:

```
/dev/stdin: ASCII text
```

---

## 🧱 **How It Works**

The `file` command checks in this order:

1. **Filesystem test** → Checks if the file is a directory, symlink, etc.
2. **Magic test** → Examines “magic numbers” (unique binary signatures) in the file.
3. **Language test** → Identifies text encoding or script type (ASCII, UTF-8, shell script, etc.)

---

## ⚙️ **Options and Parameters**

| Option            | Description                                     | Example                                             |                |
| ----------------- | ----------------------------------------------- | --------------------------------------------------- | -------------- |
| `-b`              | Output only the file type (omit filename)       | `file -b /bin/bash` → `ELF 64-bit LSB executable`   |                |
| `-i`              | Output MIME type instead of human-readable type | `file -i file.txt` → `text/plain; charset=us-ascii` |                |
| `-f FILE`         | Read filenames to process from a file           | `file -f list.txt`                                  |                |
| `-L`              | Follow symbolic links                           | `file -L linkname`                                  |                |
| `-h`              | Don’t follow symbolic links                     | `file -h linkname`                                  |                |
| `-z`              | Try to look inside compressed files             | `file -z archive.gz`                                |                |
| `--mime`          | Show MIME type and encoding                     | `file --mime file.jpg`                              |                |
| `--preserve-date` | Don’t update access time                        | `file --preserve-date myfile`                       |                |
| `-N`              | Don’t pad filenames in output                   | `file -N myfile`                                    |                |
| `-s`              | Read special files (like block/char devices)    | `sudo file -s /dev/sda1`                            |                |
| `-0`              | Use NUL character as separator (for scripts)    | `find . -print0                                     | xargs -0 file` |
| `--help`          | Show help message                               | `file --help`                                       |                |
| `--version`       | Show version info                               | `file --version`                                    |                |

---

## 🧰 **Advanced Examples**

### 🧾 1. Get MIME Type for Web Use

```bash
file --mime-type index.html
```

Output:

```
index.html: text/html
```

### 🧾 2. Detect file encoding

```bash
file --mime-encoding data.txt
```

Output:

```
data.txt: utf-8
```

### 🧾 3. Identify compressed content

```bash
file -z backup.gz
```

Output:

```
backup.gz: gzip compressed data, from Unix, original size 20480
```

### 🧾 4. Test all files in a directory

```bash
file *
```

✅ Lists the file types of all files in the current directory.

---

## 💡 **Combination Examples**

### 🔹 1. Find all shell scripts in current directory

```bash
file * | grep "shell script"
```

### 🔹 2. Identify executable files

```bash
file * | grep "executable"
```

### 🔹 3. Identify all non-text files

```bash
file * | grep -v "text"
```

### 🔹 4. Combine with `find` for recursive scan

```bash
find /etc -type f -exec file {} \; | grep "ASCII text"
```

---

## 🧩 **Real-World Use Cases**

| Use Case                                      | Example                          | Description                                 |
| --------------------------------------------- | -------------------------------- | ------------------------------------------- |
| Identify file type for unknown files          | `file unknown.*`                 | Check what type of file you’re dealing with |
| Verify MIME type before uploading to web apps | `file --mime-type upload.*`      | Ensure correct content type                 |
| Check encoding for scripts or configs         | `file --mime-encoding script.sh` | Find UTF-8 or ASCII                         |
| Inspect binary programs                       | `file /usr/bin/ssh`              | View architecture and linkage info          |
| Check ISO, image, and compressed files        | `file image.iso`                 | Confirm disk image formats                  |
| Debug download issues                         | `file downloaded_file`           | Detect partial/incomplete downloads         |

---

## ⚙️ **`file` and MIME Types**

`file` can output MIME information (like `text/plain`, `image/png`, etc.), which is used by:

* Web servers (Apache, Nginx)
* Email clients
* File upload validators

Example:

```bash
file --mime-type --mime-encoding test.png
```

Output:

```
test.png: image/png; charset=binary
```

---

## 🧠 **Understanding “Magic Numbers”**

Linux keeps a database of *magic numbers* in:

```
/usr/share/misc/magic
```

These are binary patterns at the start of files used to detect type.

Example:

* PNG → `89 50 4E 47`
* ELF → `7F 45 4C 46`
* ZIP → `50 4B 03 04`

You can view it:

```bash
less /usr/share/misc/magic
```

---

## 📊 **Exit Status Codes**

| Code | Meaning                               |
| ---- | ------------------------------------- |
| `0`  | Success                               |
| `1`  | Minor problems (some files not found) |
| `2`  | Serious errors                        |

---

## ⚡ **Comparison with Other Tools**

| Tool       | Purpose                                      |
| ---------- | -------------------------------------------- |
| `file`     | Detect actual file type via content          |
| `ls -l`    | Lists files with permissions/ownership       |
| `stat`     | Shows detailed metadata (timestamps, inodes) |
| `xdg-mime` | Manage MIME types in desktop environments    |

---

## 🧩 **Quick Reference Table**

| Command                         | Description                       |                                  |
| ------------------------------- | --------------------------------- | -------------------------------- |
| `file myfile`                   | Identify file type                |                                  |
| `file -b myfile`                | Show only file type (no filename) |                                  |
| `file -i myfile`                | Show MIME type                    |                                  |
| `file -s /dev/sda1`             | Identify special device file      |                                  |
| `file -z archive.gz`            | Inspect compressed archive        |                                  |
| `file *                         | grep "text"`                      | List all text files in directory |
| `file --mime-encoding file.txt` | Show file encoding                |                                  |

---

## 🏁 **Summary**

| Feature             | Description                            |
| ------------------- | -------------------------------------- |
| **Purpose**         | Identify file type based on content    |
| **Checks**          | Filesystem, Magic number, and Language |
| **Output**          | Human-readable or MIME format          |
| **Works On**        | Files, directories, symlinks, devices  |
| **Key Options**     | `-b`, `-i`, `-s`, `-L`, `-z`           |
| **Stored Database** | `/usr/share/misc/magic`                |

---

## 💬 **In Short**

> 🧩 The `file` command tells you *what a file truly is*, not what its name says it is.

---

Would you like me to follow up with a **deep guide on the `stat` command** (to learn how to view detailed file metadata like inode, access time, and permissions)?

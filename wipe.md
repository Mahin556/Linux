# 🧹 **`wipe` Command in Linux**

The **`wipe`** command is used to **securely delete files and directories** from a Linux system so that they **cannot be recovered**, even with advanced file recovery tools. It works by overwriting the file's data multiple times before deletion.

> **Note:** `wipe` is not installed by default on most Linux distributions. You usually need to install it first.

---

## ⚙️ **Installation**

### On Debian/Ubuntu:

```bash
sudo apt update
sudo apt install wipe
```

### On RedHat/CentOS/Fedora:

```bash
sudo yum install wipe   # older systems
sudo dnf install wipe   # newer Fedora
```

---

## 📄 **Syntax**

```bash
wipe [options] file_or_directory
```

* **`file_or_directory`** → The file(s) or directory you want to securely delete.

---

## 🧩 **Common Options**

| Option | Description                                   |
| ------ | --------------------------------------------- |
| `-r`   | Recursively wipe a directory and its contents |
| `-f`   | Force deletion without confirmation           |
| `-q`   | Quiet mode, minimal output                    |
| `-I`   | Prompt once before wiping multiple files      |
| `-i`   | Interactive mode, prompt for each file        |
| `-s`   | Scramble file names before deletion           |
| `-l N` | Number of overwrite passes (default: 25)      |
| `-V`   | Display version info                          |

---

## 🧹 **Examples**

### 1️⃣ Wipe a single file

```bash
wipe confidential.txt
```

* Securely deletes `confidential.txt` using multiple overwrites.

---

### 2️⃣ Wipe a directory recursively

```bash
wipe -r /home/user/temp/
```

* Deletes all files and subdirectories in `/home/user/temp/` securely.

---

### 3️⃣ Force deletion without prompts

```bash
wipe -rf /tmp/oldfiles/
```

* Recursively wipes `/tmp/oldfiles/` without asking for confirmation.

---

### 4️⃣ Interactive mode

```bash
wipe -i important.docx
```

* Prompts the user before wiping `important.docx`.

---

### 5️⃣ Wipe multiple files

```bash
wipe file1.txt file2.txt file3.txt
```

* Wipes `file1.txt`, `file2.txt`, and `file3.txt` securely.

---

## ⚡ **Key Points**

* `wipe` is **more secure than rm** because it overwrites file contents, making recovery extremely difficult.
* Useful for **sensitive data** like passwords, personal documents, or private keys.
* Not suitable for extremely large files on SSDs due to wear-leveling; consider `shred` or full-disk encryption for SSDs.

---

### ✅ Quick Recap

| Task                       | Command Example          |
| -------------------------- | ------------------------ |
| Wipe a file                | `wipe file.txt`          |
| Wipe a directory           | `wipe -r /dir`           |
| Force wipe without prompts | `wipe -rf /dir`          |
| Interactive deletion       | `wipe -i file.txt`       |
| Wipe multiple files        | `wipe file1 file2 file3` |

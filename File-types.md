# **Types of Files in Linux**

Linux classifies files based on attributes such as **permissions, ownership, and content**. Each type serves a different purpose.

---

## **1. Regular Files**

* **Description:** Standard files containing data.

* **Subtypes:**

  * **Text files:** Human-readable, e.g., `.txt`, source code files
  * **Binary files:** Compiled code or non-readable data, e.g., executables
  * **Image/Multimedia files:** Images, videos, or audio, e.g., `.jpg`, `.mp4`

* **Example commands:**

```bash
ls -l file.txt
file file.txt
```

* **Symbol:** `-` (dash) in `ls -l`

---

## **2. Directory Files**

* **Description:** Special files that contain references to other files or directories.
* **Symbol:** `d` in `ls -l`
* **Example:**

```bash
ls -ld /home/user
```

---

## **3. Symbolic Link (Symlink)**

* **Description:** A pointer or shortcut to another file or directory.
* **Symbol:** `l` in `ls -l`
* **Example:**

```bash
ls -l link_to_file
```

---

## **4. Character Device Files**

* **Description:** Represent devices that **transfer data character by character**, such as keyboards or serial ports.
* **Location:** `/dev`
* **Creation:** `mknod` command
* **Example:** `/dev/input/mouse2`
* **Symbol:** `c` in `ls -l`
* **Check type:**

```bash
find / -type c
```

---

## **5. Block Device Files**

* **Description:** Represent devices that **transfer data in blocks**, e.g., hard drives, USB drives.
* **Location:** `/dev`
* **Example:** `/dev/sda1`
* **Symbol:** `b` in `ls -l`
* **Check type:**

```bash
find / -type b
```

---

## **6. FIFO (Named Pipes)**

* **Description:** Enable **inter-process communication (IPC)**; data is read/written in **first-in, first-out** order.
* **Creation:** `mkfifo` command
* **Symbol:** `p` in `ls -l`
* **Check type:**

```bash
find / -type p
ls -l /run/systemd/inaccessible/fifo
```

---

## **7. Socket Files**

* **Description:** Enable **network communication** between processes, often in client-server apps.
* **Location:** `/run/`
* **Example:** `/run/chrony/chronyd.sock`
* **Symbol:** `s` in `ls -l`
* **Check type:**

```bash
find / -type s
ls -l /run/file_name.sock
```

---

## **8. Identifying File Types**

* **Using `ls -l`:** First character shows file type

| Symbol | File Type         |
| ------ | ----------------- |
| `-`    | Regular file      |
| `d`    | Directory         |
| `l`    | Symbolic link     |
| `c`    | Character device  |
| `b`    | Block device      |
| `p`    | FIFO (named pipe) |
| `s`    | Socket            |

* **Using `file` command:** Provides detailed description

```bash
file filename
```

---

This table summarizes Linux file types, their symbols, purpose, and examples for quick reference:

| Type              | Symbol | Purpose              | Example Location           |
| ----------------- | ------ | -------------------- | -------------------------- |
| Regular file      | `-`    | Data storage         | `/home/user/file.txt`      |
| Directory         | `d`    | Organize files       | `/home/user/`              |
| Symlink           | `l`    | Shortcut             | `/home/user/link`          |
| Character device  | `c`    | Device, char-by-char | `/dev/input/mouse2`        |
| Block device      | `b`    | Device, block data   | `/dev/sda1`                |
| FIFO / Named pipe | `p`    | IPC                  | `/tmp/myfifo`              |
| Socket            | `s`    | IPC / Network        | `/run/chrony/chronyd.sock` |

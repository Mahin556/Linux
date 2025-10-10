# 🧩 **`shred` Command in Linux**

---

## 🧠 **What is `shred`?**

The `shred` command **securely deletes files** by **overwriting their contents multiple times** with random data to make data recovery almost impossible — even with forensic tools.

It’s part of **GNU coreutils**.

---

## ⚙️ **Basic Syntax**

```bash
shred [OPTION]... FILE...
```

---

## 🧾 **Example: Basic Usage**

```bash
shred mysecret.txt
```

🔹 This overwrites the file `mysecret.txt` with random data several times.
⚠️ But it does **not delete** it by default (the filename remains).

---

## 🧾 **Example: Securely Wipe and Delete**

```bash
shred -u mysecret.txt
```

✅ `-u` = **remove file after overwriting**

This:

1. Overwrites file contents multiple times
2. Renames it
3. Deletes it securely

---

## 🧩 **Key Options**

| Option                   | Description                                        |
| ------------------------ | -------------------------------------------------- |
| `-u`, `--remove`         | Truncate and remove file after overwriting         |
| `-z`, `--zero`           | Add a final overwrite with zeros — hides shredding |
| `-n N`, `--iterations=N` | Overwrite file N times (default is 3)              |
| `-v`, `--verbose`        | Show progress (each pass displayed)                |
| `-f`, `--force`          | Change permissions if necessary to allow writing   |
| `--random-source=FILE`   | Use a specific file as source of random data       |
| `--help`                 | Show help message                                  |
| `--version`              | Display version info                               |

---

## 🧰 **Examples**

### 1️⃣ **Basic Secure Delete**

```bash
shred -u secrets.txt
```

✅ Overwrites and deletes the file.

---

### 2️⃣ **Verbose Output**

```bash
shred -v secrets.txt
```

Displays each overwrite pass:

```
shred: secrets.txt: pass 1/3 (random)...
shred: secrets.txt: pass 2/3 (random)...
shred: secrets.txt: pass 3/3 (random)...
```

---

### 3️⃣ **Overwrite More Times**

```bash
shred -n 10 secrets.txt
```

Overwrites 10 times with random data (increases security).

---

### 4️⃣ **Overwrite, Zero Out, and Delete**

```bash
shred -u -z -v secrets.txt
```

✅ Final pass fills the file with zeros (so it looks untouched).
✅ Deletes it afterward.

---

### 5️⃣ **Wipe All Files in a Directory**

```bash
shred -u -z -v /home/user/confidential/*
```

⚠️ Be careful — this permanently erases all files inside that directory.

---

## ⚠️ **Important Notes and Limitations**

1. ❌ **Does not guarantee data removal on all filesystems.**
   Works best on **traditional HDDs** and **non-journaled filesystems** like `ext2`.

2. ⚠️ On modern systems using:

   * **ext3/ext4**, **Btrfs**, **XFS**, or **ZFS**,
   * **SSDs (solid-state drives)**,
     data may still be recoverable because of:
   * Journaling
   * Wear leveling
   * File caching

3. ✅ For SSDs or journaling FS, use:

   ```bash
   sudo blkdiscard /dev/sdX
   ```

   or

   ```bash
   sudo hdparm --security-erase
   ```

   to wipe entire devices securely.

---

## 🧠 **Why Use `shred` Instead of `rm`**

| Command             | Behavior                                                                                 |
| ------------------- | ---------------------------------------------------------------------------------------- |
| `rm file.txt`       | Deletes only the directory entry (file data can still be recovered easily).              |
| `shred -u file.txt` | Overwrites file data multiple times before deletion. Recovery becomes nearly impossible. |

---

## 🧩 **Use Case: Secure Cleanup Script**

You can automate shredding sensitive files:

```bash
#!/bin/bash
# secure_clean.sh
FILES="/home/mahin/confidential /tmp/secrets.txt /var/tmp/passlist.txt"

for FILE in $FILES; do
    if [ -f "$FILE" ]; then
        shred -u -z -v "$FILE"
        echo "Shredded: $FILE"
    fi
done
```

Run:

```bash
sudo bash secure_clean.sh
```

---

## 📜 **Summary Table**

| Task                        | Command                  |
| --------------------------- | ------------------------ |
| Overwrite only              | `shred file.txt`         |
| Overwrite & delete          | `shred -u file.txt`      |
| Overwrite N times           | `shred -n 5 file.txt`    |
| Overwrite, zero out, delete | `shred -u -z file.txt`   |
| Show progress               | `shred -v file.txt`      |
| Force overwrite             | `shred -f file.txt`      |
| Wipe directory files        | `shred -u -z -v /path/*` |

---

## 🧩 **Exit Codes**

| Code | Meaning                                            |
| ---- | -------------------------------------------------- |
| `0`  | Success                                            |
| `1`  | Partial failure (some files not overwritten)       |
| `2`  | Serious error (invalid input or permission denied) |

---

## ✅ **In Short**

> 🔐 `shred` is a **secure file erasure tool** that overwrites file contents multiple times to prevent recovery.
> Use with **`-u`** to delete, **`-z`** to hide traces, and **`-n`** to control overwrite passes.


# 🧩 `md5sum` Command in Linux

* `md5sum` is a command-line utility used to **generate** and **verify** MD5 (Message-Digest Algorithm 5) **checksums** — unique 128-bit hashes that help ensure **file integrity**.
* MD5 produces a 128-bit cryptographic hash (a 32-character hexadecimal string).
* It helps ensure file authenticity and integrity, especially after downloading or transferring files.

> It’s commonly used to check whether a file has been altered or corrupted during download or transfer.

### Why md5sum Is Important
* Suppose you download an operating system ISO file — before installing, you should verify the file’s integrity using an MD5 checksum.
* This ensures that the file wasn’t corrupted or replaced by malicious software (like a virus or trojan).

---

## ⚙️ Basic Syntax

```bash
md5sum [OPTION]... [FILE]...
```

If no file is provided, it reads from **standard input (stdin)**.

---

## 🧾 Example: Generate MD5 Checksum

```bash
md5sum file.txt
```

**Output:**

```
d41d8cd98f00b204e9800998ecf8427e  file.txt
```

* The first part is the **MD5 hash**.
* The second part is the **filename**.

---

## 📥 Save MD5 Hash to a File

```bash
md5sum file.txt > file.txt.md5
```

This stores the checksum so it can be verified later.

---

## 🔍 Verify File Integrity

```bash
md5sum -c file.txt.md5
```

**Output:**

```
file.txt: OK
```

If the file was modified, you’ll get:

```
file.txt: FAILED
md5sum: WARNING: 1 computed checksum did NOT match
```

### Create BSD-Style Checksum

```bash
md5sum --tag /home/mandeep/test/test.cpp
```

**Output:**

```
MD5 (/home/mandeep/test/test.cpp) = c6779ec2960296ed9a04f08d67f64422
```

---

### 🧩 **Example 3: Use `--quiet` Option**

Suppress successful verification messages.

```bash
md5sum -c --quiet checkmd5.md5
```

✅ **No output** means everything verified correctly.
❌ If mismatch:

```
/home/mandeep/test/test.cpp: FAILED
md5sum: WARNING: 1 computed checksum did NOT match
```

---

### Use `--warn` Option

Warns about improperly formatted checksum files.

File content (correct format):

```
c6779ec2960296ed9a04f08d67f64422 /home/mandeep/test/test.cpp
```

Command:

```bash
md5sum -c --warn checkmd5.md5
```

**Output:**

```
/home/mandeep/test/test.cpp: OK
```

Now, if file `checkmd5.md5` is formatted incorrectly:

```
c6779ec2960296ed9a04f08d67f64422 
/home/mandeep/test/test.cpp
```

Then:

```bash
md5sum -c --warn checkmd5.md5
```

**Output:**

```
md5sum: checkmd5.md5: 1: improperly formatted MD5 checksum line
md5sum: checkmd5.md5: 2: improperly formatted MD5 checksum line
md5sum: checkmd5.md5: no properly formatted MD5 checksum lines found
```

If `--strict` is used instead of `--warn`, it will exit with a **non-zero** status for the error:

```bash
md5sum -c --strict checkmd5.md5
```

**Output:**

```
md5sum: checkmd5.md5: no properly formatted MD5 checksum lines found
```
---

## 🧰 Common Options

| Option             | Description                                             |
| ------------------ | ------------------------------------------------------- |
| `-b`, `--binary`   | Read files in **binary mode**. Default on Unix.         |
| `-t`, `--text`     | Read files in **text mode**. Default on non-Unix.       |
| `-c`, `--check`    | Check MD5 sums against a list (created earlier).        |
| `--tag`            | Create BSD-style checksum output.                       |
| `--ignore-missing` | Skip missing files without failing verification.        |
| `--quiet`          | Suppress “OK” messages. Only show failures.             |
| `--status`         | Don’t output anything, just set exit status.            |
| `--strict`         | Exit with nonzero status on improperly formatted lines. |
| `--help`           | Display help message.                                   |
| `--version`        | Display version information.                            |

---

## 💡 Examples

### 1️⃣ Generate hash for multiple files

```bash
md5sum file1.txt file2.txt file3.txt
```

### 2️⃣ Check multiple files from checksum list

```bash
md5sum -c checksums.md5
```

### 3️⃣ Combine with `find` to create checksums recursively

```bash
find . -type f -exec md5sum {} \; > all_sums.md5
```

### 4️⃣ Compare two files directly

```bash
md5sum file1.txt file2.txt
```

Compare hashes — if different, files differ.

---

## 🧮 Example Output File Format

Content of `checksums.md5`:

```
d41d8cd98f00b204e9800998ecf8427e  file1.txt
5eb63bbbe01eeed093cb22bb8f5acdc3  file2.txt
```

---

## ⚠️ Security Note

> 🔒 **MD5 is not secure** for cryptographic purposes (it can be easily spoofed).
> It’s fine for file integrity checks but **not suitable for verifying authenticity** or **password hashing**.
> ⚠️ MD5 is **not cryptographically secure** — it’s vulnerable to **hash collisions**.

Use stronger alternatives for security:

* `sha1sum`
* `sha256sum`
* `sha512sum`

Example:

```bash
sha256sum file.iso
```

---

## ✅ Exit Status Codes

| Status | Meaning                               |
| ------ | ------------------------------------- |
| `0`    | All verified files matched            |
| `1`    | At least one file failed verification |
| `2`    | Syntax or usage error                 |

---

## ✅ Summary Table

| Task                      | Command                       |
| ------------------------- | ----------------------------- |
| Generate checksum         | `md5sum file.txt`             |
| Save checksum to file     | `md5sum file.txt > file.md5`  |
| Verify checksum           | `md5sum -c file.md5`          |
| Quiet verification        | `md5sum -c --quiet file.md5`  |
| Create BSD-style checksum | `md5sum --tag file.txt`       |
| Warn about format issues  | `md5sum -c --warn file.md5`   |
| Silent verification       | `md5sum -c --quiet file.md5`  |
| Strict format checking    | `md5sum -c --strict file.md5` |
| Verify recursively        | `find . -type f -exec md5sum {} \; > sums.md5`|


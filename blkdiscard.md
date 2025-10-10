# 🧩 **`blkdiscard` Command in Linux**

---

## 🧠 **What is `blkdiscard`?**

`blkdiscard` is a Linux command used to **discard (TRIM or deallocate)** all blocks on a block device — such as an **SSD, NVMe drive, or partition**.

It tells the storage device that the blocks are **no longer in use**, allowing it to **erase or reset** them internally.
This can be used to:

* Securely **wipe all data** on a disk (irreversible)
* **Free up space** on thin-provisioned storage
* Trigger **TRIM** on SSDs to maintain performance

---

## ⚙️ **Syntax**

```bash
blkdiscard [OPTIONS] <device>
```

**Example:**

```bash
sudo blkdiscard /dev/sdb
```

This **discards all data blocks** on `/dev/sdb` (like a full erase).

---

## ⚠️ **Warning**

> 💀 `blkdiscard` is **destructive**. All data on the device or partition will be **lost permanently** and **cannot be recovered** — even with forensic tools.

---

## 🧩 **Options**

| Option               | Description                                                 |
| -------------------- | ----------------------------------------------------------- |
| `-f`, `--force`      | Force discard even if device appears mounted or in use      |
| `-o <offset>`        | Start discarding from a specific byte offset                |
| `-l <length>`        | Length (in bytes) to discard                                |
| `-p`, `--step <num>` | Step size between discards (for debugging or partial wipes) |
| `-s`, `--secure`     | Try a secure discard (if supported by the device)           |
| `-v`, `--verbose`    | Show detailed output                                        |
| `--version`          | Show version information                                    |
| `--help`             | Display help message                                        |

---

## 🧾 **Examples**

### 1️⃣ **Wipe an Entire Drive**

```bash
sudo blkdiscard /dev/sdb
```

✅ Erases all data on `/dev/sdb` by discarding all blocks.

---

### 2️⃣ **Wipe a Partition**

```bash
sudo blkdiscard /dev/sdb1
```

✅ Securely wipes only `/dev/sdb1`, not the whole disk.

---

### 3️⃣ **Verbose Mode**

```bash
sudo blkdiscard -v /dev/sdb
```

Shows progress:

```
blkdiscard: /dev/sdb: Discarded 128 GiB (137438953472 bytes)
```

---

### 4️⃣ **Partial Discard (Range)**

```bash
sudo blkdiscard -o 1G -l 10G /dev/sdb
```

🧮 Starts at 1 GiB offset and discards 10 GiB of blocks.

---

### 5️⃣ **Force Discard**

```bash
sudo blkdiscard -f /dev/sdb
```

⚠️ Even if the device is mounted, it forces discard.
Be very careful — this can **corrupt or destroy data** instantly.

---

### 6️⃣ **Secure Discard (if supported)**

```bash
sudo blkdiscard -s /dev/nvme0n1
```

Uses the **secure discard** feature built into some SSDs and NVMe drives.

If supported, this triggers **internal flash erase commands** for extra security.

---

## ⚙️ **How It Works**

* Filesystems normally "delete" files by marking their blocks as unused.
* `blkdiscard` tells the **underlying block device** to **physically discard or reset** those blocks.
* On SSDs, this means issuing **TRIM** or **SECURE ERASE** commands.
* On thin-provisioned LVM, it releases space back to the storage pool.

---

## 💡 **Difference Between `blkdiscard` and `shred`**

| Feature          | `shred`                     | `blkdiscard`           |
| ---------------- | --------------------------- | ---------------------- |
| Level            | File level                  | Block device level     |
| Works on         | Individual files            | Whole disk/partition   |
| Action           | Overwrites with random data | Discards blocks (TRIM) |
| Suitable for HDD | ✅ Yes                       | ⚠️ Not ideal           |
| Suitable for SSD | ⚠️ No                       | ✅ Yes                  |
| Speed            | Slower (writes repeatedly)  | Very fast              |
| Security         | Good for HDDs               | Excellent for SSDs     |

---

## 🧰 **Use Case: Securely Wipe SSD Before Reuse**

```bash
sudo umount /dev/nvme0n1p1
sudo blkdiscard -v /dev/nvme0n1
```

✅ Completely erases SSD
✅ Much faster and more secure than overwriting

---

## 🧩 **Check if Device Supports Discard**

Before using:

```bash
lsblk --discard
```

Output example:

```
NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
sda           0      512B       2G         0
sdb           0      512B       2G         0
nvme0n1       0      4K         16G        1
```

If `DISC-GRAN` and `DISC-MAX` show non-zero values, **discard is supported**.

---

## 📜 **Summary**

| Task                  | Command                                        |
| --------------------- | ---------------------------------------------- |
| Wipe a disk           | `sudo blkdiscard /dev/sdX`                     |
| Wipe a partition      | `sudo blkdiscard /dev/sdX1`                    |
| Secure discard        | `sudo blkdiscard -s /dev/sdX`                  |
| Force discard         | `sudo blkdiscard -f /dev/sdX`                  |
| Verbose mode          | `sudo blkdiscard -v /dev/sdX`                  |
| Partial range discard | `sudo blkdiscard -o OFFSET -l LENGTH /dev/sdX` |

---

## ⚠️ **Best Practices**

* Always **unmount the filesystem** before using `blkdiscard`.
* Use on **entire drives or unformatted partitions**.
* Never run it on system disks (like `/dev/sda` where `/` is mounted).
* Works best for **SSD**, **NVMe**, and **thin-provisioned LVM**.

---

## ✅ **In Short**

> 🔐 `blkdiscard` is a **low-level secure erase tool** that issues discard (TRIM) commands to block devices.
> It’s **ideal for SSDs and NVMe drives**, and much faster and more secure than file-based wiping tools like `shred`.

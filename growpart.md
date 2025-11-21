* A command from the **cloud-utils-growpart** package.
* Used to **grow/extend a partition**, usually when:

  * You increased a disk size on a VM (AWS, Azure, GCP, VMware, KVM).
  * You extended an underlying block device (EBS volume, LVM PV, etc.)
* Works for **MBR** and **GPT**.
* Only increases the size — cannot shrink partitions.

---

# ⭐ **Install growpart**

```
sudo apt install cloud-guest-utils      # Ubuntu/Debian
sudo yum install cloud-utils-growpart   # RHEL/CentOS/Rocky
sudo dnf install cloud-utils-growpart   # Fedora/RHEL9+
```

---

# ⭐ **Basic Syntax**

```
growpart <device> <partition-number>
```

Examples:

```
growpart /dev/xvda 1
growpart /dev/nvme0n1 2
growpart /dev/sda 3
```

---

# ⭐ **How growpart Works Internally**

* Reads the device partition table (GPT or MBR).
* Calculates available **unused disk space** after the partition.
* Modifies the table to extend only **that partition**.
* Does NOT touch filesystems.
* You must separately resize:

  * `resize2fs` → for ext2/ext3/ext4
  * `xfs_growfs` → for XFS
  * `btrfs filesystem resize` → for BtrFS

---

# ⭐ **Full Workflow — Most Common Use Case**

You extended your AWS/GCP/Azure disk from console → Now extend partition and filesystem.

### Step 1 — Verify new disk size

```
lsblk
fdisk -l
```

### Step 2 — Grow the partition

Example for `/dev/xvda1`:

```
sudo growpart /dev/xvda 1
```

### Step 3 — Resize filesystem

#### ext4

```
sudo resize2fs /dev/xvda1
```

#### XFS

```
sudo xfs_growfs /
# OR for non-root xfs:
sudo xfs_growfs /mountpoint
```

---

# ⭐ **All growpart Options (FULL LIST with explanation)**

### ✔️ **growpart --help**

Here are the options:

```
growpart [--dry-run] [--force] [--verbose] [--update] DEVICE PART
```

### ✔️ **--dry-run**

* Shows what will happen **without changing anything**.

```
growpart --dry-run /dev/sda 2
```

### ✔️ **--force**

* Forces grow even if growpart thinks it is unsafe.
* **Use with caution**.

```
growpart --force /dev/sdb 1
```

### ✔️ **--verbose**

* Prints detailed internal operations.

```
growpart --verbose /dev/nvme0n1 3
```

### ✔️ **--update**

* Forcefully updates the partition even if size is same.
* Rare use-case.

```
growpart --update /dev/sda 1
```

---

# ⭐ **growpart Examples for Every Scenario**

---

## ✔️ **1. Extend Root Partition (Most Common)**

Disk: `/dev/nvme0n1`
Root partition: `p1`

```
growpart /dev/nvme0n1 1
resize2fs /dev/nvme0n1p1    # ext4
# or
xfs_growfs /                # XFS
```

---

## ✔️ **2. Extend Non-root Mounted Partition**

```
growpart /dev/sdb 2
resize2fs /dev/sdb2
```

---

## ✔️ **3. Extend LVM PV inside a partition**

Partition: `/dev/sda3`

```
growpart /dev/sda 3
pvresize /dev/sda3
lvextend -r -L +20G /dev/vgname/lvname
```

---

## ✔️ **4. Extend Partition on GPT Disk**

Same process — growpart detects GPT automatically.

```
growpart /dev/nvme0n1 4
resize2fs /dev/nvme0n1p4
```

---

## ✔️ **5. When growpart fails with "FAILED: sfdisk"**

Fix:

```
sudo apt install gdisk
sudo sgdisk -e /dev/sda
sudo growpart /dev/sda 1
```

---

## ✔️ **6. growpart on Cloud (AWS Example)**

Increase EBS volume → VM reboot not needed → run:

```
lsblk
growpart /dev/xvda 1
resize2fs /dev/xvda1
```

---

# ⭐ **Important Notes & Warnings**

* ❗ growpart **must only be run on stopped or unmounted partitions** except root (safe if online).
* ❗ Cannot shrink partitions.
* ❗ XFS cannot shrink even if partition is shrunk manually.
* ❗ Always take snapshot in cloud environments.

---

# ⭐ **Verify After Growing**

```
lsblk -f
df -h
sudo parted -l
```

---

# ⭐ **Troubleshooting growpart**

### ❌ Error: FAILED: disk too small

Cause: No space after partition.

### ❌ Error: sfdisk unexpected token

Cause: Corrupted partition table
Fix:

```
sgdisk -e /dev/sda
```

### ❌ Error: partition ends in the middle

Cause: Old MBR alignment
Fix:

```
growpart --force /dev/sda 1
```


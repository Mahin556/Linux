# **🔥 `gdisk` Complete Guide (GPT fdisk Tutorial)**

*(Think of `gdisk` as the GPT-version of `fdisk` — used for disks using **GPT partition tables**.)*

---

# **🌟 What is `gdisk`?**

* GPT fdisk = `gdisk`
* Used to **create, modify, delete, repair** GPT partition tables.
* Works with disks: `/dev/sda`, `/dev/nvme0n1`, `/dev/vdb`, etc.
* Supports:

  * BIOS + GPT
  * UEFI + GPT
  * Hybrid MBR/GPT
* Safer than `fdisk` (which is mainly for MBR disks).

---

# **🔥 When Should You Use `gdisk`?**

* When the disk uses **GPT** instead of MBR.
* When creating disks bigger than 2 TB (MBR limit).
* For cloud servers (AWS, Azure, GCP disks = GPT by default).
* For modern Linux systems booting with **UEFI**.

---

# **🎯 Basic Syntax**

```
sudo gdisk /dev/sdX
```

Example:

```
sudo gdisk /dev/sda
```

---

# **📌 `gdisk` Main Menu (Commands Explained Simply)**

### **a – Show advanced menu**

* Opens more expert functions.

### **b – Backup GPT table to file**

```
b
Enter backup filename: gpt-backup.img
```

### **c – Change partition GUID**

* Modifies the unique 128-bit GUID of a specific partition.

### **d – Delete a partition**

```
d
Partition number: 1
```

### **i – Partition information**

Shows:

* Type GUID
* Unique GUID
* First sector
* Last sector
* Attributes

### **l – Show known partition type codes**

Example type codes:

* `8300` – Linux filesystem
* `8200` – Linux swap
* `EF00` – EFI System Partition
* `8302` – Linux /home
* `8301` – Linux /boot

### **n – Create a new partition**

```
n
Partition number: (press Enter)
First sector: (press Enter)
Last sector: +20G
Hex code: 8300
```

### **o – Create a new GPT table (DESTROYS all data)**

```
o
```

Use with caution.

### **p – Print partition table**

Shows all partitions + their GPT data.

### **q – Quit without saving**

### **r – Recovery & transformation menu**

Used for repairing corrupted GPT or converting MBR → GPT.

### **s – Sort partitions**

Useful if partitions are out of order.

### **t – Change partition type code**

```
t
Partition number: 1
Hex code: 8300
```

### **v – Verify partition table**

It checks for:

* Overlapping partitions
* Wrong sector alignment
* Damaged GPT

### **w – Write changes to disk & exit**

**⚠️ WARNING:** Irreversible.

---

# **🔥 Full Workflow: Create New Partition Using `gdisk`**

```
sudo gdisk /dev/sda
n            # new partition
Partition number: Press Enter
First sector: Press Enter
Last sector: +10G
Hex code: 8300  # Linux filesystem
w            # write changes
y
```

---

# **🧪 Check Partition**

```
lsblk
blkid
```

---

# **📌 Format the New Partition**

```
sudo mkfs.ext4 /dev/sdaX
```

---

# **📌 Mount It**

```
sudo mkdir /data
sudo mount /dev/sdaX /data
```

---

# **💾 Permanent Mount (Add in /etc/fstab)**

Get UUID:

```
sudo blkid /dev/sdaX
```

Add to `/etc/fstab`:

```
UUID=xxxxxx   /data   ext4   defaults   0 0
```

---

# **🆚 `gdisk` vs `fdisk`**

| Feature              | `fdisk`   | `gdisk`        |
| -------------------- | --------- | -------------- |
| Disk Type            | MBR       | GPT            |
| Max Disk Size        | 2 TB      | Unlimited      |
| Number of Partitions | 4 primary | 128 partitions |
| UEFI Support         | ❌ No      | ✅ Yes          |
| Recovery Features    | Basic     | Advanced       |

---

# **🛠 Advanced `gdisk` Features**

### **1. Convert MBR → GPT (Without Data Loss)**

```
sudo gdisk /dev/sda
r
g
w
y
```

### **2. Convert GPT → MBR**

(Only if disk ≤ 2TB & ≤ 4 partitions)

```
sudo gdisk /dev/sda
r
h      # hybrid MBR
```

### **3. Recover Damaged GPT**

```
sudo gdisk /dev/sda
v      # verify GPT
```

### **4. Backup GPT**

```
sudo gdisk /dev/sda
b
gpt-backup.img
```

### **5. Restore GPT**

```
sudo gdisk /dev/sda
l
gpt-backup.img
```

---

# **🧵 Real Linux Example**

```
sudo gdisk /dev/nvme0n1
Command: p
Number  Start (sector)    End (sector)   Size    Code  Name
 1         2048             1050623      512M    EF00  EFI system partition
 2      1050624            9437183       4G      8200  Swap
 3      9437184          250069646       120G    8300  RootFS
```

---

# **🔥 Safety Tips**

* Always check disk name with:

```
lsblk
```

* Never run `o` unless you want to wipe GPT.
* Back up GPT before manipulation:

```
gdisk /dev/sdX → b
```


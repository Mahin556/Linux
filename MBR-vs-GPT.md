## **MBR vs GPT — Complete Guide**

---

## 🔵 **1. What is MBR (Master Boot Record)?**

* **Introduced in 1983** (very old partitioning scheme).
* Stores partitioning information in the **first 512 bytes** of the disk.
* Contains:

  * **Bootstrap code**
  * **Partition Table (4 entries)**
  * **Disk signature**
* Supports **maximum disk size = 2 TB**.
* Supports **maximum 4 primary partitions**.
* To create more than 4 partitions → must use **Extended + Logical partitions**.
* Uses **32-bit LBA**, limiting addressable storage.

---

## 🔵 **2. What is GPT (GUID Partition Table)?**

* Introduced with **UEFI** (modern systems).
* Stores partition data in multiple places:

  * **Primary GPT header at the beginning**
  * **Backup GPT header at the end of disk** (redundancy)
* Supports **maximum disk size = 9.4 ZB** (zettabytes).
* Supports **128 partitions** (in Linux, configurable).
* Uses **64-bit LBA**, allowing very large disks.
* More robust — has CRC32 checksums for corruption detection.
* Required for disks used in **UEFI boot mode**.

---

## 🔵 **3. Key Differences (MBR vs GPT)**

| Feature                     | MBR                    | GPT                         |
| --------------------------- | ---------------------- | --------------------------- |
| **Age**                     | Old (1983)             | Modern (2006)               |
| **Partition limit**         | 4 primary              | 128 partitions              |
| **Max disk size**           | 2 TB                   | 9.4 ZB                      |
| **Partition table storage** | Only at start          | Start + End (backup)        |
| **Data integrity**          | No checksums           | CRC32 checksum              |
| **Boot support**            | BIOS only              | UEFI (can work with BIOS)   |
| **Recovery**                | Hard                   | Easy (backup header)        |
| **OS compatibility**        | All OS                 | Older OS may not support    |
| **Security**                | No built-in protection | Supports Secure Boot (UEFI) |

---

## 🔵 **4. When should you use MBR?**

* Your system uses **Legacy BIOS** (not UEFI).
* The disk size is **2 TB or less**.
* You need compatibility with very old OS (Windows XP, old Linux distros).

---

## 🔵 **5. When should you use GPT?**

* Your system uses **UEFI boot mode** (modern laptops/servers).
* Disk size is **larger than 2 TB**.
* For modern OS: Windows 10/11, RHEL/CentOS, Ubuntu, etc.
* For improved:

  * Reliability
  * Performance
  * Error recovery

---

## 🔵 **6. Technical Structure Comparison**

### **MBR Structure**

* 0–446 bytes → Bootloader
* 446–510 bytes → Partition table (4 entries)
* 510–512 bytes → Boot signature (0x55AA)

### **GPT Structure**

* LBA 0 → Protective MBR (to avoid old tools overwriting)
* LBA 1 → Primary GPT header
* LBA 2+ → Partition table entries
* Last LBA → Backup GPT header

---

## 🔵 **7. Commands to view MBR/GPT in Linux**

```
# Check partition table type
sudo parted -l

# Using fdisk (shows GPT or DOS/MBR)
sudo fdisk -l

# Using gdisk (shows GPT details)
sudo gdisk -l /dev/sda

# Convert MBR → GPT (non-destructive)
sudo gdisk /dev/sda
# press 'w' to write
```

---

## 🔵 **8. OS Compatibility**

### **Supports GPT:**

* Linux (all modern distros)
* Windows 7+ (64-bit UEFI)
* macOS
* VMware/Hyper-V/QEMU

### **Requires MBR:**

* Windows 32-bit (UEFI unsupported)
* Very old OS


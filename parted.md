• `parted` is a **powerful command-line disk partitioning tool** used on Linux.
• Unlike `fdisk`, it supports **GPT and MBR**, and can manage **very large disks (>2TB)**.
• `parted` can create, resize, delete, move, copy, check, recover partitions.
• Works interactively or in **script mode** (non-interactive).
• Can set **GPT partition flags** (boot, esp, msftdata, raid, lvm, etc).
• Supports **exact disk sector alignment** for SSD performance.

`parted` is used when:

• Creating new servers
• Working with GPT disks
• Managing disks >2TB
• Automating disk provisioning
• Recovering destroyed partition tables
• Cloud VM disk manipulation
• LVM + RAID deployments

---

# **Check parted version**

```bash
parted --version
```

---

# **Basic Check of Disk**

```bash
sudo parted /dev/sda print
```

Shows:
• Model
• Disk size
• Sector sizes
• Partition Table (GPT/MBR)
• All partitions

---

# **Start Interactive Mode**

```bash
sudo parted /dev/sda
```

You now see:

```
GNU Parted 3.3
Using /dev/sda
(parted)
```

---

# ============================================================

# **1. Creating a Partition Table (GPT/MBR)**

# ============================================================

## **Create GPT**

```bash
(parted) mklabel gpt
```

## **Create MBR**

```bash
(parted) mklabel msdos
```

⚠️ **WARNING: This deletes ALL partitions on the disk.**

Check result:

```bash
(parted) print
```

---

# ============================================================

# **2. Displaying Disk Information**

# ============================================================

## **Show partitions**

```bash
(parted) print
```

## **Show free space**

```bash
(parted) print free
```

## **Show alignment info**

```bash
(parted) align-check optimal 1
```

---

# ============================================================

# **3. Creating Partitions**

# ============================================================

## **Syntax**

```bash
mkpart PARTITION_NAME FILESYSTEM_TYPE START END
```

### Example 1 — Create 1GB ext4 partition

```bash
(parted) mkpart primary ext4 1MiB 1025MiB
```

### Example 2 — Create Linux swap

```bash
(parted) mkpart primary linux-swap 1025MiB 2049MiB
```

### Example 3 — Create partition using % values

```bash
(parted) mkpart primary ext4 0% 50%
```

### Example 4 — Create GPT EFI partition

```bash
(parted) mkpart ESP fat32 1MiB 513MiB
(parted) set 1 boot on
(parted) set 1 esp on
```

### Example 5 — Using sectors

```bash
unit s
mkpart primary ext4 2048s 2097151s
```

---

# ============================================================

# **4. Removing Partitions**

# ============================================================

```bash
(parted) rm 2
```

Removes partition number 2.

---

# ============================================================

# **5. Resizing Partitions**

# ============================================================

⚠️ **Risky operation. Backup first.**

## **Resize Example**

Expand to 20GB:

```bash
(parted) resizepart 1 20GB
```

Shrink:

```bash
(parted) resizepart 1 5GB
```

After that run filesystem-specific tool:

### ext4:

```bash
sudo resize2fs /dev/sda1
```

### xfs cannot shrink:

```bash
sudo xfs_growfs /mnt
```

---

# ============================================================

# **6. Moving Partitions**

# ============================================================

```bash
(parted) move 2 10GB 20GB
```

Moves partition #2.

---

# ============================================================

# **7. Copying Partitions**

# ============================================================

GPT partition copy:

```bash
(parted) cp 1 2
```

Copies partition #1 → #2.

---

# ============================================================

# **8. Partition Flags (GPT flags)**

# ============================================================

Check flags:

```bash
(parted) print
```

Set bootable flag:

```bash
(parted) set 1 boot on
```

Disable:

```bash
(parted) set 1 boot off
```

### **Common Flags**

| Flag          | Use                       |
| ------------- | ------------------------- |
| **boot**      | BIOS boot / legacy boot   |
| **esp**       | EFI System Partition      |
| **msftdata**  | Windows partition         |
| **raid**      | RAID member               |
| **lvm**       | LVM PV                    |
| **swap**      | Swap                      |
| **hidden**    | Hidden partition          |
| **bios_grub** | BIOS GRUB partition (1MB) |

### Example — Mark partition as LVM

```bash
(parted) set 2 lvm on
```

---

# ============================================================

# **9. Scripting Mode (Non-interactive)**

# ============================================================

Used in automation / cloud-init / DevOps provisioning.

```bash
sudo parted -s /dev/sdb mklabel gpt
sudo parted -s /dev/sdb mkpart primary ext4 1MiB 100%
```

`-s` = script mode (no prompts)

---

# ============================================================

# **10. Working with Units**

# ============================================================

Change units:

```bash
(parted) unit MiB
(parted) unit s
(parted) unit GB
```

Return to default:

```bash
(parted) unit %
```

---

# ============================================================

# **11. Rescue Lost Partitions**

# ============================================================

If you lost GPT entries, use:

```bash
(parted) rescue START END
```

Example, search the whole disk:

```bash
(parted) rescue 0% 100%
```

It will attempt to recover partitions.

---

# ============================================================

# **12. Checking File System**

# ============================================================

(parted) cannot fsck itself, but calls external tools.

```bash
(parted) check 1
```

Runs fsck for ext2/3/4 if possible.

---

# ============================================================

# **13. Alignment & SSD Optimization**

# ============================================================

Check optimal alignment:

```bash
(parted) align-check optimal 1
```

Output:

```
1 aligned
```

Ensure partitions start at **1MiB** (2048-sector boundary):

```bash
mkpart primary ext4 1MiB 100%
```

---

# ============================================================

# **14. Full Example — Create GPT Disk for Linux Server**

# ============================================================

```bash
sudo parted /dev/sda --script \
    mklabel gpt \
    mkpart ESP fat32 1MiB 513MiB \
    set 1 esp on \
    mkpart primary ext4 513MiB 5GiB \
    mkpart primary linux-swap 5GiB 9GiB \
    mkpart primary ext4 9GiB 100% \
```

---

# ============================================================

# **15. Full Example — Create LVM Layout**

# ============================================================

```bash
sudo parted -s /dev/sdb mklabel gpt
sudo parted -s /dev/sdb mkpart primary 1MiB 100%
sudo parted -s /dev/sdb set 1 lvm on
```

Then:

```bash
pvcreate /dev/sdb1
vgcreate vgdata /dev/sdb1
lvcreate -L 20G -n lv1 vgdata
```

---

# ============================================================

# **16. Full Example — Create Partition Larger than 2TB**

# ============================================================

```bash
parted /dev/sdc mklabel gpt
parted /dev/sdc mkpart primary ext4 1MiB 4TB
```

---

# ============================================================

# **17. partprobe & Kernel Refresh**

# ============================================================

When partitions change:

```bash
sudo partprobe
```

Or:

```bash
sudo partx -u /dev/sda
```

---

# ============================================================

# **18. Quit**

# ============================================================

```bash
(parted) quit
```


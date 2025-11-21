

• `mkfs` = **Make FileSystem**
It formats a block device (disk/partition/LV/loop device) with a new filesystem.

• WARNING: Running mkfs on any device **erases data** completely.

• `mkfs` is a *frontend wrapper*. Actual creation is done using filesystem-specific tools like:
• `mkfs.ext4`
• `mkfs.xfs`
• `mkfs.vfat`
• `mkfs.btrfs`
• `mkfs.f2fs`
• `mkswap`
• `mkfs.ntfs` (from ntfs-3g)
• `mkfs.exfat`

---

• Basic syntax:
`mkfs -t <fstype> <device>`
Example:
`mkfs -t ext4 /dev/sdb1`

• Or use filesystem-specific tool directly (recommended):
`mkfs.ext4 /dev/sdb1`

---

• List all available filesystem creators on system:
`ls /usr/sbin/mkfs.*`

---

• Before using mkfs, always check device:
`lsblk -f`
`blkid`
`df -h`

---

### **EXT4 — mkfs.ext4 (most common in Linux)**

• Create ext4 filesystem:
`mkfs.ext4 /dev/sdb1`

• Add a label:
`mkfs.ext4 -L DATA /dev/sdb1`

• Specify block size (1K, 2K, 4K):
`mkfs.ext4 -b 4096 /dev/sdb1`

• Set inode size:
`mkfs.ext4 -I 256 /dev/sdb1`

• Disable journaling (like ext2):
`mkfs.ext4 -O ^has_journal /dev/sdb1`

• Enable large directory hashing:
`mkfs.ext4 -O dir_index /dev/sdb1`

• Create filesystem with UUID:
`mkfs.ext4 -U random /dev/sdb1`

• Reserved blocks for root (default 5%):
`mkfs.ext4 -m 0 /dev/sdb1`
Good for storage disks not used for root FS.

• Check what ext4 features are enabled:
`tune2fs -l /dev/sdb1`

---

### **XFS — mkfs.xfs (default FS on RHEL/CentOS/Rocky)**

• Create XFS filesystem:
`mkfs.xfs /dev/sdb1`

• Add label:
`mkfs.xfs -L DATA /dev/sdb1`

• Set UUID manually:
`mkfs.xfs -m uuid=<UUID> /dev/sdb1`

• Stripe size (important on RAID/HPC storage):
`mkfs.xfs -d su=256k,sw=4 /dev/md0`

• Disable reflink (for performance):
`mkfs.xfs -m reflink=0 /dev/sdb1`

• Disable CRC (old compatibility):
`mkfs.xfs -m crc=0 /dev/sdb1`

• Check XFS info:
`xfs_info /mountpoint`
`xfs_repair` for repair

---

### **BTRFS — mkfs.btrfs**

• Create BTRFS filesystem:
`mkfs.btrfs /dev/sdb1`

• Label:
`mkfs.btrfs -L mybtrfs /dev/sdb1`

• Multi-device BTRFS:
`mkfs.btrfs -m raid1 -d raid1 /dev/sdb1 /dev/sdc1`

• Force overwrite:
`mkfs.btrfs -f /dev/sdb1`

• Seeding device:
`mkfs.btrfs -S /dev/sdb1`

---

### **FAT32 / VFAT — mkfs.vfat**

• Create FAT32 filesystem:
`mkfs.vfat -F 32 /dev/sdb1`

• Label:
`mkfs.vfat -n USB /dev/sdb1`

• Set UUID:
`mkfs.vfat -i 1234ABCD /dev/sdb1`

---

### **exFAT — mkfs.exfat (exfatprogs)**

• Create exFAT:
`mkfs.exfat /dev/sdb1`

• Label:
`mkfs.exfat -n MYUSB /dev/sdb1`

---

### **F2FS — mkfs.f2fs (for SSD/mobile flash)**

• Create filesystem:
`mkfs.f2fs /dev/sdb1`

• Sector size:
`mkfs.f2fs -s 4 /dev/sdb1`

• Label:
`mkfs.f2fs -l FLASH /dev/sdb1`

---

### **SWAP — mkswap**

• Create swap partition:
`mkswap /dev/sdb2`

• Add label:
`mkswap -L SWAP1 /dev/sdb2`

• Add UUID:
`mkswap -U random /dev/sdb2`

---

### **NTFS — mkfs.ntfs (ntfs-3g required)**

• Create NTFS partition:
`mkfs.ntfs /dev/sdb1`

• Quick format:
`mkfs.ntfs -Q /dev/sdb1`

• Label:
`mkfs.ntfs -L WIN /dev/sdb1`

---

### **General mkfs wrapper commands**

• Create FS using mkfs wrapper:
`mkfs -t ext4 /dev/sdb1`
`mkfs -t xfs /dev/sdb1`
(Same as calling mkfs.ext4 or mkfs.xfs)

• Show help for all FS types:
`mkfs -t ext4 -h`

• Force formatting even if device looks in-use:
`mkfs.ext4 -F /dev/sdb1`
`mkfs.xfs -f /dev/sdb1`

---

### **Very important safety commands**

• Check filesystem before formatting:
`blkid /dev/sdb1`
`lsblk -f`
`file -s /dev/sdb1`

• If you format wrong disk → data loss is permanent.

---

### **HPC-specific usage**

• Format local NVMe scratch disk on compute node:
`mkfs.xfs -f /dev/nvme0n1`

• Format BeeGFS local cache:
`mkfs.ext4 -m 0 -L beegfs_cache /dev/sdb1`

• Format Lustre MDT/OST device (requires e2fsprogs/lctl):
`mkfs.lustre --mdt --fsname=myfs --mgsnode=<IP> /dev/sdb`

• Format local SSD with ext4 optimized:
`mkfs.ext4 -O extent,uninit_bg,dir_index -L scratch /dev/nvme0n1p1`

---

### **Common mkfs commands (recommended shortlist)**

• Format ext4:
`mkfs.ext4 /dev/sdb1`

• Format XFS (RHEL default):
`mkfs.xfs /dev/sdb1`

• Format with label:
`mkfs.ext4 -L DATA /dev/sdb1`

• Force format:
`mkfs.ext4 -F /dev/sdb1`

• Create swap:
`mkswap /dev/sdb2`

• Format USB FAT32:
`mkfs.vfat -F 32 /dev/sdb1`

• Format NVMe for HPC scratch:
`mkfs.xfs -f /dev/nvme0n1`



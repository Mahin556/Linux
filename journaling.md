• Journaling is a **filesystem feature** that keeps a special log (journal) of changes before writing them to the main filesystem.

• Purpose: **prevent filesystem corruption** after crashes, power failures, or unexpected reboot.

• Without journaling, a crash could leave:
• half-written inodes
• inconsistent directory entries
• corrupted metadata
• lost files
• need for full fsck (very slow)

---

• Journaling filesystem = has a **journal area** that records operations first → then commits to disk.

• Filesystem updates happen in **two steps**:

1. Write to journal
2. Write to actual filesystem blocks
   If crash happens before step 2 → journal replays the pending ops.

---

• Journaling reduces recovery time from **hours** to **seconds**.

---

### **Major Linux filesystems that support journaling**

• ext3
• ext4
• XFS
• Btrfs
• ReiserFS
• JFS

(Note: FAT32/exFAT/NFS do NOT have journaling.)

---

### **What the journal actually stores**

• Metadata changes (always)
• Optionally: file data
• Superblock updates
• Allocation tables
• Directory structure
• Inode updates

---

### **Three journaling modes in EXT3 / EXT4**

• `data=journal`
• Both metadata + file data written to journal
• Safest
• Slowest
• Used where data integrity is critical (databases, banks)

• `data=ordered` (DEFAULT in ext4)
• Metadata written to journal
• File data written first → then metadata
• Prevents old garbage data exposure
• Best balance between safety + speed
• Most common

• `data=writeback`
• Only metadata journaled
• File data may be written anytime
• Fastest
• Least safe (can show old data after crash)
• Used for high-performance workloads

---

### **Checking current journaling mode**

• For ext4:
`tune2fs -l /dev/sda1 | grep 'Filesystem features'`
`mount | grep sda1` (shows `data=ordered`, etc.)

---

### **Enable journaling (if disabled)**

• Ext4 journaling off looks like ext2.
• Enable journal:
`tune2fs -j /dev/sda1`

---

### **Disable journaling**

• Only possible for ext4 → ext2 conversion:
`tune2fs -O ^has_journal /dev/sda1`
Then run fsck:
`fsck.ext4 -f /dev/sda1`

• Makes it behave like EXT2 (unsafe but faster).

---

### **Journal location**

• The journal can be:
• Inside filesystem (default)
• On a separate device (`journal_dev`) → high performance
Example:
`mkfs.ext4 -J device=/dev/sdc1 /dev/sdb1`
Typically in HPC & database servers.

---

### **Journaling in XFS**

• XFS journals **only metadata**, never data.
• Very fast and scalable journal (called log).
• Options:
`logdev=<device>` → external journal
`logbsize`, `logbufs` → tune journal performance

• Recovery after crash is almost instant.

---

### **Journaling in Btrfs**

• Btrfs uses **COW (Copy-on-Write)** instead of a traditional journal.
• COW inherently provides consistency:
• New blocks written
• Metadata updated
• Old blocks remain until commit
• Acts like “built-in journaling”.

---

### **Journal size**

• Ext4 default: 128 MB → can be increased.
• View journal size:
`dumpe2fs /dev/sda1 | grep Journal`

• Increase journal size during mkfs:
`mkfs.ext4 -J size=400 /dev/sda1`

---

### **How journaling speeds up recovery**

• On boot, fsck sees journal → replays last valid transaction → finished.
• Unlike non-journal filesystems, which require full slow check.

Example:
• 1 TB ext2 → fsck = 45 minutes
• 1 TB ext4 → journal replay = 2 seconds

---

### **What journaling does NOT protect from**

• Disk hardware failure
• Silent data corruption (use checksumming FS like Btrfs/ZFS)
• User error (“rm -rf”)
• Overwritten files
• Malware
• RAID controller issues

---

### **Performance impact**

• Journaling introduces **extra writes**.
• Modes comparison (slow → fast):
• data=journal
• data=ordered
• data=writeback
• SSDs/NVMe reduce the penalty significantly.

---

### **HPC-specific notes**

• HPC scratch disks often use:
• ext4 with data=writeback (faster)
• XFS with large log buffers
• NO journaling on distributed FS like Lustre, GPFS, BeeGFS (handled by metadata servers)

• Journaling overhead on shared filesystems (like Lustre OSTs) is avoided.

---

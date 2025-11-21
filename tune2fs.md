### **What tune2fs does**

• `tune2fs` is a powerful tool to **modify ext2/ext3/ext4 filesystem parameters** **without reformatting**.
• Used to change:
• labels
• mount-count
• reserved blocks
• journaling
• UUID
• features
• check intervals
• error behavior
• journal size
• filesystem flags
• Works **only** on ext2/ext3/ext4.

---

### **Always run safely**

• Ensure FS is **unmounted** before most operations (except read-only queries).
• Mount point:
`mount | grep sda1`
• Unmount:
`umount /dev/sda1`

---

### **Show all filesystem info (most common use)**

• `tune2fs -l /dev/sda1`

Shows:
• UUID
• Label
• Reserved blocks
• Block count
• Inode count
• Last mount time
• Mount count
• Features
• Journal info
• Check intervals
• And much more.

---

### **Set or change filesystem label**

• `tune2fs -L NEWLABEL /dev/sda1`
• Label shows in:
`lsblk -f`
`blkid`

---

### **Change UUID**

• Random UUID:
`tune2fs -U random /dev/sda1`

• Specific UUID:
`tune2fs -U <UUID> /dev/sda1`

• Clear UUID:
`tune2fs -U clear /dev/sda1`

---

### **Reserved blocks**

• By default ext4 reserves **5%** space for root.
• For big data disks, reduce it:

• Set reserved-blocks percentage:
`tune2fs -m 0 /dev/sda1`

• Set reserved blocks directly:
`tune2fs -r 0 /dev/sda1`

---

### **Enable journaling (convert ext2 → ext3/ext4)**

• `tune2fs -j /dev/sda1`

Creates a journal equivalent to ext3/ext4 journaling.

---

### **Disable journaling (convert ext4 → ext2-like)**

• `tune2fs -O ^has_journal /dev/sda1`
• Then run fsck:
`fsck.ext4 -f /dev/sda1`

Used only in special cases (embedded systems, HPC scratch).

---

### **Adjust mount-count check behavior**

• Maximum mounts before fsck:
`tune2fs -c <count> /dev/sda1`

Examples:
• Disable mount-count checking:
`tune2fs -c 0 /dev/sda1`

• Check after every 20 mounts:
`tune2fs -c 20 /dev/sda1`

• Reset mount count:
`tune2fs -C 0 /dev/sda1`

---

### **Adjust time-based fsck check**

• Interval between forced fscks:
`tune2fs -i <interval> /dev/sda1`

Examples:
• 6 months:
`tune2fs -i 6m /dev/sda1`

• 0 = disable:
`tune2fs -i 0 /dev/sda1`

Available suffixes:
• d = days
• w = weeks
• m = months
• y = years

---

### **Change filesystem error behavior**

• Options:
• `continue`
• `remount-ro`
• `panic`

• Set behavior:
`tune2fs -e remount-ro /dev/sda1`

Most common on critical systems.

---

### **Modify filesystem features**

• View current features:
`tune2fs -l /dev/sda1 | grep 'Filesystem features'`

• Add a feature:
`tune2fs -O <feature> /dev/sda1`

• Remove a feature:
`tune2fs -O ^<feature> /dev/sda1`

Examples:
• Disable journaling:
`tune2fs -O ^has_journal /dev/sda1`

• Enable metadata checksums:
`tune2fs -O metadata_csum /dev/sda1`

Most changes require fsck before mounting again.

---

### **Change journal options**

• Set journal size (MB):
`tune2fs -J size=400 /dev/sda1`

• Move journal to another device:
`tune2fs -J device=/dev/sdb1 /dev/sda1`

External journal improves performance.

---

### **Quotas**

Enable project quotas or user/group quotas:
• `tune2fs -O quota /dev/sda1`

Must be enabled at mount time.

---

### **Adjust reserved GDT blocks**

• Rarely needed but used for filesystem expansion:
`tune2fs -O resize_inode /dev/sda1`

---

### **Filesystem flags**

• Clear a filesystem state:
`tune2fs -E clear_mmp /dev/sda1`

• Clear journal hint checksum:
`tune2fs -E clear_journal_hint /dev/sda1`

• Set extended malloc debugging flags
(very advanced admin usage).

---

### **Enable/Disable lazy initialization**

• Enable lazy inode table initialization (default):
`tune2fs -E lazy_itable_init=1 /dev/sda1`

• Disable it:
`tune2fs -E lazy_itable_init=0 /dev/sda1`

---

### **HPC-specific tune2fs best practices**

• For large HPC scratch partitions:
• remove journaling:
`tune2fs -O ^has_journal /dev/nvme0n1p1`
• reduce reserved blocks to 0:
`tune2fs -m 0 /dev/nvme0n1p1`

• Disable forced fsck checks:
`tune2fs -i 0 -c 0 /dev/sda1`

• Project quotas for shared /scratch:
`tune2fs -O project`
mount with:
`usrjquota=aquota.user,grpjquota=aquota.group,prjquota`

---

### **Useful commands (daily usage)**

• Show filesystem details:
`tune2fs -l /dev/sda1`

• Change label:
`tune2fs -L DATA /dev/sda1`

• Disable mount-count checks:
`tune2fs -c 0 /dev/sda1`

• Set fsck every 6 months:
`tune2fs -i 6m /dev/sda1`

• Disable journaling:
`tune2fs -O ^has_journal /dev/sda1`

• Change UUID:
`tune2fs -U random /dev/sda1`

• Set reserved blocks to 0:
`tune2fs -m 0 /dev/sda1`

• Increase journal size:
`tune2fs -J size=512 /dev/sda1`

---

Here are the **filesystem error behaviors** in **Linux ext2/ext3/ext4**, explained very clearly and in **bullet points**, exactly as you prefer.

These options decide **what the kernel should do** when it detects a filesystem-level error (corruption, bad metadata, missing blocks, etc.).

---

## **Filesystem Error Behaviors (EXT4)**

Linux EXT filesystems support **3 possible error behaviors**:

---

### **1. `continue`**

• Kernel **prints an error message**
• System **continues running**
• Filesystem may remain **partially corrupted**
• Risky because further operations can make corruption worse
• Used only on **non-critical** data disks where uptime matters more than safety

Set with:

```
tune2fs -e continue /dev/sda1
```

---

### **2. `remount-ro`  (MOST COMMON & RECOMMENDED)**

• Kernel remounts filesystem **read-only**
• Prevents further writes → saves data from more corruption
• System stays running, but writes fail
• Best option for **system partitions**, `/var`, `/home`, `/data`

Set with:

```
tune2fs -e remount-ro /dev/sda1
```

This is the default behavior in many distros.

---

### **3. `panic`**

• Kernel immediately **panics**
• System HALTS
• Requires reboot
• Used for **very important, integrity-critical environments**:
• mission-critical servers
• banking
• databases with no tolerance for corruption

Set with:

```
tune2fs -e panic /dev/sda1
```

---

## **How to check the current error behavior**

```
tune2fs -l /dev/sda1 | grep 'Errors behavior'
```

You will see one of:
• continue
• remount-ro
• panic

---

## **Where this is used (real world)**

• **Desktop / laptops:**
`remount-ro` is safest.

• **Production Linux servers:**
`remount-ro`  → prevents data loss.

• **HPC clusters:**
• scratch partitions → `continue` (because data is disposable)
• root filesystem → `remount-ro`
• metadata servers (Lustre/GPFS) → may choose `panic`

• **Banking/transactions:**
`panic` → no chance of silent corruption.

---

## **How filesystem reacts on error**

### Example error: corrupted inode or directory entry

**Mode: continue**

```
EXT4-fs error: inode xyz has bad block
```

— system keeps running (risky)

**Mode: remount-ro**

```
EXT4-fs error: remounting filesystem read-only
```

— system safe, writable operations blocked

**Mode: panic**

```
Kernel panic - not syncing: EXT4-fs error
```

— system stops immediately

---

## **Changing error behavior (safe commands)**

```
umount /dev/sda1
tune2fs -e remount-ro /dev/sda1
mount /dev/sda1
```

OR if rootfs:

```
tune2fs -e remount-ro /dev/sda1
```

(reboot required)

---

## **Summary (very short)**

• `continue` → keep running even if corrupted (not safe)
• `remount-ro` → safest, recommended
• `panic` → best for critical systems

---

If you want, I can also give:
• all `tune2fs` options explained
• full ext4 troubleshooting + recovery guide
• step-by-step how kernel handles errors internally
Just tell me!

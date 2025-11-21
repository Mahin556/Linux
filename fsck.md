### **What `fsck` is**

• `fsck` = **File System Consistency Check**.
• It checks and repairs Linux filesystems after:
• crashes
• power failures
• unclean shutdown
• disk corruption
• metadata errors
• Works on: ext2 / ext3 / ext4 / xfs / btrfs / vfat / ntfs (via tools).

---

### **Important Safety Rule**

• NEVER run fsck on a **mounted** filesystem.
• For root filesystem → must run in:
• rescue mode
• live CD
• systemd emergency mode
• unmounted at boot

---

### **Check filesystem**

`fsck /dev/sda1`

---

### **Check and repair automatically**

`fsck -y /dev/sda1`
(y = answer “yes” to all prompts)

---

### **Interactively repair**

`fsck -r /dev/sda1`
(r = repair interactively)

---

### **Check all filesystems from /etc/fstab**

`fsck -A`
Common at boot time.

---

### **Force check even if filesystem is clean**

`fsck -f /dev/sda1`

Useful for suspicious disks.

---

### **Dry-run (no modifications)**

`fsck -N /dev/sda1`
(N = only show what would be done)

---

### **Auto-fix but only safe fixes**

`fsck -p /dev/sda1`
(p = preen mode)

Used in automatic startup scripts.

---

### **Skip filesystem check**

`fsck -t noext4 /dev/sdX`
(t = type)

---

### **Check a specific filesystem type**

`fsck -t ext4 /dev/sda1`

---

### **Show progress**

`fsck -C0 /dev/sda1`

---

---

## **fsck is ONLY a wrapper — actual work is done by filesystem-specific tools**

### **EXT2/3/4 uses `e2fsck`**

`e2fsck /dev/sda1`
`e2fsck -f -y /dev/sda1`

Most powerful FS checker.

---

### **XFS uses `xfs_repair` (NOT fsck)**

• If you run `fsck /dev/sda1` and FS is XFS → it simply tells you to use:
`xfs_repair /dev/sda1`

• Very common in RHEL-based HPC clusters.

---

### **BTRFS uses `btrfs check`**

• Check only:
`btrfs check /dev/sda1`

• Repair (dangerous):
`btrfs check --repair /dev/sda1`

---

### **FAT32 / VFAT (USB drives)**

`fsck.vfat /dev/sdb1`

---

### **NTFS uses ntfsfix**

`fsck.ntfs /dev/sdb1`
or
`ntfsfix /dev/sdb1`

---

---

## **Common Problems Fixed by fsck**

• orphaned inodes
• incorrect block counts
• corrupted directory entries
• journal inconsistencies
• bad superblock
• invalid group descriptors
• misaligned metadata
• unreferenced files moved to /lost+found

---

### **If superblock is corrupted (EXT4)**

• Check backup superblocks:
`dumpe2fs /dev/sda1 | grep superblock`

• Repair using backup:
`fsck -b 32768 /dev/sda1`
or
`e2fsck -b 98304 /dev/sda1`

---

## **fsck exit codes**

0 → No errors
1 → File system errors corrected
2 → System reboot required
4 → Errors left uncorrected
8 → Operational error
16 → Usage error
32 → Canceled by user
128 → Shared library error

Check exit code:

`echo $?`

---

## **fsck in /etc/fstab**

The last column (`pass`) controls fsck order:

• root filesystem = **1**
• other filesystems = **2**
• do not check = **0**

Example:

```
UUID=abcd-1234  /      ext4  defaults  0 1
UUID=efgh-5678  /data  ext4  defaults  0 2
UUID=1111-2222  /mnt   xfs   defaults  0 0
```

XFS always uses `0`.

---

## **fsck at boot time**

• System runs fsck automatically when:
• mount-count exceeds max
• time-based interval exceeded
• filesystem marked “dirty”
• journal replay required

Configurable using tune2fs:

• Disable mount-count check:
`tune2fs -c 0 /dev/sda1`

• Disable time check:
`tune2fs -i 0 /dev/sda1`




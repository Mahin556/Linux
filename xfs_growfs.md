* Used **only to increase (grow) the filesystem size** of an XFS filesystem
* **Cannot shrink XFS** (XFS does NOT support shrinking)
* Works online — **no need to unmount** the filesystem
* Grows the filesystem to fill either:

  * the entire block device
  * or a size you specify (up to available limit)

---

**🟦 What Must Be True Before Using `xfs_growfs`**

* The **underlying block device must be extended first**, such as:

  * Increasing virtual disk in a VM
  * Expanding an AWS EBS volume (`aws ec2 modify-volume`)
  * Increasing an LVM logical volume (`lvextend`)
  * Increasing a RAID volume (mdadm)
* XFS already mounted
* You know the **mount point** (e.g., `/mnt`, `/home`, `/data`, `/`)

---

**🟦 Most Common Syntax**

```
sudo xfs_growfs <mount-point>
```

Example:

```
sudo xfs_growfs /mnt
```

Grows filesystem to full available size on disk.

---

**🟦 Syntax for Growing to a Specific Size**

```
sudo xfs_growfs -D <blocks> <mount-point>
```

* `<blocks>` = size in **1 KB units** (XFS uses 1K blocks)
* Useful when LV or block device was extended partially

Example:

```
sudo xfs_growfs -D 50000000 /data
```

Grows `/data` XFS filesystem to 50 million blocks (approx 50 GB).

---

**🟦 Grow the Root Filesystem (`/`)**

```
sudo xfs_growfs /
```

Works online even for root FS.

---

**🟦 Display XFS filesystem details before and after growing**

```
sudo xfs_info <mount-point>
```

Example:

```
sudo xfs_info /data
```

Useful to verify size increases.

---

**🟦 Grow an XFS LV after extending the LV (LVM Example)**

1. Extend LV:

```
sudo lvextend -r -l +100%FREE /dev/vgdata/lvdata
```

(`-r` will run xfs_growfs automatically)

If you want to run manually:

```
sudo lvextend -l +50%FREE /dev/vgdata/lvdata
sudo xfs_growfs /data
```

---

**🟦 Grow XFS After Extending an EBS Volume (AWS Example)**

1. Modify EBS volume:

```
aws ec2 modify-volume --volume-id vol-123456 --size 100
```

2. Grow partition (if using GPT/parted)

```
sudo growpart /dev/nvme0n1 1
```

3. Grow filesystem:

```
sudo xfs_growfs /
```

---

**🟦 Grow XFS after RAID extension**

```
sudo xfs_growfs /mountpoint
```

RAID expansion is handled at array-level. XFS grows automatically to the new block device size.

---

**🟦 Check XFS Filesystem usage**

```
df -hT
```

---

**🟦 Check XFS health (optional)**

```
sudo xfs_repair -n <device>
```

`-n` = no write (safe to run)

---

**🟦 Error: “data size unchanged”**

* Means the underlying block device was NOT expanded
* Check disk size:

```
lsblk
```

* If using LVM:

```
lvdisplay
```

---

**🟦 Error: “mount-point is not an XFS filesystem”**

* Confirm FS type:

```
df -T
```

---

**🟦 Example: Complete End-to-End Steps (LVM + XFS)**

```
pvcreate /dev/sdc
vgextend vgdata /dev/sdc
lvextend -l +100%FREE /dev/vgdata/lvdata
xfs_growfs /data
```

---

**🟦 Example: Complete EBS + XFS Resize**

```
aws ec2 modify-volume --volume-id vol-aaa --size 200
sudo growpart /dev/nvme0n1 1
sudo xfs_growfs /
```

---

**🟦 All Available Options for `xfs_growfs`**

```
xfs_growfs [-dilnrVx] [-D size] [-L size] mount-point
```

**🟦 Explanation of All Options**

* `-d` → grow data section (default; always used)
* `-l` → grow log section (rare)
* `-i` → grow inode section (rare)
* `-n` → dry run (test only, no change)
* `-r` → recompute metadata (rare, mainly internal)
* `-x` → disable inheritance of inode alignment
* `-D size` → set data section size (in 1K blocks)
* `-L size` → set log section size
* `-V` → version info only

=
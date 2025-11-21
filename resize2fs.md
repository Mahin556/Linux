## **What `resize2fs` Actually Does**

* Used **only for ext2/ext3/ext4 filesystems**.
* It **changes filesystem size**, not partition size.
* Partition must already be resized (either expanded or shrunk) before `resize2fs`.
* Works **online (expand)** and **offline (shrink)**.
* Works on **LVM logical volumes**, **normal partitions**, and **loop devices**.

---

## **Most Important Rule**

* **To expand filesystem → you must expand the partition/LV first, then run `resize2fs`.**
* **To shrink filesystem → you must shrink filesystem first, then shrink partition/LV.**

---

## **Check a Filesystem Before Resize**

* `e2fsck -f /dev/sdXn`
* Forces complete check; required before shrinking.

---

## **Basic Usage**

* Expand to maximum possible:

  * `resize2fs /dev/sdXn`
* Resize to a specified size:

  * `resize2fs /dev/sdXn 20G`
  * `resize2fs /dev/sdXn 500M`

---

## **Units Supported**

* `K`, `M`, `G`, `T`, `P`
* `resize2fs /dev/sda1 15G`

---

## **Online Resize (grow while mounted)**

* Works ONLY for ext3/ext4 and ONLY for expansion.
* `resize2fs /dev/sdXn`
* Example growing ext4 root filesystem while mounted:

  * `sudo resize2fs /dev/mapper/rhel-root`

---

## **Offline Resize (shrink/expand while unmounted)**

* Required for shrink.
* Steps:

  * `umount /mnt`
  * `e2fsck -f /dev/sdXn`
  * `resize2fs /dev/sdXn 8G`

---

## **Show Minimum Required Size of Filesystem**

* `resize2fs -P /dev/sdXn`
* Output example:

  * `Estimated minimum size of the filesystem: 46728`

---

## **Resize2fs Options (ALL OPTIONS)**

* `resize2fs [options] device [new-size]`

**➤ -F (force)**

* Normally used for mounted filesystem.
* `resize2fs -F /dev/sda1`

**➤ -M (shrink to minimum size automatically)**

* Finds smallest possible size and resizes automatically.
* Dangerous if disk is almost full.
* `resize2fs -M /dev/sda1`

**➤ -p (show progress)**

* `resize2fs -p /dev/sda1 20G`

**➤ -P (print minimum size without resizing)**

* `resize2fs -P /dev/sda1`

**➤ No size argument = expand to maximum

* `resize2fs /dev/sda1`

---

## **Complete Real-World Examples**

---

## **1. Expand ext4 partition on physical disk**

* Grow partition:

  * `fdisk /dev/sda` → delete partition → recreate with larger size (non-destructive)
* Reboot or run:

  * `partprobe`
* Resize filesystem:

  * `resize2fs /dev/sda1`

---

## **2. Expand LVM logical volume**

* Extend LV by 10G:

  * `lvextend -L +10G /dev/vg1/root`
* Grow filesystem:

  * `resize2fs /dev/vg1/root`

---

## **3. Shrink LVM logical volume**

* Unmount:

  * `umount /dev/vg1/lv1`
* Check & fix:

  * `e2fsck -f /dev/vg1/lv1`
* Shrink FS:

  * `resize2fs /dev/vg1/lv1 15G`
* Shrink LV:

  * `lvreduce -L 15G /dev/vg1/lv1`

---

## **4. Shrink filesystem to minimum possible**

* `umount /dev/sda2`
* `e2fsck -f /dev/sda2`
* `resize2fs -M /dev/sda2`

---

## **5. Create and resize a loop-mounted ext4 filesystem**

* Create file:

  * `dd if=/dev/zero of=disk.img bs=1M count=2048`
* Format:

  * `mkfs.ext4 disk.img`
* Loop attach:

  * `losetup --find --show disk.img`
* Resize:

  * `resize2fs /dev/loop0`

---

## **6. Expand root filesystem on cloud VM**

* Cloud auto-expands disk; partition already bigger.
* `sudo growpart /dev/sda 1`
* `sudo resize2fs /dev/sda1`

---

## **7. Check filesystem before resizing**

* Highly recommended:

  * `e2fsck -f /dev/sda1`

---

## **Common Errors & Fixes**

**➤ Error: “Filesystem mounted read-only”**

* Remount:

  * `mount -o remount,rw /`

**➤ Error: “Device is busy”**

* Something still using it:

  * `lsof /dev/sda1`

**➤ Error: “New size smaller than minimum”**

* Check minimum:

  * `resize2fs -P /dev/sda1`

**➤ Error: “Bad magic number”**

* Not an ext filesystem:

  * use `xfs_growfs`, not `resize2fs`.

---

## **Resize2fs with Root Partition (Live System)**

Online possible only when expanding, example:

* `sudo lvextend -l +100%FREE /dev/mapper/rhel-root`
* `sudo resize2fs /dev/mapper/rhel-root`

Shrinking root requires booting into rescue mode.

---

## **Absolute Best-Practice Rules**

* Always run:

  * `e2fsck -f` before shrinking.
* Always unmount before shrinking.
* Never shrink without full backup.
* Use LVM always when possible — resizing becomes safe and trivial.
* Use `-M` only if you absolutely know disk usage.

---

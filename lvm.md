
**• LVM = Logical Volume Manager, a flexible storage management layer between physical disks and the file system, allowing resizing, snapshots, striping, mirroring, combining disks, migration, etc.**
**• Traditional partitioning (fdisk/parted) = fixed partitions. LVM = dynamic, resizable, abstracted storage.**
**• LVM main components:**
 • **PV (Physical Volume)** → actual storage devices (disk/partition/RAID/LUKS).
 • **VG (Volume Group)** → pool of storage created by combining multiple PVs.
 • **LV (Logical Volume)** → flexible partitions carved from the VG. You put filesystems on LVs.
 • **PE (Physical Extents)** → chunks of space inside a VG (default 4 MB). LVs are made of PEs.

---

**• Create LVM setup from scratch:**
 • Install LVM tools: `sudo yum install lvm2` (RHEL/CentOS), `sudo apt install lvm2` (Ubuntu).
 • Mark a disk or partition as PV:
  `sudo pvcreate /dev/sdb`
  `sudo pvcreate /dev/sdc1`
 • Check PVs: `sudo pvs` or detailed `sudo pvdisplay`
 • Create VG by combining one or more PVs:
  `sudo vgcreate vgdata /dev/sdb /dev/sdc1`
 • Check VG: `sudo vgs` or `sudo vgdisplay`
 • Create LV:
  `sudo lvcreate -L 20G -n lvbackup vgdata`
 • Or create % based:
  `sudo lvcreate -l 100%FREE -n lvdisk vgdata`
 • Check LVs: `sudo lvs` or detailed `sudo lvdisplay`

---

**• Format LV with filesystem:**
 • Example EXT4: `sudo mkfs.ext4 /dev/vgdata/lvbackup`
 • Example XFS: `sudo mkfs.xfs /dev/vgdata/lvbackup`
 • Example BTRFS: `sudo mkfs.btrfs /dev/vgdata/lvbackup`

---

**• Mount the LV:**
 • Make directory: `sudo mkdir /backup`
 • Mount: `sudo mount /dev/vgdata/lvbackup /backup`
 • Add permanent entry in `/etc/fstab`:
  `/dev/vgdata/lvbackup   /backup   ext4   defaults   0 0`

---

**• Extend LV (online expansion):**
 • Extend LV: `sudo lvextend -L +10G /dev/vgdata/lvbackup`
 • Or use 100% free space: `sudo lvextend -l +100%FREE /dev/vgdata/lvbackup`
 • Resize filesystem (for EXT4):
  `sudo resize2fs /dev/vgdata/lvbackup`
 • Resize filesystem (for XFS):
  `sudo xfs_growfs /backup` (must be mounted)

---

**• Reduce LV (only EXT4 + only offline + extremely dangerous):**
 • Unmount first: `sudo umount /backup`
 • Check filesystem: `sudo e2fsck -f /dev/vgdata/lvbackup`
 • Shrink filesystem: `sudo resize2fs /dev/vgdata/lvbackup 15G`
 • Shrink LV: `sudo lvreduce -L 15G /dev/vgdata/lvbackup`
 • Mount back: `sudo mount /backup`

---

**• Add more disks to VG to increase the pool:**
 • Add PV: `sudo pvcreate /dev/sdd`
 • Extend VG: `sudo vgextend vgdata /dev/sdd`
 • Now use `lvextend` to grow volumes.

---

**• Remove LV:**
 • Unmount: `sudo umount /backup`
 • Remove: `sudo lvremove /dev/vgdata/lvbackup`

---

**• Remove PV from VG (multi-disk VG only):**
 • Move extents away from disk:
  `sudo pvmove /dev/sdc1`
 • Remove disk from VG:
  `sudo vgreduce vgdata /dev/sdc1`
 • Optional wipe: `sudo pvremove /dev/sdc1`

---

**• LVM Snapshots (copy-on-write):**
 • Create snapshot:
  `sudo lvcreate -L 2G -s -n snap1 /dev/vgdata/lvbackup`
 • Mount snapshot:
  `sudo mount /dev/vgdata/snap1 /mnt/snap`
 • Delete snapshot:
  `sudo lvremove /dev/vgdata/snap1`
 • Snapshots grow depending on changes to the original LV.
 • If snapshot LV is full, snapshot becomes invalid.

---

**• LVM Thin Provisioning:**
 • Create thin pool:
  `sudo lvcreate -L 100G --type thin-pool -n thinpool vgdata`
 • Create thin LV:
  `sudo lvcreate -V 200G --thinpool thinpool -n thinlv1 vgdata`
 • Format: `sudo mkfs.ext4 /dev/vgdata/thinlv1`
 • Thin LVs allocate blocks only when used.

---

**• LVM striping (RAID-0 style performance):**
 • Requires 2+ PVs
 • Create striped LV:
  `sudo lvcreate -i2 -I64 -L 20G -n lvstripe vgdata`
 • -i2 = number of disks, -I64 = stripe size (64 KB).

---

**• LVM mirroring (RAID-1):**
 • 2+ PVs
 • Create mirror LV:
  `sudo lvcreate -m1 -L 10G -n lvmirror vgdata`

---

**• LVM RAID types (modern LVM2 RAID):**
 • RAID1 (mirror), RAID5, RAID6, RAID10
 • Example RAID5:
  `sudo lvcreate --type raid5 -L 100G -n lvraid vgdata`

---

**• View the entire LVM layout:**
 • `sudo pvscan`
 • `sudo vgscan`
 • `sudo lvscan`
 • Human readable tree:
  `sudo lvs -o +devices`
  `sudo vgdisplay -v`
  `sudo lvdisplay -m` (mapping of PEs → LVs)

---

**• LVM Metadata Backups:**
 • Auto backups stored in `/etc/lvm/backup/`
 • Restore VG metadata:
  `sudo vgcfgrestore vgdata`
 • Check metadata: `sudo vgcfgbackup`

---

**• Convert normal disk → LVM (destructive):**
 • `sudo pvcreate /dev/sdb`
 • `sudo vgcreate vg1 /dev/sdb`
 • `sudo lvcreate -n root -l 100%FREE vg1`

---

**• Convert partition → LVM without wiping (non-destructive only if unused):**
 • Create partition with type **8e (LVM)** in fdisk
 • Then run:
  `sudo pvcreate /dev/sdb2`

---

**• Booting from LVM:**
 • /boot must not be inside LVM unless using GRUB2 with full support
 • OS root (/) inside LVM works fine
 • Swap inside LV also works

---

**• LVM + Encryption (best practice):**
 • Encrypt disk:
  `sudo cryptsetup luksFormat /dev/sdb`
  `sudo cryptsetup open /dev/sdb secure1`
 • Use `/dev/mapper/secure1` as PV:
  `sudo pvcreate /dev/mapper/secure1`

---

**• LVM Commands Summary (complete list):**

```
# PV management
pvcreate /dev/sdX      # create PV
pvdisplay              # detailed PV info
pvs                    # table view
pvremove /dev/sdX      # remove PV
pvmove /dev/sdX        # migrate extents to other PVs

# VG management
vgcreate vg1 /dev/sdX
vgextend vg1 /dev/sdY
vgreduce vg1 /dev/sdX
vgdisplay
vgs
vgremove vg1

# LV management
lvcreate -L 10G -n lv1 vg1
lvextend -L +5G /dev/vg1/lv1
lvextend -l +100%FREE /dev/vg1/lv1
lvreduce -L 5G /dev/vg1/lv1
lvresize
lvremove /dev/vg1/lv1
lvs
lvdisplay
lvscan

# Snapshots
lvcreate -s -L 2G -n snap1 /dev/vg1/lv1
lvremove /dev/vg1/snap1

# Thin provisioning
lvcreate -L 100G --type thin-pool -n thinpool vg1
lvcreate -V 500G --thin -n thinlv1 vg1/thinpool

# RAID LVs
lvcreate --type raid1 -L 20G -n mirror1 vg1
lvcreate --type raid5 -L 100G -n raid5lv vg1
```


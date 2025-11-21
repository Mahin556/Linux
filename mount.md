### **What `mount` does**

• `mount` attaches a **filesystem** (ext4, xfs, nfs, etc.) to a **directory** in the Linux directory tree.
• Every mounted filesystem appears under `/`, never separate drives like Windows.
• You can mount:
• disks
• partitions
• LVM volumes
• loop files
• NFS shares
• ISO images
• SMB shares (with mount.cifs)
• tmpfs/ramfs
• special filesystems (proc, sysfs)

---

### **Basic syntax**

`mount <device> <dir>`
Example:
`mount /dev/sda1 /mnt`

---

### **Check existing mounts**

• `mount`
• `findmnt` (recommended)
• `lsblk -f`

`findmnt` shows tree structure, source, target, options.

---

### **Mount all filesystems from /etc/fstab**

`mount -a`

Used after editing fstab.

---

### **Mount any device automatically (let Linux detect FS)**

`mount /dev/sda1 /mnt`

Linux auto-detects filesystem type using `blkid`.

---

### **Force filesystem type**

`mount -t ext4 /dev/sda1 /mnt`
`mount -t xfs /dev/sdaa1 /mnt`
`mount -t iso9660 /dev/cdrom /mnt/iso`

Useful for unknown or broken devices.

---

### **Common mount options**

`mount -o <options> <device> <dir>`

• `ro` → read-only
• `rw` → read-write
• `noexec` → prevent running binaries
• `nosuid` → ignore setuid bit
• `nodev` → ignore device files
• `relatime` → default; efficient access time updates
• `noatime` → no access-time writes (performance)
• `discard` → TRIM SSD
• `async` / `sync`
• `defaults` → rw, suid, dev, exec, auto, nouser, async

Examples:

`mount -o ro /dev/sda1 /mnt`
`mount -o noatime /dev/sda1 /mnt`
`mount -o rw,discard /dev/nvme0n1p1 /mnt`

---

### **Unmount a filesystem**

`umount /mnt`
or
`umount /dev/sda1`

• If device is busy:
`umount -l /mnt` → lazy unmount
`umount -f /mnt` → force (network FS only)

• See what’s using the mount:
`lsof +D /mnt`
`fuser -vm /mnt`

---

### **Loop mount (mounting files as disks)**

Mount ISO file:

```
mount -o loop file.iso /mnt/iso
```

Mount raw disk image:

```
mount -o loop,offset=1048576 disk.img /mnt
```

Check partition offsets with:
`fdisk -lu disk.img`

---

### **Mounting swap (different command)**

Swap is not mounted with `mount`.
Use:
`swapon /dev/sda2`

---

### **Mount NFS share**

`mount -t nfs <server>:/path /mnt`

Example:
`mount -t nfs 10.0.0.5:/share /mnt`

Options:
`mount -o nfsvers=4,rsize=1048576,wsize=1048576 10.0.0.5:/data /mnt`

---

### **Mount SMB/CIFS share**

`mount -t cifs //server/share /mnt -o user=username,password=pass`

---

### **Mount tmpfs (RAM filesystem)**

`mount -t tmpfs -o size=4G tmpfs /mnt/ramdisk`

Used for ultra-fast storage.

---

### **Mount bind (same dir mounted at different location)**

`mount --bind /data /mnt/data2`

Useful for chroot, containers, HPC staging.

---

### **Mount read-only filesystem for safety**

`mount -o remount,ro /dev/sda1`

---

### **Remount filesystem without unmounting**

`mount -o remount,rw /dev/sda1`
`mount -o remount,noatime /dev/sda1`

---

### **Check filesystem usage**

`df -h`
`mount | grep /dev/sda1`
`findmnt /dev/sda1`

---

### **Using /etc/fstab (persistent mounts)**

fstab syntax:

```
<device>   <mountpoint>   <fstype>   <options>   <dump>   <pass>
```

Example ext4:

```
UUID=abcd-1234   /data   ext4   defaults,noatime   0 2
```

Example XFS:

```
/dev/sdb1   /scratch   xfs   defaults   0 0
```

Example NFS:

```
10.0.0.5:/share   /mnt/share   nfs   rw,nfsvers=4   0 0
```

Example swap:

```
UUID=abcd-1111   none   swap   sw   0 0
```

Mount all fstab entries:

`mount -a`

---

### **View mount options currently applied**

`mount | grep /mnt`
or
`findmnt -o TARGET,OPTIONS /mnt`

---

### **Mount encrypted LUKS device**

```
cryptsetup luksOpen /dev/sdb1 secure
mount /dev/mapper/secure /mnt
```

---

### **Mount LVM logical volume**

```
mount /dev/vgname/lvname /mnt
```

---

### **Common filesystem-specific options**

#### ext4

• `data=ordered` (default)
• `noatime`
• `journal_checksum`
Example:
`mount -t ext4 -o noatime,data=ordered /dev/sda1 /data`

#### xfs

• `inode64`
• `noquota`
• `allocsize=2M`
Example:
`mount -t xfs -o inode64 /dev/sda1 /data`

#### btrfs

• `compress=zstd`
• `autodefrag`
Example:
`mount -t btrfs -o compress=zstd,autodefrag /dev/sdb1 /btrfs`

---

Great — you want **each filesystem type + each mount option explained with examples**.

Because the list is extremely huge, I will give you the **first complete chunk now**, and then you tell me **continue** to receive the next chunk.

I will cover EVERYTHING with:

• meaning
• when to use
• example fstab entry
• example mount command

---

# ✅ **PART-1: Universal `/etc/fstab` Fields (Fully Explained with Examples)**

---

## **1. DEVICE FIELD (Column-1)**

### **A) /dev/sda1**

• Refers to physical partition
• Used when device name is fixed

Example:

```
/dev/sda1  /data  ext4  defaults  0 2
```

---

### **B) UUID=xxxx**

• BEST practice
• Stable device reference
• Does not change even if disk order changes.

Example:

```
UUID=1234-5678  /data  ext4  defaults  0 2
```

Check UUID:

```
blkid /dev/sda1
```

---

### **C) LABEL=MyDisk**

• Human-friendly
• Works if you set a label

Example:

```
LABEL=DBDISK  /db  ext4  defaults  0 2
```

Set label:

```
tune2fs -L DBDISK /dev/sda1
```

---

### **D) Network Export (NFS)**

```
10.0.0.5:/export/home  /home  nfs4  defaults  0 0
```

Mounts NFS export to `/home`.

---

### **E) CIFS / SMB**

```
 //server/share /mnt cifs username=user,password=pass 0 0
```

---

### **F) none (swap)**

```
UUID=xxx  none  swap  sw  0 0
```

---

### **G) tmpfs**

```
tmpfs  /tmp  tmpfs  size=4G  0 0
```

---

# ✅ **PART-2: UNIVERSAL MOUNT OPTIONS (Fully Explained with Examples)**

---

## **1. defaults**

Expands to:

```
rw,suid,dev,exec,auto,nouser,async
```

Example:

```
UUID=xx /data ext4 defaults 0 2
```

---

## **2. ro / rw**

• Mount read-only or read-write.

Example (read-only):

```
UUID=xx /mnt ext4 ro 0 2
```

Example (read-write):

```
mount -o rw /dev/sda1 /mnt
```

---

## **3. noatime**

• Do NOT update access-time → faster for SSD/HDD.

Example:

```
UUID=xx /data ext4 noatime 0 2
```

---

## **4. relatime (default)**

• update atime only once per day = good performance.

Example:

```
UUID=xx / ext4 relatime 0 1
```

---

## **5. nodiratime**

• Skip atime updates for directories only.

```
UUID=xx /data ext4 nodiratime 0 2
```

---

## **6. exec / noexec**

• exec = allow running programs
• noexec = do NOT allow execution (safer)

Example (security on /home):

```
UUID=xx /home ext4 noexec 0 2
```

---

## **7. suid / nosuid**

• nosuid = disable setuid/setgid bits → protects from privilege escalation.

Example:

```
UUID=xx /mnt ext4 nosuid 0 2
```

---

## **8. dev / nodev**

• nodev = block creation of device files.

Good for user partitions:

```
UUID=xx /home ext4 nodev 0 2
```

---

## **9. auto / noauto**

• auto = mount automatically at boot
• noauto = only mount manually

Example:

```
UUID=xx /backup ext4 noauto 0 0
```

---

## **10. acl / noacl**

• Enable POSIX ACL permissions.

Example:

```
UUID=xx /data ext4 acl 0 2
```

---

## **11. discard**

• Enable TRIM on SSD.

Example:

```
UUID=xx /ssd ext4 discard 0 2
```

---

## **12. errors=continue / errors=remount-ro / errors=panic**

### **continue**

Keep running even if corruption detected (dangerous).

### **remount-ro**

Remount read-only (safe, default).

```
UUID=xx /data ext4 errors=remount-ro 0 2
```

### **panic**

Kernel panic on FS error.

```
UUID=xx /critical ext4 errors=panic 0 1
```

---

Great — continuing with the **FULL EXPLANATION + EXAMPLES** of all filesystem-specific mount options.

This is **PART-2 (EXT4, XFS, BTRFS, F2FS)**.

Reply **continue** for next filesystems.

---

# ✅ **PART-2 — EXT2/EXT3/EXT4 MOUNT OPTIONS (EXPLAINED + EXAMPLES)**

---

## **1. data=ordered (DEFAULT)**

• journal only metadata
• data blocks written **before** metadata
• prevents stale data exposure
• balanced speed + safety
• best for general Linux

fstab:

```
UUID=xx / ext4 defaults,data=ordered 0 1
```

---

## **2. data=writeback**

• metadata journaled
• data NOT ordered
• fastest
• dangerous: file corruption possible
• used in HPC scratch

fstab:

```
UUID=xx /scratch ext4 defaults,data=writeback,noatime 0 0
```

---

## **3. data=journal**

• metadata + file data journaled
• safest
• slowest
• used in banking, DB servers

fstab:

```
UUID=xx /critical ext4 data=journal 0 1
```

---

## **4. journal_checksum**

• checksums journal for corruption
• improves safety

```
UUID=xx / ext4 journal_checksum 0 1
```

---

## **5. barrier=1 / barrier=0**

• barrier=1 = safe (default)
• barrier=0 = faster but risk of corruption (unsafe)
• disable barriers only on RAID cards with battery-backed cache

Example (RAID BBU):

```
UUID=xx /data ext4 barrier=0 0 2
```

---

## **6. commit=5**

• journal flush every X seconds (default 5 sec)
• lower = more safe, slower
• higher = faster, more risk

Example for HDD:

```
UUID=xx /data ext4 commit=20 0 2
```

---

## **7. nodelalloc**

• disable delayed allocation
• slower but prevents fragmentation
• used when debugging ext4 corruption

```
UUID=xx /debug ext4 nodelalloc 0 2
```

---

## **8. discard**

• enable TRIM on SSD
• continuous TRIM
• slows down heavy write workloads
• alternative: weekly fstrim.timer

Example:

```
UUID=xx /ssd ext4 discard 0 2
```

---

## **9. nobh**

• bypass buffer heads
• obsolete, rarely needed
• sometimes used for big writes

---

## **10. inode_readahead_blks=NUM**

• prefetch inode blocks
• used for large inode tables (mail servers)

Example:

```
inode_readahead_blks=128
```

---

## **11. quota / usrquota / grpquota / prjquota**

### User quota:

```
UUID=xx /home ext4 usrquota 0 2
```

### Group quota:

```
UUID=xx /data ext4 grpquota 0 2
```

### Project quota (HPC-friendly):

```
UUID=xx /scratch ext4 prjquota 0 2
```

---

## **12. errors=continue / remount-ro / panic**

Explained earlier.

Example (safe):

```
UUID=xx / ext4 errors=remount-ro 0 1
```

---

# ✔ EXT4 Examples (Complete)

### **Standard setup**

```
UUID=1111 / ext4 defaults 0 1
```

### **Performance optimized (HPC)**

```
UUID=2222 /scratch ext4 defaults,noatime,data=writeback,discard 0 0
```

### **High safety for database**

```
UUID=3333 /db ext4 data=journal,barrier=1,commit=1 0 1
```

---

# ✅ **PART-3 — XFS MOUNT OPTIONS**

---

## **1. inode64**

• enable 64-bit inode numbers
• REQUIRED for large filesystems >1TB
• recommended always

Example:

```
/dev/sdb1 /data xfs defaults,inode64 0 0
```

---

## **2. nouuid**

• mount filesystem even if UUID matches another mounted FS
• used for block-level clones

Example (mount clone):

```
mount -o nouuid /dev/sdc1 /mnt
```

---

## **3. logbufs=8**

• number of log buffers
• improves write speed
• good for metadata-heavy workloads

fstab:

```
/dev/nvme0n1 /xfs xfs logbufs=8,inode64 0 0
```

---

## **4. logbsize=256k**

• size of each journal buffer
• performance tuning on HPC

Example:

```
logbsize=256k
```

---

## **5. allocsize=4M**

• preallocation size for new extents
• improves performance for large file writes

Example:

```
/dev/sdc1 /scratch xfs allocsize=4M 0 0
```

---

## **6. dmasync / wsync**

• ensure synchronous data writes
• used for databases
• slower

Example:

```
wsync
```

---

## **7. discard**

• enable TRIM

Example:

```
discard
```

---

## **8. uquota / gquota / pquota**

• user, group, project quota

Example:

```
/dev/sdb1 /project xfs prjquota 0 0
```

---

# ✔ XFS examples

### **General-purpose**

```
UUID=xx /data xfs defaults,inode64 0 0
```

### **HPC scratch**

```
UUID=xx /scratch xfs defaults,noatime,inode64,logbufs=8,allocsize=4M 0 0
```

### **Database**

```
UUID=xx /db xfs inode64,wsync 0 0
```

---

# ✅ **PART-4 — BTRFS MOUNT OPTIONS**

---

## **1. compress=zstd (recommended)**

• transparent compression
• very good performance
• saves space

Example:

```
compress=zstd
```

---

## **2. compress=lzo**

• faster but lower compression than zstd.

---

## **3. compress-force=zstd**

• forces compression even for incompressible files

---

## **4. autodefrag**

• defrag small random writes
• good for databases running on BTRFS

Example:

```
autodefrag
```

---

## **5. ssd / nossd**

• optimize for SSD
• automatic detection usually works

---

## **6. discard=async**

• async TRIM (better than discard)
• recommended for SSD

fstab:

```
UUID=xx / btrfs compress=zstd,discard=async 0 0
```

---

## **7. subvol= / subvolid=**

• mount BTRFS subvolumes
• used for @ and @home layouts

Example:

```
UUID=xx / btrfs subvol=@,compress=zstd 0 0
```

---

## **8. nodatacow**

• disable COW
• improves DB performance
• no data checksums

Example (DB folder):

```
chattr +C /var/lib/mysql
```

Not recommended for general use.

---

# ✔ BTRFS Examples:

### **Desktop**

```
UUID=xx / btrfs defaults,compress=zstd,autodefrag,subvol=@ 0 0
```

### **HPC**

```
UUID=xx /scratch btrfs nodatacow,compress=lzo 0 0
```

---

# ✅ **PART-5 — F2FS MOUNT OPTIONS (Flash-friendly FS)**

---

## **1. discard**

• continuous TRIM
• recommended for flash

```
discard
```

---

## **2. compress_algorithm=lz4**

• compression support

Example:

```
compress_algorithm=lz4
```

---

## **3. inline_xattr**

• store xattr in inode
• saves space

---

## **4. inline_data**

• store small files inside inode
• faster

---

## **5. background_gc=on/off**

• background garbage collection
• improves performance

Example:

```
background_gc=on
```

---

## **6. noheap**

• reduces heap-space usage
• good for small embedded devices

---

# ✔ F2FS Example:

```
UUID=xx /flash f2fs defaults,inline_data,inline_xattr,discard,compress_algorithm=lz4 0 0
```

---

Continuing with **PART-3**, explaining **ALL remaining filesystem types + ALL mount options with clear examples**.

This part includes:
✔ VFAT / EXFAT
✔ NTFS
✔ NFS / NFS4 (FULL LIST + HPC tuning)
✔ CIFS / SMB
✔ TMPFS
✔ OverlayFS
✔ SquashFS
✔ FUSE (sshfs, rclone, encfs)
✔ HPC FS (Lustre, BeeGFS, GPFS)

Reply **continue** for ZFS, CephFS, GlusterFS, RBD, more advanced tuning.

---

# ✅ **PART-6 — VFAT / FAT32 (USB, SD Card)**

VFAT does NOT support Linux permissions, so mount options control them.

---

## VFAT Mount Options (Explained)

### **1. uid= / gid=**

• Owner of all files

```
uid=1000,gid=1000
```

### **2. umask=**

• Apply permission mask

```
umask=022     # rwxr-xr-x
```

### **3. dmask= / fmask=**

• directory mask
• file mask

Example:

```
dmask=000,fmask=111
```

### **4. codepage=437**

• DOS encoding
Rarely needed.

### **5. iocharset=utf8**

• Enable UTF-8 filenames
Most important for Linux.

### **6. flush**

• Write-through mode
• Safer USB removal

---

## VFAT Example fstab

```
/dev/sdb1  /media/usb  vfat  uid=1000,gid=1000,iocharset=utf8,umask=022,flush  0  0
```

---

# ✅ **PART-7 — EXFAT (USB disks on modern devices)**

---

## EXFAT Mount Options

• `uid=`
• `gid=`
• `umask=`
• `dmask=`
• `fmask=`
• `iocharset=utf8`

---

## EXFAT Example:

```
/dev/sdb1 /usb exfat uid=1000,gid=1000,umask=022 0 0
```

---

# ✅ **PART-8 — NTFS (via ntfs-3g)**

---

## NTFS Mount Options

### **1. permissions**

Enable POSIX permissions translation

```
permissions
```

### **2. windows_names**

Prevent Windows-illegal names.

### **3. locale=UTF-8**

Ensure filenames with Unicode work.

### **4. remove_hiberfile**

Force mount hybrid-sleep Windows volumes.

### **5. uid= / gid=**

Force ownership.

---

## NTFS Example (Recommended)

```
/dev/sdb2  /win  ntfs  defaults,windows_names,uid=1000,gid=1000  0  0
```

---

# ✅ **PART-9 — NFS / NFS4 Mount Options (FULL PRO + HPC-Tuned)**

NFS is the MOST complex FS.
Below are **ALL important options**.

---

## ⭐ General Options (Work on both NFS3, NFS4)

### **1. nfsvers=3 | 4 | 4.1 | 4.2**

Example:

```
nfsvers=4.2
```

### **2. proto=tcp | udp**

TCP recommended.

```
proto=tcp
```

### **3. rsize= / wsize=**

Block sizes for read/write
HPC = use 1MB:

```
rsize=1048576,wsize=1048576
```

### **4. hard / soft**

• hard → retries forever (safe)
• soft → returns error, risk corruption

HPC ALWAYS uses **hard**.

---

### **5. timeo=600**

Timeout in tenths of seconds.

### **6. retrans=**

Retry count.

---

### **7. sec=krb5 / krb5i / krb5p / sys**

Security mode.

---

### **8. noacl**

Disable ACL checks → faster.

---

### **9. fsc**

Enable FS-cache
Huge performance improvement for HPC.

---

### **10. noatime**

Recommended.

---

## ⭐ NFS4-specific

### **local_lock=none**

Faster in HPC.

### **minorversion=1 or 2**

Use v4.1 or v4.2 features.

---

## ⭐ HPC-TUNED NFS Example

```
10.0.0.5:/home  /home  nfs4  rw,_netdev,nfsvers=4.2,proto=tcp,rsize=1M,wsize=1M,hard,noatime,fsc,local_lock=none  0  0
```

---

# ✅ **PART-10 — CIFS / SMB Options**

---

## CIFS Options

### **1. username= / password=**

```
username=myuser,password=mypass
```

### **2. domain=**

Active Directory domain.

### **3. vers=1.0/2.0/2.1/3.0/3.1.1**

VERY IMPORTANT.
Most servers use:

```
vers=3.0
```

### **4. uid= / gid=**

Map ownership.

### **5. file_mode= / dir_mode=**

Set permissions (`chmod` does NOT work on CIFS)

### **6. iocharset=utf8**

Unicode filenames.

### **7. sec=ntlmssp | ntlm | kerberos**

Set authentication style.

### **8. mfsymlinks**

Proper symlink handling.

---

## CIFS Example:

```
 //server/share  /mnt  cifs  vers=3.0,username=admin,password=123,iocharset=utf8,uid=1000,gid=1000  0  0
```

---

# ✅ **PART-11 — TMPFS Options**

---

## TMPFS Options

### **1. size=4G**

Limit RAM usage.

### **2. mode=1777**

Directory permissions.

### **3. uid= / gid=**

Ownership.

### **4. noexec/nosuid/nodev**

Security.

---

## TMPFS Example:

```
tmpfs  /tmp  tmpfs  size=4G,mode=1777  0  0
```

---

# ✅ **PART-12 — OverlayFS (Docker, Podman, Containers)**

OverlayFS merges multiple directories.

---

## OverlayFS Options

### **lowerdir=**

read-only layer

### **upperdir=**

writeable layer

### **workdir=**

must exist on same FS as upperdir

### **redirect_dir=on**

Improves rename speed

### **index=on**

Fixes inode re-use issues

---

## OverlayFS Example:

```
overlay /mnt overlay lowerdir=/ro,upperdir=/rw,workdir=/work,index=on 0 0
```

---

# ✅ **PART-13 — SquashFS (ISO-like compressed FS)**

---

## SquashFS Options

• `ro` only
• `loop`
• `offset=`
• `xino=off`

---

## Example:

```
/root.sqsh /mnt squashfs ro,loop 0 0
```

---

# ✅ **PART-14 — FUSE Filesystems**

---

## **A) SSHFS**

Options:
• `allow_other`
• `default_permissions`
• `reconnect`
• `ServerAliveInterval=15`
• `IdentityFile=/path/key`

Example:

```
sshfs#user@10.0.0.10:/data  /mnt  fuse.sshfs  allow_other,reconnect,IdentityFile=/root/id_rsa  0  0
```

---

## **B) Rclone Mount**

(Cloud FS: Google Drive, S3)

Typical:

```
allow_other
vfs-cache-mode=full
```

---

## **C) EncFS**

Encrypted FUSE FS.

Options:
• `allow_other`
• `default_permissions`

---

# ✅ **PART-15 — HPC Filesystems (Lustre, BeeGFS, GPFS)**

---

## **A) LUSTRE**

Options:
• `flock`
• `localflock`
• `user_xattr`
• `llite.max_cached_mb=`
• `nomap`
• `osd=`

Example:

```
10.0.0.1@tcp:/lustrefs  /lustre  lustre  defaults,flock  0  0
```

---

## **B) BeeGFS**

Options:
• `cfgFile=/etc/beegfs/beegfs-client.conf`
• `transport=tcp`
• `connInterfacesFile=…`
• `_netdev` (required)

Example:

```
beegfs_nodev  /beegfs  beegfs  _netdev,defaults  0  0
```

---

## **C) GPFS (IBM Spectrum Scale)**

Rarely in fstab, but supports:

• `rw`
• `quota`
• `snapdir=/snapshots`
• `fileset=projects`

Example:

```
/dev/gpfs0 /gpfs gpfs rw,quota 0 0
```

---

Perfect — continuing with **PART-4**, covering advanced + enterprise-grade filesystems:

✔ **ZFS**
✔ **CephFS**
✔ **Ceph RBD**
✔ **GlusterFS**
✔ **LVM mounts**
✔ **NVMe/SAN tuning options**
✔ **Full `/etc/fstab` templates for Servers, HPC, Laptops**

Reply **continue** for:
• advanced mount security
• bind mounts
• loop mounts
• systemd mount units
• automounting
• enterprise fstab validation

---

# ✅ **PART-16 — ZFS Mount Options (OpenZFS / ZFS on Linux)**

Unlike other filesystems, **ZFS does NOT use `/etc/fstab`**.
ZFS mounts datasets automatically based on dataset properties.

You manage ZFS mounts using:

`zfs set`
`zfs get`

---

## ⭐ Important ZFS Dataset Mount Options

### **mountpoint=<dir>**

Sets where dataset is mounted.

Example:

```
zfs set mountpoint=/data pool1/dataset1
```

Unmount:

```
zfs unmount pool1/dataset1
```

---

### **atime=on/off**

Control access-time.

Recommended:

```
zfs set atime=off pool1/data
```

---

### **compression=on/off | zstd | lz4**

ZFS’s strongest feature.

Example:

```
zfs set compression=zstd pool1/home
```

---

### **readonly=on/off**

```
zfs set readonly=on pool1/backup
```

---

### **quota=<size>**

Dataset size limit.

```
zfs set quota=500G pool1/projects
```

---

### **refquota=**

Only count data of this dataset (ignores children).

---

### **reservation=**

Reserve space for dataset.

---

### **exec=on/off**

Allow running binaries.

```
zfs set exec=off pool1/shared
```

---

### **setuid=on/off**

Enable/disable SUID bits.

---

### **casesensitivity=sensitive / insensitive**

Important for macOS clients.

---

### **dedup=on/off**

Deduplication – VERY RAM-heavy.

---

## ⭐ Full ZFS Example (Equivalent to fstab)

```
zfs create -o mountpoint=/data -o compression=zstd pool1/data
```

---

# ✅ **PART-17 — CephFS (mount.ceph)**

CephFS is a distributed POSIX filesystem built on Ceph.

You mount CephFS using the kernel client:

```
mount -t ceph <monitors>:/ <mountpoint> -o <options>
```

---

## ⭐ Required Options

### **mon_addr=ip1:port,ip2:port**

Ceph monitor nodes.

Example:

```
10.0.0.5:6789,10.0.0.6:6789
```

---

### **name=client.name**

Ceph authentication user.

```
name=admin
```

---

### **secret=**

Key inserted directly (not recommended).

```
secret=BASE64_KEY
```

---

### **secretfile=/etc/ceph/admin.secret**

Better!

```
secretfile=/etc/ceph/admin.secret
```

---

## ⭐ Performance Options

• `rsize=131072`
• `wsize=131072`
• `dirstat`
• `inode64`
• `noatime`
• `async`

---

## ⭐ CephFS fstab Example

```
10.0.0.5:6789:/   /cephfs   ceph  name=admin,secretfile=/etc/ceph/admin.secret,noatime  0  0
```

---

# ✅ **PART-18 — Ceph RBD (RADOS Block Device)**

RBD = block device mapped via network.

---

## ⭐ Map RBD Block Device

```
rbd map mypool/mydisk
```

This creates:

```
/dev/rbd0
```

Format:

```
mkfs.ext4 /dev/rbd0
```

Mount with fstab:

```
/dev/rbd0  /rbd  ext4  defaults,noatime  0  0
```

---

# ✅ **PART-19 — GlusterFS**

Gluster is volume-based distributed FS.

---

## ⭐ GlusterFS Mount Command

```
mount -t glusterfs server:/volume /mnt
```

---

## ⭐ GlusterFS Options

• `log-file=/var/log/gluster.log`
• `backup-volfile-servers=server2,server3`
• `direct-io-mode=enable`
• `read-freq=3`
• `noatime`
• `acl`

---

## ⭐ GlusterFS fstab Example

```
server1:/data   /gluster   glusterfs   defaults,_netdev,backup-volfile-servers=server2,acl  0  0
```

---

# ✅ **PART-20 — LVM Volume Mounting**

LVM logical volumes appear as:

```
/dev/mapper/vgname-lvname
```

---

## Example:

```
mkfs.xfs /dev/vgdata/projectlv

/dev/mapper/vgdata-projectlv /project xfs defaults,noatime 0 0
```

---

# ✅ **PART-21 — SAN / NVMe Advanced Mount-Tuning Options**

These apply to EXT4 / XFS / BTRFS primarily.

---

## ⭐ noatime

Disable access-time updates.

---

## ⭐ nodiscard / discard

Enable or disable TRIM.

---

## ⭐ nobarrier / barrier=0 (EXT4)

Disable write barriers (unsafe unless RAID BBU).

---

## ⭐ commit=30 (EXT4)

Flush journal every 30 sec.

---

## ⭐ XFS tuning for SSD / NVMe

```
logbufs=8,logbsize=256k,inode64
```

---

## ⭐ EXT4 tuning for large NVMe

```
noatime,nobarrier,data=writeback,commit=30
```

---

## ⭐ btrfs tuning for NVMe

```
compress=zstd,ssd,discard=async,subvol=@
```

---

# ✅ **PART-22 — FULL `/etc/fstab` TEMPLATES**

Now providing ready-to-use configs.

---

# ⭐ **A) Server Template (Safe + Fast)**

```
UUID=ROOT-UUID     /          ext4   defaults,noatime,errors=remount-ro   0  1
UUID=BOOT-UUID     /boot      ext4   defaults,noatime                     0  2
UUID=DATA-UUID     /data      xfs    defaults,inode64,noatime,logbufs=8   0  2
tmpfs              /tmp       tmpfs  size=4G,mode=1777                    0  0
```

---

# ⭐ **B) HPC Compute Node Template (Ultra-Speed)**

```
UUID=ROOT / ext4 defaults,noatime,discard=async,data=writeback 0 1
/dev/nvme0n1p1 /scratch xfs defaults,noatime,inode64,logbufs=8,allocsize=4M 0 0
10.0.0.5:/home /home nfs4 rw,_netdev,nfsvers=4.2,rsize=1M,wsize=1M,noatime,hard 0 0
```

---

# ⭐ **C) Laptop Template (SSD Optimized)**

```
UUID=root / ext4 defaults,noatime,discard 0 1
UUID=home /home ext4 defaults,noatime,discard 0 2
tmpfs /tmp tmpfs size=2G,mode=1777 0 0
```

---

# ⭐ **D) CephFS Template**

```
10.0.0.5:6789:/ /ceph ceph name=admin,secretfile=/etc/ceph/admin.secret,_netdev 0 0
```

---

# ⭐ **E) CIFS Share Template**

```
 //server/share /mnt/files cifs vers=3.0,username=user,password=pass,uid=1000,gid=1000 0 0
```

---

# ⭐ **F) OverlayFS Template**

```
overlay /mnt overlay lowerdir=/lower,upperdir=/upper,workdir=/work 0 0
```

---

Continuing with **PART-5**, covering:

✔ **Advanced mount security options**
✔ **Bind mounts**
✔ **Loop mounts (ISO, RAW images)**
✔ **systemd `.mount` units**
✔ **systemd `.automount` units**
✔ **Enterprise-grade fstab validation**
✔ **Full mount troubleshooting guide**
✔ **Final cheat sheet**

This section is extremely useful for **HPC**, **DevOps**, **sysadmins**, and **security hardening**.

---

# ✅ **PART-23 — Advanced Mount Security Options**

These options improve OS security by restricting actions inside mounted directories.

---

## ⭐ 1. noexec

• Prevent execution of binaries
• Common on `/tmp`, `/home`, `/var/tmp`, external drives

Example:

```
UUID=xx /home ext4 noexec 0 2
```

---

## ⭐ 2. nosuid

• Disable SUID/SGID bits
• Prevent privilege escalation

Example:

```
/dev/sda1 /mnt ext4 nosuid 0 2
```

---

## ⭐ 3. nodev

• Prevent creation of device files
• Important for `/home`, `/tmp`, `/run/user`

Example:

```
/dev/sda1 /mnt ext4 nodev 0 2
```

---

## ⭐ 4. hidepid=2

• Hides processes from other users
• Applies to `/proc`

Example:

```
proc /proc proc defaults,hidepid=2 0 0
```

---

## ⭐ 5. nofail

• Do not fail boot if FS missing
• Useful for external disks & network mounts

Example:

```
UUID=xx /backup ext4 defaults,nofail 0 2
```

---

## ⭐ 6. _netdev

• Delay mount until network is online
• Required for NFS, CIFS, GlusterFS, CephFS

Example:

```
server:/data /mnt nfs4 defaults,_netdev 0 0
```

---

## ⭐ 7. nosymfollow

• Disable symlink following (anti-symlink attacks)

Example:

```
UUID=xx /srv ext4 nosymfollow 0 2
```

---

## ⭐ 8. lazytime

• Update atime only when file is flushed or unmounted
• Good performance + preserves atime

Example:

```
UUID=xx / ext4 lazytime 0 1
```

---

# ✔ Recommended Secure Mount Setup (Industry Standard)

```
/tmp       tmpfs   rw,nosuid,nodev,noexec,relatime   0  0
/home      ext4    rw,nosuid,nodev,noexec,relatime   0  2
/var/tmp   ext4    rw,nosuid,nodev,noexec,relatime   0  2
```

---

# ✅ **PART-24 — Bind Mounts (`mount --bind`)**

Bind mounts “map” one directory to another.

---

## ⭐ Basic bind mount

```
mount --bind /data/project1 /mnt/project
```

---

## ⭐ Read-only bind mount

```
mount --bind /data /mnt/data
mount -o remount,bind,ro /mnt/data
```

---

## ⭐ fstab entry for bind mount

```
/data /mnt/data none bind 0 0
```

Read-only bind:

```
/data /mnt/data none bind,ro 0 0
```

---

# ⭐ Why bind mounts are used?

• containers (LXC/Podman)
• chroot environments
• HPC staging areas
• mount single directory from a large filesystem
• service jail environments

---

# ✅ **PART-25 — Loop Mounts (ISO, RAW disk images)**

---

## ⭐ Mount ISO image

```
mount -o loop file.iso /mnt/iso
```

fstab:

```
/home/user/file.iso /mnt/iso iso9660 loop,ro 0 0
```

---

## ⭐ Mount raw disk image (qcow/raw)

Find partition offset:

```
fdisk -lu disk.img
```

Mount partition:

```
mount -o loop,offset=1048576 disk.img /mnt
```

---

## ⭐ Mount filesystem inside a DD clone

```
dd if=/dev/sda of=disk.img
mount -o loop,ro disk.img /mnt
```

---

# WHY loop mounts are used?

• Forensics
• Container image analysis
• VM image editing
• Backup restore
• Boot ISO mount

---

# ✅ **PART-26 — systemd `.mount` Units**

Systemd replaces fstab for dynamic mounting.

---

## ⭐ Example unit file: `/etc/systemd/system/data.mount`

Mountpoint `/data` corresponds to unit name `data.mount`.

```
[Unit]
Description=Mount Data Partition

[Mount]
What=/dev/sdb1
Where=/data
Type=xfs
Options=defaults,noatime,inode64

[Install]
WantedBy=multi-user.target
```

Enable:

```
systemctl enable data.mount
systemctl start data.mount
```

---

## ⭐ Mount any path:

Mount `/var/log/archive`:

Unit file:

```
var-log-archive.mount
```

Mapping rule:
`/` → `-` and suffix `.mount`.

---

# Benefits of systemd mount units

• Mount ordering
• Dependencies
• Auto-recovery
• Network-aware mounts

Better than fstab for production servers.

---

# ✅ **PART-27 — systemd `.automount` Units**

Auto-mounting = mount only when accessed.

---

## ⭐ Example: `/etc/systemd/system/data.automount`

```
[Unit]
Description=Automount Data Partition

[Automount]
Where=/data

[Install]
WantedBy=multi-user.target
```

Mount config (must also create data.mount):

```
[Mount]
What=/dev/sdb1
Where=/data
Type=xfs
Options=defaults,noatime
```

Enable:

```
systemctl enable data.automount
```

---

# Benefits:

• Faster boot
• Mount on first access
• Good for:
• NFS
• CIFS
• Backup drives
• Low-usage disks

---

# ✅ **PART-28 — Enterprise-grade `/etc/fstab` validation**

---

## ⭐ Test fstab BEFORE reboot (avoid boot failure)

```
mount -a -v
```

If any mount fails → fix before reboot.

---

## ⭐ Check syntax with systemd

```
systemd-analyze verify /etc/fstab
```

---

## ⭐ Highlight wrong UUID

```
blkid
lsblk -f
```

Compare UUID output with fstab.

---

## ⭐ Simulate every mount in a safe way

```
findmnt --verify
```

---

# 📌 Boot-Safe Tip

NEVER put **network FS (NFS, CIFS)** without `_netdev` or `nofail`.

---

# ✅ **PART-29 — Full Mount Troubleshooting Guide**

---

# ⭐ 1. Device is busy / cannot umount

Find processes:

```
fuser -vm /mnt
lsof +D /mnt
```

Lazy unmount:

```
umount -l /mnt
```

---

# ⭐ 2. Wrong FS type

```
blkid /dev/sda1
file -s /dev/sda1
```

---

# ⭐ 3. Permission denied for NFS

Check export:

```
showmount -e server
```

---

# ⭐ 4. CIFS mount fails (SMB protocol error)

Add:

```
vers=3.0
sec=ntlmssp
```

---

# ⭐ 5. TRIM not working

```
fstrim -v /
systemctl status fstrim.timer
```

---

# ⭐ 6. EXT4 journal errors

```
fsck.ext4 -f /dev/sda1
```

---

# ⭐ 7. After editing fstab, system does not boot

Use emergency shell:
• Press *e* in GRUB
• Append this:

```
systemd.unit=rescue.target
```

Fix fstab.

---

# ✅ **PART-30 — Final Cheat Sheet**

---

## ⭐ Common fstab line format

```
<device>   <mountpoint>   <fstype>   <options>   <dump>   <pass>
```

---

## ⭐ Best options (all-in-one)

**For HDD:**

```
defaults,noatime
```

**For SSD:**

```
defaults,noatime,discard=async
```

**For NFS HPC:**

```
rw,nfsvers=4.2,rsize=1M,wsize=1M,hard,noatime,_netdev,fsc
```

**For CIFS:**

```
vers=3.0,iocharset=utf8,uid=1000,gid=1000
```

**For security:**

```
nosuid,nodev,noexec
```

---


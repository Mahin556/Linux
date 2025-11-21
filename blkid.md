• `blkid` = **block device ID tool** used to find filesystem type, UUID, LABEL, PARTUUID, PARTLABEL, encryption signatures, and more.

• Used heavily for:
• fstab entries
• identifying disks
• GPT/LVM/LUKS detection
• automation scripts
• HPC cluster provisioning

---

• Basic command:
`blkid`
Shows all block devices with detectable signatures.

---

• For a specific device (disk or partition):
`blkid /dev/sda1`
Prints filesystem info of that partition only.

• Works on: disk, partition, LVM LV, RAID, loop device, encrypted disk.

---

• Show **filesystem type only**:
`blkid -o value -s TYPE /dev/sda1`

• Show **UUID only**:
`blkid -o value -s UUID /dev/sda1`

• Show **LABEL only**:
`blkid -o value -s LABEL /dev/sda1`

---

• Print **all fields** for each device:
`blkid -o full`

• List all possible tags supported by blkid backend:
`blkid -k`
(Shows TAGs like UUID, LABEL, PARTUUID, PARTLABEL, TYPE, USAGE, etc.)

---

• Output formats:
`-o full` → readable full info
`-o device` → device only
`-o value` → only value of a tag
`-o export` → KEY=value format (best for scripts)

Example:
`blkid -o export /dev/sda1`
Outputs:

```
DEVNAME=/dev/sda1
UUID=abcd-1234
TYPE=ext4
```

---

• To detect **LUKS encrypted disks**:
`blkid | grep crypto_LUKS`

---

• To show partition UUID + partition LABEL for GPT partitions:
`blkid -o value -s PARTUUID /dev/sda1`
`blkid -o value -s PARTLABEL /dev/sda1`

---

• Find all ext4 partitions:
`blkid -t TYPE=ext4`

• Find all LVM PVs:
`blkid -t TYPE=LVM2_member`

• Find all swap partitions:
`blkid -t TYPE=swap`

---

• Find device containing a given UUID:
`blkid -U <UUID>`
Example:
`blkid -U abcd-1234`

---

• Filter by label:
`blkid -L <LABEL>`

---

• Refresh/update blkid cache:
`blkid -c /dev/null`
(Runs fresh scan without reading the cache.)

---

• Print using a custom cache file:
`blkid -c /path/custom-cache`

---

• Completely ignore cache and do raw probing:
`blkid -p /dev/sda1`

---

• Debugging mode (shows probing steps):
`blkid -d /dev/sda1`

---

• To display every known tag for all devices:
`blkid -s UUID -s LABEL -s TYPE`

---

• To list unformatted or empty devices (no TYPE):
`blkid | grep -v TYPE=`

---

• Identify RAID metadata:
`blkid -p /dev/md0`

---

• Identify loop filesystems (containers, singularity images, app images):
`blkid | grep loop`

---

• HPC example: list all GPFS/Spectrum Scale filesystems:
`blkid | grep gpfs`

---

• Full pro-level output fields blkid can detect (varies by device):
UUID → filesystem UUID
LABEL → filesystem label
TYPE → filesystem type (ext4/xfs/swap/lvm/crypto_LUKS)
PARTUUID → GPT partition UUID
PARTLABEL → GPT partition name
SEC_TYPE → secondary FS type
USAGE → filesystem usage (filesystem/raid/lvm/luks/etc.)
PTTYPE → partition table type (gpt/dos)
UUID_SUB → RAID metadata
VERSION → filesystem version
LOGUUID → journal UUID
TYPE → FS type
RO → read-only flag

---

• Full list of major blkid options from man page:
`-c <cache>` → use cache file
`-d` → debug
`-g` → garbage collect cache
`-k` → list all known tags
`-l` → look up device labels
`-L <label>` → search device by label
`-o <format>` → output format
`-p` → low-level probing
`-s <tag>` → print specific tag
`-S <size>` → probing size override
`-t <token>` → search for specific token
`-U <uuid>` → find device by UUID
`-v` → version
`-w <file>` → write to cache
`--help`

---

• Most recommended daily commands (shortlist):
`blkid`
`blkid -o value -s UUID /dev/sda1`
`blkid -o full`
`blkid -o export /dev/sda1`
`blkid -t TYPE=ext4`
`blkid -p /dev/sdb1`
`blkid -U <UUID>`
`blkid -L <LABEL>`


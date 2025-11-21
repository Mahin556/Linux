• `lsblk` stands for “List Block Devices”; it shows disks, partitions, LVM, RAID, loop devices, mountpoints, filesystem info, etc.

• Command works without root but some columns (like UUID, LABEL) may be restricted.

---

• Basic usage:
`lsblk`
Shows a tree of all block devices.

• Show all devices including empty ones:
`lsblk -a`
Includes RAM disks & unassigned devices.

• Show SCSI-only devices (useful in HPC storage):
`lsblk -S`

• Show each device with major/minor numbers:
`lsblk -m`
Shows MAJ:MIN.

---

• Most useful common command:
`lsblk -f`
Shows filesystem, TYPE, UUID, LABEL, MOUNTPOINT.

---

• Show size in human-readable format:
`lsblk -b` → bytes
`lsblk -d` → disks only
`lsblk -n` → no headers
`lsblk -o` → custom columns

---

• Common custom output example:
`lsblk -o NAME,SIZE,MODEL,SERIAL,TYPE,MOUNTPOINT`
Perfect for storage debugging.

• Show I/O scheduler + queue settings:
`lsblk -o NAME,SCHED,ROTA,DISC-ALN,DISC-GRAN,DISC-MAX`
Helps identify if disk is SSD/HDD.

---

• List only physical disks (exclude partitions):
`lsblk -d -o NAME,SIZE,MODEL`

• List only mounted filesystems:
`lsblk -l -o NAME,SIZE,MOUNTPOINT | grep /`

---

• Show JSON output (good for scripting):
`lsblk -J`
For PRETTY JSON:
`lsblk -J | jq .`

• Machine-parsable output (script-friendly):
`lsblk -P`
Outputs NAME="sda" TYPE="disk" SIZE="50G" … per line.

---

• Show topology information (NUMA, scheduler):
`lsblk -t`
Good on HPC nodes with multiple local NVMe.

---

• Full list of useful columns (use with `-o`):
NAME → device name
KNAME → kernel name
PKNAME → parent kernel name
PATH → /dev/... path
MAJ:MIN → major/minor numbers
FSTYPE → filesystem (ext4/xfs)
LABEL → filesystem label
UUID → filesystem UUID
PARTUUID → GPT partition UUID
PARTLABEL → GPT name
MOUNTPOINT → mount location
TYPE → disk / part / lvm / rom / loop
SIZE → device size
OWNER → owner user
GROUP → owner group
MODE → permissions
STATE → running / live / offline
HOTPLUG → 1 for removable
ROTA → 1=HDD, 0=SSD
SCHED → I/O scheduler
DISC-ALN → alignment
DISC-GRAN → granularity
DISC-MAX → max discard size (TRIM)
WWN → world-wide name (useful in SAN)
MODEL → model name
SERIAL → serial number
VENDOR → vendor
RM → removable (USB)
LOG-SEC → logical block size
PHY-SEC → physical block size
TRAN → SATA/NVMe/USB
SUBSYSTEMS → kernel subsystems
REV → firmware revision

---

• Show everything lsblk can possibly display:
`lsblk -O`
Full dump of all possible fields.

---

• Example: print disk tree with filesystem UUID + labels:
`lsblk -o NAME,SIZE,FSTYPE,LABEL,UUID,MOUNTPOINT`

---

• Show NVMe-only details:
`lsblk | grep nvme`
Or:
`lsblk -o NAME,MODEL,SN,WWN,LOG-SEC,PHY-SEC | grep nvme`

---

• Show only devices used in LVM:
`lsblk -o NAME,TYPE | grep lvm`

---

• Show partitions and children only (exclude raw disk):
`lsblk -rp`
Useful when passing raw block device to containers.

---

• Compare disk sizes (raw vs partition):
`lsblk /dev/sda`
Or:
`lsblk -d /dev/sda` → only main disk
`lsblk /dev/sda -o NAME,SIZE,TYPE`

---

• Check if disk supports discard (TRIM):
`lsblk -D`
Shows DISC-GRAN & DISC-MAX.

---

• Identify which device a mountpoint comes from:
`lsblk -o NAME,MOUNTPOINT | grep /home`

---

• HPC example: find all local SSDs on compute node:
`lsblk -d -o NAME,ROTA,MODEL | grep ' 0 '`
(ROTA 0 = SSD / NVMe)

• HPC example: check all GPFS/IBM Spectrum Scale disks:
`lsblk -o NAME,TYPE,FSTYPE | grep gpfs`

---

• HPC example: list all NVMes sorted by size:
`lsblk -dn -o NAME,SIZE | sort -k2 -h`

---

• Udev-friendly listing (for automation):
`lsblk -p -o NAME,UUID,FSTYPE,TYPE`

---

• Show only mounted block devices with filesystem info:
`lsblk -fs`

---

• Check for LUKS encrypted containers:
`lsblk -o NAME,FSTYPE | grep crypt`

---

• To print **hierarchy in list format** instead of tree:
`lsblk -l`

---

• To include unpopulated devices like loop:
`lsblk -e 7` → exclude dev type
`lsblk -e 11` → exclude ROM devices

---

• Exclude loop devices (very common):
`lsblk -e 7`

---

• Combine everything:
`lsblk -a -O -p`

---

• All options from man page (practical ones marked with *):
`-a` show all
`-b` bytes
`-d` no children
`-D` discard info *
`-e <list>` exclude devices
`-f` filesystem info *
`-i` ascii only
`-J` JSON *
`-l` list format
`-m` permissions
`-n` no headings
`-o <list>` output cols *
`-O` all columns
`-p` full paths *
`-P` key="value" format *
`-r` raw output
`-s` inverse tree (children first)
`-S` SCSI devices *
`-t` topology *
`-x` sort columns
`-z` ignore forbidden info
`--sysroot <dir>` change root
`--help`
`--version`

---

• Most recommended daily commands (shortlist):
`lsblk -f`
`lsblk -o NAME,SIZE,TYPE,MOUNTPOINT`
`lsblk -O`
`lsblk -dp`
`lsblk -J`
`lsblk -D`
`lsblk -o NAME,MODEL,SERIAL,WWN`
`lsblk -o NAME,ROTA,SIZE`
`lsblk -o NAME,FSTYPE,LABEL,UUID,MOUNTPOINT`

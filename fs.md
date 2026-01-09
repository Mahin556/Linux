```bash
======================== COMPLETE LINUX FILE SYSTEM GUIDE ========================

------------------------ BASIC CONCEPT ------------------------
Computers store data on hard disks.
A raw disk cannot store files directly.

Analogy:
Raw disk  → empty land
Partition → plot
File system → house

Before using a disk:
1) Create partitions
2) Format partitions with a file system

Only after this can data be stored.

------------------------ WHAT IS A FILE SYSTEM ------------------------
A file system defines:
- How data is stored
- How data is organized
- How data is retrieved

A file system:
- Breaks a partition into blocks (small addressable units)
- Tracks which blocks belong to which file
- Maintains metadata (size, owner, permissions, timestamps)

When a file is created:
- Data is written into blocks
- Metadata is updated

When a file is deleted:
- Blocks are marked as free
- Data may still exist until overwritten

Each partition MUST have a file system to be usable.

------------------------ BLOCKS & INODES ------------------------
Block:
- Smallest unit of data storage
- Typical sizes: 4KB, 8KB, etc.

Inode:
- Stores metadata (not file name)
- Contains:
  - file size
  - owner
  - permissions
  - timestamps
  - block locations

Filename → maps to inode
Inode → maps to data blocks

------------------------ FILE SYSTEM TYPES ------------------------

1) EXT (Extended File System)
- First Linux-specific file system
- Introduced in 1992
- No journaling
- Primitive
- Obsolete

2) EXT2
- Introduced in 1993
- No journaling
- Faster than ext3 in some cases
- Poor crash recovery
- Deprecated

3) EXT3
- Introduced in 2001
- Adds journaling to ext2
- Default in older RHEL versions
- File system size: up to 16 TiB
- File size: up to 2 TiB
- Supports ~32,000 subdirectories
- Mostly replaced by ext4

4) EXT4
- Default in RHEL6
- Backward compatible with ext3
- Uses extents instead of block mapping
- File system size: up to 1 EiB
- File size: up to 16 TiB
- Unlimited subdirectories
- Reliable and stable
- Widely used

5) XFS
- Developed by Silicon Graphics
- Default in RHEL7 and later
- High-performance 64-bit journaling FS
- Designed for large files and parallel IO
- File size: up to 8 EiB
- File system size: up to 8 EiB
- Cannot shrink (only grow)
- Excellent for databases and enterprise workloads

6) VFAT (FAT32)
- Microsoft file system
- No journaling
- File size limit: 4GB
- Used for USB drives
- Good interoperability
- Not used for Linux system files

7) NTFS
- Windows default file system
- Supports:
  - permissions
  - encryption
  - compression
  - journaling
- Linux can read/write via ntfs-3g
- Not recommended for Linux root FS

8) Swap Space
- Used as virtual memory
- Activated when RAM is full
- Can be:
  - partition
  - file
  - LVM volume
- Improves stability
- Not a file system for data storage

------------------------ LVM (LOGICAL VOLUME MANAGER) ------------------------
Not a file system, but a storage management layer.

Advantages:
- Resize volumes dynamically
- Add disks without downtime
- Snapshots
- Flexible storage management

Layers:
Physical Volume (PV)
Volume Group (VG)
Logical Volume (LV)
File system sits on LV

------------------------ RAID ------------------------
Combines multiple disks into one logical unit.

Goals:
- Performance
- Redundancy
- Fault tolerance

Common RAID levels:
RAID 0 → striping (fast, no redundancy)
RAID 1 → mirroring (safe, less space)
RAID 5 → parity (balanced)
RAID 6 → double parity
RAID 10 → mirror + stripe

Hardware RAID:
- Dedicated controller
- No CPU overhead

Software RAID:
- Managed by Linux
- Uses CPU resources

------------------------ FILE SYSTEM STANDARD (FSSTND / FHS) ------------------------
Because Linux has many distributions, a standard layout is required.

FSSTND / FHS:
- Defines directory structure
- Ensures consistency across distros
- Root of everything is /

------------------------ KEY LINUX DIRECTORIES ------------------------
/        → root of file system
/bin     → essential user commands
/sbin    → system administration commands
/etc     → configuration files
/home    → user home directories
/root    → root user home
/var     → logs, spool files, variable data
/tmp     → temporary files
/usr     → user programs, libraries
/lib     → shared libraries
/boot    → kernel and bootloader files
/dev     → device files
/proc    → virtual kernel info
/sys     → kernel and hardware info
/mnt     → temporary mounts
/media  → removable media

------------------------ FILE SYSTEM BEHAVIOR ------------------------
- Different file systems handle blocks differently
- Small blocks → better for small files
- Large blocks → better for large files
- Journaling FS logs changes before writing
- Improves crash recovery

------------------------ SUMMARY ------------------------
Disk → Partition → File System → Files
Linux supports multiple file systems
Each has trade-offs:
- EXT4 → general purpose
- XFS → high performance
- VFAT/NTFS → interoperability
- LVM/RAID → enterprise storage management

File system is the FOUNDATION of data storage in Linux.

===============================================================================
```
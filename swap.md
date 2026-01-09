```
======================== LINUX SWAP SPACE – COMPLETE DETAILED GUIDE (WITH COMMANDS) ========================

WHAT IS SWAP SPACE
Swap space is a portion of disk storage used as virtual memory when physical RAM
is exhausted. It acts as a RAM extension, not a replacement.

Linux was designed primarily for multi-user, multi-service servers where many
processes run simultaneously. Because RAM is limited and expensive, swap allows
the system to continue functioning under memory pressure.

Swap can exist as:
- A swap partition
- A swap file
- An LVM-based swap volume

----------------------------------------------------------------------------------

WHY SWAP IS NEEDED
- Many services run at the same time (databases, web servers, cron jobs, daemons)
- Each process needs memory
- RAM is finite
- Without swap:
  - System may freeze
  - New processes cannot start
  - Kernel may invoke OOM (Out Of Memory) killer

Swap provides:
- Stability
- Memory overcommit handling
- Graceful performance degradation instead of crashes

----------------------------------------------------------------------------------

HOW MEMORY WORKS IN LINUX
- RAM is divided into fixed-size memory pages (commonly 4 KB)
- Each process gets its own virtual memory space
- The CPU schedules processes using time slices (quantum)
- Active processes must have pages in RAM to execute

----------------------------------------------------------------------------------

HOW SWAP WORKS (STEP BY STEP)
1. RAM is divided into pages
2. Processes request memory
3. RAM fills up as processes increase
4. Kernel monitors memory pressure
5. Idle (least recently used) pages are selected
6. These pages are moved to swap on disk
7. RAM is freed for active processes
8. When swapped data is needed again, it is read back into RAM

IMPORTANT:
CPU can ONLY work on data present in RAM.

----------------------------------------------------------------------------------

EXAMPLE SCENARIO
System RAM: 4 GB
Kernel usage: 3 GB
Available for apps: 1 GB

Applications:
- Photoshop: 600 MB
- Firefox: 400 MB
Total: 1 GB (RAM full)

With swap enabled:
- Firefox swapped out when Photoshop is active
- Photoshop swapped out when Firefox is active
- System remains responsive

Without swap:
- System may freeze
- Process may be killed by OOM killer

----------------------------------------------------------------------------------

ROLE OF SWAP SPACE
- Overflow memory
- Stores inactive pages
- Frees RAM for active processes
- Prevents crashes
- Improves system stability

----------------------------------------------------------------------------------

PERFORMANCE CONSIDERATIONS
- Swap is on disk (slow)
- RAM is very fast
- Excessive swapping causes:
  - High I/O wait
  - Slowness
  - Thrashing

Swap improves stability, NOT speed.

----------------------------------------------------------------------------------

SWAPPINESS (SWAP USAGE THRESHOLD)
- Kernel parameter controlling swap usage
- Range: 0 – 100
- Default: 60

Lower value → prefer RAM
Higher value → aggressive swapping

Check swappiness:
cat /proc/sys/vm/swappiness

Change temporarily:
sysctl vm.swappiness=10

Change permanently:
vim /etc/sysctl.conf
vm.swappiness=10

----------------------------------------------------------------------------------

WHEN SWAP IS USED
- RAM usage exceeds threshold
- Memory pressure increases
- Idle pages exist
- Kernel needs free memory

Swap is NOT used when:
- RAM is sufficient
- Active processes dominate memory

----------------------------------------------------------------------------------

SWAP VS RAM
RAM:
- Fast
- Volatile
- Direct CPU access

Swap:
- Slow
- Non-volatile
- Used only when needed

----------------------------------------------------------------------------------

BEST PRACTICES
- Always configure swap on servers
- Prefer SSD-based swap
- Monitor swap usage
- Tune swappiness
- Do not disable swap on production servers

----------------------------------------------------------------------------------
----------------------------- SWAP RELATED COMMANDS ------------------------------
----------------------------------------------------------------------------------

# Check memory and swap usage
free -h

# Detailed memory info
cat /proc/meminfo

# Show active swap areas
swapon --show
swapon -s

# Enable all swap entries from /etc/fstab
swapon -a

# Disable all swap
swapoff -a

# Enable specific swap device or file
swapon /dev/sdX
swapon /swapfile

# Disable specific swap
swapoff /dev/sdX
swapoff /swapfile

# Create a swap file (example: 2GB)
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Create swap using dd (alternative)
dd if=/dev/zero of=/swapfile bs=1M count=2048
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Make swap permanent
vim /etc/fstab
/swapfile swap swap defaults 0 0

# Check swap usage per process
top
htop

# Check swap I/O activity
vmstat 1

# Clear swap safely (restart swap)
swapoff -a && swapon -a

----------------------------------------------------------------------------------

SUMMARY
- Swap is disk-based virtual memory
- Used when RAM is under pressure
- Moves idle pages to disk
- Prevents system crashes
- Excessive swap hurts performance
- Proper tuning is essential

======================== END OF SWAP SPACE GUIDE ========================
```
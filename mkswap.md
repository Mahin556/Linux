• `mkswap` creates a **swap area** on a block device or file.
• After creating swap, you must **activate it with `swapon`**.
• Swap is used for:
• virtual memory
• hibernation
• preventing OOM-killer
• HPC or large memory workloads

---

• Basic syntax:
`mkswap <device>`
Example:
`mkswap /dev/sda2`

---

### **How swap works (quick theory)**

• Swap = space on disk used when RAM is full.
• Kernel swaps out pages to disk.
• Swap is slow compared to RAM, but prevents crashes.
• Swap can be a **file** or **partition**.

• Swap does NOT use a filesystem.
• Swap area contains:
• magic header
• UUID
• metadata
• bitmap of free/used swap pages

---

### **Check swap before creating**

• Check existing swap:
`swapon --show`
`cat /proc/swaps`
`free -h`

---

### **Create swap on a partition**

• Standard swap creation:
`mkswap /dev/sdb2`

• With label:
`mkswap -L SWAP1 /dev/sdb2`

• With UUID (random):
`mkswap -U random /dev/sdb2`

• With specific UUID:
`mkswap -U <uuid> /dev/sdb2`

---

### **Create swap on a file**

• Create 4GB swap file:

```
dd if=/dev/zero of=/swapfile bs=1M count=4096
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
```

• Faster creation using fallocate:

```
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
```

---

### **Activate / Deactivate swap**

• Activate a swap device/file:
`swapon /dev/sdb2`
`swapon /swapfile`

• Activate all swaps listed in `/etc/fstab`:
`swapon -a`

• Deactivate:
`swapoff /dev/sdb2`

---

### **Add swap permanently (fstab)**

Add line to `/etc/fstab`:

• For partition:

```
UUID=<uuid>   none   swap   sw   0  0
```

• For file:

```
/swapfile     none   swap   sw   0  0
```

---

### **Generate UUID for fstab**

`blkid /dev/sdb2`
or
`mkswap -U random /dev/sdb2`

---

### **Advanced Options for mkswap**

• `-c`
• Check device for bad blocks before creating swap
Example:
`mkswap -c /dev/sdb2`
(Slow, but good for old HDDs.)

• `-l`
• Old label option, same as -L
`mkswap -l SWAP1 /dev/sdb2`

• `-L <label>`
• Set label
`mkswap -L HPCSWAP /dev/nvme0n1p3`

• `-p`
• Set page size
• Rarely used—kernel auto-detects
Example:
`mkswap -p 4096 /dev/sdb2`

• `-U <uuid>`
• Set UUID
Example:
`mkswap -U 1234-5678 /dev/sdb2`

• `-f`
• Force even if device looks in use
Example:
`mkswap -f /dev/sdb2`

• `--verbose`
• Print detailed operation info
Example:
`mkswap --verbose /dev/sdb2`

---

### **Swap File vs Swap Partition**

• Swap Partition:
• faster
• no fragmentation
• best for servers/HPC

• Swap File:
• easier to resize
• good for desktops/cloud VMs
• slower due to filesystem overhead

---

### **Check swap after creating**

• `free -h`
• `swapon --show`
• `cat /proc/meminfo | grep Swap`

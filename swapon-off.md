### **What swapon and swapoff do**

• `swapon` → **enables** a swap area (file or partition).
• `swapoff` → **disables** a swap area.
• Works with swap partitions and swap files.
• Must be run as root.

---

### **Check existing swap**

• `swapon --show`
• `cat /proc/swaps`
• `free -h`
• `cat /proc/meminfo | grep Swap`

---

### **Enable swap partition**

• `swapon /dev/sda2`

---

### **Enable swap file**

• `swapon /swapfile`

---

### **Enable all swap entries from /etc/fstab**

• `swapon -a`
Loads all swap devices marked as:

```
/dev/sda2 none swap sw 0 0
/swapfile none swap sw 0 0
```

---

### **Disable swap**

• `swapoff /dev/sda2`
• `swapoff /swapfile`

---

### **Disable all swap devices**

• `swapoff -a`

---

### **Show swap details**

• `swapon --show`
Same as:
`swapon -s` (old format)

Shows:
• NAME
• TYPE
• SIZE
• USED
• PRIORITY

---

### **Priority of swap devices**

• Linux can have multiple swap devices.
• Higher priority → used first.
• Set swap priority:

```
swapon -p <priority> <device>
```

• Example:
`swapon -p 10 /swapfile`
`swapon -p 20 /dev/sda2`
(Partition gets used first.)

---

### **Setting swap priority in fstab**

```
/dev/sda2 swap swap pri=20 0 0
/swapfile swap swap pri=10 0 0
```

---

### **Re-check swap device usage**

• `free -h`
• `swapon --show`

---

### **swapoff safety**

• `swapoff` moves pages from swap back to RAM.
• If RAM is insufficient → **system may lag or crash**.
• Ensure free RAM:
`free -h`

---

### **Common scenarios for swapoff**

• Editing or resizing a swap partition
• Editing swap file size
• Changing filesystem on underlying partition
• Encrypting swap
• Benchmarks where you want swap disabled
• HPC compute nodes (swap usually disabled)

---

### **Resize a swap file (safe steps)**

• Disable swap:
`swapoff /swapfile`

• Resize file:

```
rm /swapfile
fallocate -l 8G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
```

---

### **Enable swap during boot (fstab)**

For partition:

```
UUID=<uuid> none swap sw 0 0
```

For file:

```
/swapfile none swap sw 0 0
```

---

### **Advanced options of swapon**

• `-a` → enable all from fstab
• `-p <priority>` → assign swap priority
• `-d` → debug
• `--show` → display swap summary
• `--discard` → issue TRIM/discard on SSD
• `--no-discard` → disable discard
• `--cache` → disable swapfile read-ahead
• `--summary` → old output
• `--help`
• `--version`

---

### **Advanced options of swapoff**

• `-a` → disable all swap
• `-v` → verbose mode
• `--help`
• `--version`

---

### **Discard (TRIM) for SSDs**

• Enable TRIM when enabling swap:
`swapon --discard /swapfile`
or
add to fstab:

```
/swapfile none swap sw,discard 0 0
```

• Good for SSD health.

---

### **Tuning swap behavior**

#### **vm.swappiness**

• Controls how aggressively Linux uses swap.
• Check current value:
`cat /proc/sys/vm/swappiness`

• Change temporarily:
`sysctl vm.swappiness=10`

• Permanent (/etc/sysctl.conf):
`vm.swappiness = 10`

---

#### **vfs_cache_pressure**

• Controls caching of filesystem metadata.

• Check:
`cat /proc/sys/vfs_cache_pressure`

• Lower values = keep more cache → faster I/O.
• Example tune:
`vfs_cache_pressure = 50`

---

### **HPC-specific notes**

• HPC compute nodes usually **disable swap**:
• avoid unpredictable latency
• jobs should fail early instead of swapping
• swap slows down applications significantly

• But login nodes may have small swap.

• Example HPC disable:
`swapoff -a`
Remove swap from `/etc/fstab`.

---

### **Common recommended practical commands**

• Check current swap:
`swapon --show`
`free -h`

• Activate swap:
`swapon /dev/sda2`

• Disable swap:
`swapoff /dev/sda2`

• Activate all swap via fstab:
`swapon -a`

• Disable all swap:
`swapoff -a`

• Swap file resize workflow (safe):

```
swapoff /swapfile
fallocate -l 8G /swapfile
mkswap /swapfile
swapon /swapfile
```


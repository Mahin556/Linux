## **What `findmnt` is**

• `findmnt` = the **best and most modern command** to view mounted filesystems.
• Much better than `mount` output.
• Shows:
• device
• mountpoint
• filesystem type
• mount options
• hierarchy (tree view)
• parent-child relationships
• Supports filtering, custom columns, JSON output, and exact mountpoint lookup.

---

## **Basic usage**

### **Show all mounted filesystems**

```
findmnt
```

### **Tree view of all mounts (default)**

• Clearly shows parent → child mounts.

---

## **Find mount by device or directory**

### **Find where a device is mounted**

```
findmnt /dev/sda1
```

### **Find which device backs a mountpoint**

```
findmnt /mnt
```

### **Find the device used for root filesystem**

```
findmnt /
```

---

## **Simple list format**

```
findmnt -l
```

(l = list, not tree)

---

## **Show mount source only**

```
findmnt -n -o SOURCE /
```

(n = no headings, -o = custom column)

---

## **Show target (mountpoint) only**

```
findmnt -n -o TARGET /dev/sda1
```

---

## **Filter by filesystem type**

### **All ext4 mounts**

```
findmnt -t ext4
```

### **Multiple types**

```
findmnt -t ext4,xfs
```

---

## **Filter by mount options**

### **Find all read-only mounts**

```
findmnt -O ro
```

### **Find all noexec mounts**

```
findmnt -O noexec
```

### **Find all network (remote) mounts**

```
findmnt -t nfs,nfs4,cifs
```

---

## **Show custom columns**

### Example: device, mountpoint, type, options

```
findmnt -o SOURCE,TARGET,FSTYPE,OPTIONS
```

### Example: device + size

```
findmnt -o SOURCE,TARGET,SIZE
```

---

## **Show in JSON (great for scripting)**

```
findmnt -J
```

### Pretty print with jq

```
findmnt -J | jq .
```

---

## **Show fstab entries**

```
findmnt --fstab
```

### Show what will be mounted from fstab

```
findmnt -s   # system fstab view
```

---

## **Show kernel mount info (/proc/self/mountinfo)**

```
findmnt --kernel
```

---

## **Show mountpoints for a specific user**

```
findmnt --user
```

---

## **Compare system mounts vs fstab (detect mismatch)**

```
findmnt --verify
```

Useful for debugging fstab mistakes.

---

## **Watch for mount/unmount events (live)**

```
findmnt -p
```

(p = poll mode)

---

## **Unmount helper**

### **See what is blocking a mount quickly**

```
findmnt /mnt
```

Then run:

```
fuser -vm /mnt
```

---

## **Useful columns for custom output**

• SOURCE
• TARGET
• FSTYPE
• OPTIONS
• SIZE
• USED
• AVAIL
• FSROOT
• MAJ:MIN
• PROPAGATION
• LABEL
• UUID

Example (most commonly used):

```
findmnt -o SOURCE,TARGET,FSTYPE,SIZE,OPTIONS
```

---

## **Troubleshooting with findmnt**

### **1. Mountpoint not found**

```
findmnt /data
```

If empty → not mounted.

### **2. Duplicate mounts**

```
findmnt -o TARGET,SOURCE | uniq -d
```

### **3. Wrong device mounted**

```
findmnt -o TARGET,SOURCE | grep /data
```

### **4. NFS debugging**

```
findmnt -t nfs,nfs4
```

### **5. Detect bind mounts**

```
findmnt -o SOURCE,TARGET,FSTYPE,PROPAGATION
```

-
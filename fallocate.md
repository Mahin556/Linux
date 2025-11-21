## **What `fallocate` does**

• `fallocate` **pre-allocates space** for a file on a filesystem **without writing actual data**.
• It is the fastest way to create large files because it avoids slow zero-writing (`dd`).
• Used for:
• swapfiles
• virtual machine disk images
• databases
• sparse file manipulation
• performance testing
• HDD/SSD allocation
• container storage (Docker images)

• Works **only** on filesystems that support the fallocate system call:
• ext4
• xfs
• btrfs
• ocfs2
• tmpfs
(NOT supported on FAT32, NTFS, some network FS depending on mount options.)

---

## **Basic syntax**

`fallocate -l <size> <file>`

Example:
`fallocate -l 4G myfile.img`
Creates a fast 4GB file.

---

## **Create a swap file using fallocate (common use)**

```
fallocate -l 8G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
```

---

## **Main options**

### `-l <size>`

• Length of file. Required.
• Supports units: K, M, G, T.

`fallocate -l 2G test.img`

---

### `-o <offset>`

• Offset inside file where allocation begins.
• Useful for modifying existing file ranges.

`fallocate -o 1G -l 512M bigfile`

Allocates 512M starting at 1GB offset.

---

### `-n`

• **Do NOT change file size**.
• Pre-allocates space for existing file blocks only.

`fallocate -n -l 1G file`

Useful in databases.

---

## **Collapse, punch, zero, deallocate ranges (Advanced)**

These require a filesystem that supports advanced fallocate operations (ext4, xfs, btrfs).

---

### **Punch hole (deallocate space inside a file)**

(Frees space → file becomes sparse)

`fallocate -p -l <len> -o <offset> file`
or
`fallocate -d -o <offset> -l <len> file`

Examples:

Free 1GB region inside file:
`fallocate -p -o 0 -l 1G large.img`

---

### **Zero a range without punching a hole**

`fallocate -z -o <offset> -l <length> file`

Example:
`fallocate -z -o 0 -l 4M logfile`

---

### **Collapse range (remove data and shrink file)**

`fallocate -c -o <offset> -l <length> file`

Example:
Delete 100MB starting from 1GB:
`fallocate -c -o 1G -l 100M file`

---

### **Insert a range (shift data to the right)**

`fallocate -i -o <offset> -l <length> file`
Inserts space inside a file.

---

## **Filesystems that support fallocate**

### **ext4**

• Full support
• Punch hole, collapse, zero, insert all supported.

### **xfs**

• Full support
• Best performance for large file pre-allocation.

### **btrfs**

• Supported but slower because of COW.

### **Do NOT support fallocate:**

• FAT32/exFAT
• tmpfs (supports only truncate-like ops)
• NFS often partially supports only size extension
• CIFS/SMB sometimes no support
• NTFS (Linux ntfs-3g does NOT support fallocate)

---

## **Check if fallocate is supported**

Try:
`fallocate -l 1G testfile`
If unsupported → error:
`Operation not supported`

---

## **fallocate vs dd (important)**

### `fallocate`

• FAST (metadata only)
• No real data written
• Great for VM images, swap, tests
• Does NOT overwrite old data → not secure-erase
• File may contain old disk data internally (not visible to user)

### `dd`

• SLOW (writes real zeros)
• Secure (overwrites blocks)
• Needed for:
• wiping
• benchmarking write speed
• consistent test patterns

Example:

```
dd if=/dev/zero of=file bs=1M count=4096
```

---

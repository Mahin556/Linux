* It shows disk space usage of filesystems mounted on a Linux machine or container.
```bash
df #Shows disk usage in 1K blocks (default).
```
* “1K blocks” means the tool is showing disk sizes in units of 1 kilobyte (1024 bytes) per block.
* `100000 1K-blocks`
* `100000 × 1024 bytes = 102,400,000 bytes`
* Historically, Unix systems measured storage in 1 KB units (1024 bytes).
* It provides consistent representation across filesystems.

---

| Option           | Meaning                                   |
| ---------------- | ----------------------------------------- |
| `-h`             | human-readable sizes(1024-based sizes)                     |
| `-H`             | human-readable (1000-based.) |
| `-T`             | show filesystem type                      |
| `-i`             | show inode info                           |
| `-a`             | show all filesystems                      |
| `-t <type>`      | show only FS of this type                 |
| `-x <type>`      | exclude specific FS type                  |
| `--total`        | show total disk usage                     |
| `-B <blocksize>` | custom block size                         |

---
* What does a tmpfs entry in df mean?
    A RAM-based filesystem.
---

```bash
df -h #Human readable -> auto chooses KB/MB/GB/TB

df -m #Show in MB

df -BG #Show in GB

df -B1 #Show in bytes

df -B4K #Show in 4K blocks
```

---
```bash
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   20G   28G  42% /
tmpfs           1.9G     0  1.9G   0% /dev/shm
```

| Column         | Meaning                                              |
| -------------- | ---------------------------------------------------- |
| **Filesystem** | Device or virtual FS (ex: /dev/sda1, tmpfs, overlay) |
| **Size**       | Total storage capacity of the filesystem             |
| **Used**       | How much space is occupied                           |
| **Avail**      | How much is free for you to use                      |
| **Use%**       | Percentage of filesystem used                        |
| **Mounted on** | Directory where filesystem is mounted                |

---
* Display File System Type
```bash
df -Th
```
```bash
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/sda1      ext4    50G   20G   28G  42% /
tmpfs          tmpfs  1.9G     0  1.9G   0% /dev/shm
overlay        overlay 20G   12G   8G   60% /
```
* ext4, xfs → disk FS
* tmpfs → RAM FS
* overlay → Docker’s UnionFS
* nfs → remote storage

---

* Check Specific Filesystem or Directory
```bash
df -h /home
df -h /var/log
df -h /tmp
df -h /demo
```
---

* Show Inodes Usage
```bash
df -i
```
```bash
Filesystem      Inodes  IUsed   IFree IUse% Mounted on
/dev/sda1       3276800 145672 3131128   5% /
```
---

* Sorting by Usage (Shows highest %Use at top.)
```bash
df -h | sort -k5 -r
```

---

* Excluding tmpfs and other virtual filesystems
```bash
df -h -x tmpfs -x devtmpfs
```

---

* Check free space on a particular mount
```bash
df -hT /var/lib/docker
df -hT /var/lib/kubelet
```

---

```bash
kubectl exec -it <pod> -- df -h

docker exec -it <container> df -h
```
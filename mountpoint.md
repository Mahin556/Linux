**mountpoint — Complete Guide**
*(Checks whether a directory is a mount point)*

• **mountpoint** is a small Linux utility used to test if a given directory is a valid mount point.
• It is extremely useful in scripting, automation, LVM operations, cloud-init scripts, and when working with storage devices.
• A **mount point** is simply a directory where a filesystem is attached (mounted).
• mountpoint exits with specific **exit codes** so scripts can make decisions.


### **Basic Syntax**
```
mountpoint [OPTIONS] DIRECTORY
```


### **Most Important Options**
```
mountpoint DIRECTORY
```
• Checks if DIRECTORY is a mount point
• Output example when true:
“/mnt is a mountpoint”
• Output example when false:
“/mnt is not a mountpoint”


### **Check quietly (no output)**
```
mountpoint -q DIRECTORY
```
• Does not print anything
• Only exit status is used
• Useful in scripts


### **Check using device name instead of directory**
```
mountpoint -d DIRECTORY
```
• Prints the **major:minor** device number
• Used for debugging disk/mount relationships
• Example output:
“8:1”


### **Check using filesystem ID**
```
mountpoint -x DIRECTORY
```
• Shows the filesystem identifier assigned by the kernel
• Example:
“0:48”


### **Exit Codes**
• `0` → The directory **is** a mount point
• `1` → The directory is **not** a mount point
• `32` → Operational/usage error (wrong syntax, wrong options)


### **Common Examples**
**Check if /data is a mount point**
```
mountpoint /data
```

**Use in script to check before mounting**
```
if mountpoint -q /data; then
    echo "/data already mounted"
else
    mount /dev/xvdf1 /data
fi
```

**Get the device number of a mount**
```
mountpoint -d /var
```

**Test before unmounting**
```
if mountpoint -q /backup; then
    umount /backup
fi
```

**Check root filesystem**
```
mountpoint /
```


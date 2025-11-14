* dd = Data Duplicator
  * Used for:
    * Creating large test files
    * Test disk speed
    * Copying disks
    * Cloning partitions
    * Benchmarking I/O
    * Creating bootable USB
    * Wiping disks
    * Filling files with random data
    * Creating swap files
    * Testing emptyDir/tmpfs limits (like you did earlier)
    * Stress test Kubernetes emptyDir/tmpfs
    * Fill/unfill storage for eviction tests
    * Clone or backup disks

```bash
##############################################
# BASIC SYNTAX
##############################################
dd if=<input_file> of=<output_file> bs=<block_size> count=<num_blocks>

# if   = input file/device
# of   = output file/device
# bs   = block size (1M, 4K, 1G…)
# count = number of blocks to read/write


##############################################
# 1. CREATE A LARGE FILE (TEST FILE)
##############################################

dd if=/dev/zero of=myfile.img bs=1M count=100
# Creates a 100 MB file filled with zeros.
# /dev/zero = infinite zeros, used for quick file creation.


##############################################
# 2. CREATE RANDOM DATA FOR TESTING
##############################################

dd if=/dev/urandom of=random.img bs=1M count=20
# /dev/urandom = random bytes
# Good for testing compression, encryption, tmpfs/emptyDir limits.


##############################################
# 3. TEST DISK WRITE SPEED
##############################################

dd if=/dev/zero of=testfile bs=1G count=1 oflag=direct
# oflag=direct → bypass OS cache (real disk speed)
# Produces write benchmark at the end.


##############################################
# 4. TEST DISK READ SPEED
##############################################

dd if=testfile of=/dev/null bs=1G count=1 iflag=direct
# Read testfile and throw output away
# Measures read speed.


##############################################
# 5. CLONE A DISK (DANGEROUS!)
##############################################

dd if=/dev/sda of=/dev/sdb bs=64K conv=noerror,sync
# Clones entire disk sda → sdb
# conv=noerror  = continue even if read errors occur
# conv=sync     = pad blocks to maintain alignment
# WARNING: DESTROY DATA if wrong.


##############################################
# 6. BACKUP AN ENTIRE DISK TO A FILE
##############################################

dd if=/dev/sda of=/root/disk-backup.img bs=1M
# Makes a raw disk image.


##############################################
# 7. RESTORE A DISK IMAGE TO A DISK
##############################################

dd if=/root/disk-backup.img of=/dev/sda bs=1M
# Complete raw restore.


##############################################
# 8. WIPE A DISK (REMOVE ALL DATA)
##############################################

dd if=/dev/zero of=/dev/sda bs=1M
# Overwrite disk with zeros → destroys ALL data.

dd if=/dev/urandom of=/dev/sda bs=1M
# Overwrite disk with random data → secure erase.


##############################################
# 9. CREATE A SWAP FILE
##############################################

dd if=/dev/zero of=/swapfile bs=1M count=2048
# Creates 2GB swap file.
mkswap /swapfile
swapon /swapfile


##############################################
# 10. COPY ONLY PART OF A FILE
##############################################

dd if=bigfile.bin of=first50MB.bin bs=1M count=50
# Extract the first 50MB.


##############################################
# 11. SKIP BYTES WHILE READING
##############################################

dd if=bigfile.bin of=output.bin bs=1M skip=100
# Skip first 100MB of input.


##############################################
# 12. SKIP BLOCKS WHILE WRITING
##############################################

dd if=small.img of=bigdisk.img bs=1M seek=500
# Start writing at offset = 500 MB into output.


##############################################
# 13. SHOW PROGRESS WHILE COPYING
##############################################

dd if=/dev/zero of=file.img bs=1M count=100 status=progress
# status=progress = display real-time progress updates.


##############################################
# 14. CREATE A BOOTABLE USB FROM ISO
##############################################

dd if=ubuntu.iso of=/dev/sdb bs=4M status=progress
# Creates bootable USB.
# BE VERY SURE /dev/sdb IS CORRECT!


##############################################
# 15. VERIFY A COPY USING dd + md5sum
##############################################

md5sum /dev/sda
md5sum /dev/sdb
# If hashes match → disks are identical.


##############################################
# 16. CONVERT TEXT FILE LINE ENDINGS
##############################################

dd if=winfile.txt of=linuxfile.txt conv=unblock
# Example of using dd for conversion operations.


##############################################
# 17. CREATE FILE OF EXACT SIZE (useful for emptyDir testing)
##############################################

dd if=/dev/zero of=/demo/bigfile bs=10M count=10
# Writes exactly 100MB to emptyDir.

dd if=/dev/urandom of=/demo/bigfile bs=1M count=1024
# Write exactly 1GB of random data to test tmpfs or emptyDir limits.


##############################################
# 18. WRITE UNTIL DISK IS FULL (WARNING)
##############################################

dd if=/dev/zero of=FILL_DISK bs=1M
# Keeps writing until disk is full.
# Useful for testing Kubernetes eviction on disk pressure.


##############################################
# END OF COMPLETE dd COMMAND GUIDE
##############################################
```

---

### **`bs=` — Block Size**

* `bs` = **how much data `dd` reads/writes per operation**
* Larger block sizes = **faster performance**
* Smaller block sizes = **slower but more precise**
* Common values:
    * `bs=1M` → good for file creation and tests
    * `bs=4M` → faster for disk cloning
    * `bs=64K` → safe for compatibility
    * `bs=4K` → matches filesystem block size (slow but precise)


### **`/dev/zero`**
* A special device that outputs **infinite zeros**
* Very fast
* Perfect for:
  * creating large test files
  * wiping disks
  * benchmarking write speed
* Example:
    ```bash
    dd if=/dev/zero of=file.img bs=1M count=100
    ```

### **`/dev/urandom`**
* Produces **random bytes**
* Slower than `/dev/zero`
* Used when:
  * testing encryption
  * testing compression
  * wiping disks securely
* Example:
    ```bash
    dd if=/dev/urandom of=random.img bs=1M count=20
    ```

### **`status=progress`**
* Shows **real-time progress**, including:
    * bytes copied
    * speed
    * ETA
* Example:
    ```bash
    dd if=/dev/zero of=file.img bs=1M count=500 status=progress
    ```

### **`seek=` and `skip=`**
* Used to **jump** locations in files.

* **skip=**
    * Skip blocks on the input
    * Useful for **reading from an offset**
    * Example:
        ```bash
        dd if=file.bin of=part.bin bs=1M skip=100 #Skip first 100MB
        ```

* **seek=**
    * Skip blocks on the output
    * Useful for:
        * writing at specific offsets
        * patching binary files
        * creating sparse files
    * Example:
        ```bash
        dd if=small.bin of=big.bin bs=1M seek=500 #Write at 500MB position
        ```

* **`conv=` Options**
    * `conv` = **conversion options** (modify how data is handled)
    * Useful flags:
        * **`noerror`** → keep copying even if read errors occur
            ```bash
            conv=noerror
            ```
        * **`sync`** → pad blocks with zeros to maintain proper alignment
            ```bash
            conv=sync
            ```
        * **`ucase`** → convert text to uppercase
        * **`lcase`** → convert text to lowercase


## 🧠 **What is `hdparm`?**

`hdparm` is a command-line tool to:

* Get or set **hardware parameters** of SATA/IDE drives.
* **View drive info** (model, serial number, cache, etc.)
* **Test disk speed**
* **Enable/disable features** like DMA, read-ahead
* **Perform secure erase** (wipe data at firmware level)

---

## ⚙️ **Basic Syntax**

```bash
hdparm [options] [device]
```

Example:

```bash
sudo hdparm -I /dev/sda
```

---

## 🧾 **Commonly Used Options**

| Option                      | Description                           |
| --------------------------- | ------------------------------------- |
| `-I`                        | Display detailed hardware information |
| `-T`                        | Test cached read speed                |
| `-t`                        | Test buffered (disk) read speed       |
| `-C`                        | Check power mode (active/standby)     |
| `-S`                        | Set standby (spindown) timeout        |
| `-y`                        | Put drive in standby mode immediately |
| `-Y`                        | Put drive in sleep mode               |
| `-a`                        | Get/set read-ahead setting            |
| `-A`                        | Enable/disable read-ahead             |
| `-d`                        | Get/set DMA mode                      |
| `-W`                        | Enable/disable write caching          |
| `--security-erase`          | Perform secure erase (wipes drive)    |
| `--security-erase-enhanced` | Perform enhanced secure erase         |
| `--security-set-pass`       | Set a password before erase           |

---

## 📜 **1️⃣ Viewing Drive Information**

```bash
sudo hdparm -I /dev/sda
```

Shows detailed drive info like:

* Model, firmware, serial
* Supported features (TRIM, SMART, etc.)
* Security status (whether password/lock is set)
* Power management capabilities

Example output:

```
/dev/sda:
ATA device, with non-removable media
Model Number:       WDC WD10EZEX-60WN4A0
Firmware Revision:  01.01A01
Serial Number:      WD-WCC6Y7VXXXX
Security: supported
        enabled
        not locked
        not frozen
        expired: security count
        supported: enhanced erase
```

---

## 📜 **2️⃣ Test Disk Speed**

### 🔹 **Cached Reads (RAM buffer test)**

```bash
sudo hdparm -T /dev/sda
```

Tests how fast data can be read from the Linux disk cache.

---

### 🔹 **Buffered Disk Reads (actual disk I/O speed)**

```bash
sudo hdparm -t /dev/sda
```

Tests how fast data can be read from the drive.

Output:

```
Timing cached reads:   12500 MB in  2.00 seconds = 6250.00 MB/sec
Timing buffered disk reads: 412 MB in 3.00 seconds = 137.33 MB/sec
```

---

## 📜 **3️⃣ Manage Power and Performance**

### 🔹 **Check Power Mode**

```bash
sudo hdparm -C /dev/sda
```

Output:

```
drive state is:  active/idle
```

---

### 🔹 **Put Drive in Standby (spindown)**

```bash
sudo hdparm -y /dev/sda
```

### 🔹 **Put Drive in Sleep**

```bash
sudo hdparm -Y /dev/sda
```

### 🔹 **Set Spindown Timeout**

```bash
sudo hdparm -S 120 /dev/sda
```

Puts drive into standby after `(120 × 5) = 600 seconds`.

---

## 📜 **4️⃣ Read-Ahead and Caching**

### 🔹 **View Current Read-Ahead**

```bash
sudo hdparm -a /dev/sda
```

### 🔹 **Set Read-Ahead to 512 sectors**

```bash
sudo hdparm -a512 /dev/sda
```

### 🔹 **Enable Write Caching**

```bash
sudo hdparm -W1 /dev/sda
```

### 🔹 **Disable Write Caching**

```bash
sudo hdparm -W0 /dev/sda
```

---

## 📜 **5️⃣ DMA Mode Control**

```bash
sudo hdparm -d /dev/sda
```

Shows if DMA is enabled (faster data transfer).

Enable DMA:

```bash
sudo hdparm -d1 /dev/sda
```

---

## 🔐 **6️⃣ Secure Erase (Hardware-Level Wipe)**

This is one of the most powerful uses of `hdparm`.
It erases all data **at the firmware level**, restoring the drive to factory state.

---

### ⚠️ **Step 1: Check Security Status**

```bash
sudo hdparm -I /dev/sdX | grep Security
```

Look for:

```
supported
enabled
not frozen
not locked
supported: enhanced erase
```

---

### ⚠️ **Step 2: If Frozen, Suspend & Resume**

```bash
echo mem | sudo tee /sys/power/state
```

Then wake up the system — this unfreezes the drive.

---

### ⚙️ **Step 3: Set Temporary Password**

```bash
sudo hdparm --user-master u --security-set-pass p /dev/sdX
```

(`p` is a temporary password)

---

### 🧨 **Step 4: Start Secure Erase**

```bash
sudo hdparm --user-master u --security-erase p /dev/sdX
```

This takes a few minutes and **permanently deletes all data**.

For faster and more complete SSD erase (if supported):

```bash
sudo hdparm --user-master u --security-erase-enhanced p /dev/sdX
```

---

### ⚙️ **Step 5: Verify Erase**

Recheck status:

```bash
sudo hdparm -I /dev/sdX | grep Security
```

It should now show:

```
not enabled
not locked
```

---

## ⚠️ **Warnings**

* 💣 Secure erase is **irreversible** — all data is lost.
* 🔒 Don’t use on drives with important data.
* ⚙️ Works **only on drives that support ATA Security**.
* 🔋 On laptops, **plug into power** — secure erase may take long.

---

## 📊 **hdparm vs blkdiscard vs shred**

| Feature                  | `hdparm`         | `blkdiscard`       | `shred`     |
| ------------------------ | ---------------- | ------------------ | ----------- |
| Works at                 | Firmware level   | Block device level | File level  |
| Speed                    | Fast             | Very fast          | Slow        |
| SSD support              | ✅ Yes            | ✅ Yes              | ❌ No        |
| HDD support              | ✅ Yes            | ⚠️ Partial         | ✅ Yes       |
| Security level           | 🔒🔒🔒 Very High | 🔒🔒 High          | 🔒 Moderate |
| Destroys partition table | ✅ Yes            | ✅ Yes              | ❌ No        |
| Reversible               | ❌ No             | ❌ No               | ❌ No        |

---

## ✅ **In Short**

> 🧩 **`hdparm`** is a **low-level disk configuration and testing utility** that can read drive info, tune parameters, test performance, and even **securely erase** drives at the firmware level.

---

### 💡 **Quick Reference**

| Task                  | Command                                            |
| --------------------- | -------------------------------------------------- |
| Drive info            | `sudo hdparm -I /dev/sdX`                          |
| Test disk speed       | `sudo hdparm -Tt /dev/sdX`                         |
| Check power mode      | `sudo hdparm -C /dev/sdX`                          |
| Put in standby        | `sudo hdparm -y /dev/sdX`                          |
| Enable write cache    | `sudo hdparm -W1 /dev/sdX`                         |
| Secure erase          | `sudo hdparm --security-erase p /dev/sdX`          |
| Enhanced secure erase | `sudo hdparm --security-erase-enhanced p /dev/sdX` |


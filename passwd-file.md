# **/etc/passwd File in Linux – Complete Guide**

The **`/etc/passwd` file** is a critical system file in Linux and Unix-like systems. It **stores information about every user account** on the system. Understanding it is essential for system administration, security, and troubleshooting.

---

## **1. Purpose of `/etc/passwd`**

* Provides **essential information for user login**.
* Maps **usernames to UIDs** (User IDs).
* Stores basic user details such as:

  * UID (User ID)
  * GID (Primary Group ID)
  * Home directory
  * Login shell
  * Additional user information
* **Read permissions** are open to all users; **write permissions** are restricted to root.

---

## **2. File Format**

Each line in `/etc/passwd` represents **one user account**.

**Syntax (7 fields, colon-separated):**

```
username:password:UID:GID:GECOS:home_directory:shell
```

| Field               | Description                                                                             |
| ------------------- | --------------------------------------------------------------------------------------- |
| **username**        | Login name, 1–32 characters, unique, case-sensitive                                     |
| **password**        | Placeholder `x` (encrypted password stored in `/etc/shadow`)                            |
| **UID**             | User ID, unique integer. `0` reserved for root; 1–99 system users; ≥1000 normal users   |
| **GID**             | Primary group ID, refers to `/etc/group`                                                |
| **GECOS/User Info** | Full name, contact info, etc. (optional)                                                |
| **Home Directory**  | Absolute path where the user starts after login                                         |
| **Shell**           | Default shell or command, e.g., `/bin/bash`. Can be `/sbin/nologin` for system accounts |

**Example:**

```
sara:x:1000:1000:Sara Z:/home/sara:/bin/bash
```

---

## **3. Key Points About Each Field**

### **Username**

* Must be unique.
* Cannot contain `:` or newline.
* Lowercase is traditional for simplicity.
* Managed via `useradd` or `usermod`.

### **Password**

* `x` or `*` → indicates password is stored in `/etc/shadow`.
* **/etc/shadow**:

  * Stores hashed passwords using algorithms like MD5, SHA-256, or SHA-512.
  * Includes **salting** for added security.

### **UID (User ID)**

* Root → UID `0`.
* System users → UID 1–99.
* Regular users → UID ≥ 1000.
* UID is used internally for file ownership and permissions.

### **GID (Group ID)**

* Primary group for the user.
* Group info stored in `/etc/group`.
* Users can belong to multiple secondary groups.

### **GECOS (User Info)**

* Optional descriptive info (full name, phone, email).
* Can be edited with `chfn` or `usermod -c`.

### **Home Directory**

* Default directory at login.
* If missing → defaults to `/`.

### **Shell**

* Default command shell at login.
* Can be `/bin/bash`, `/bin/sh`, or `/sbin/nologin`.
* `/sbin/nologin` or `/bin/false` → prevents login for system/service accounts.

---

## **4. Common `/etc/passwd` Examples**

```
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/sbin/nologin
ftp:x:21:21:FTP User:/var/ftp:/sbin/nologin
guest:x:405:100:Guest User:/home/guest:/bin/bash
```

---

## **5. File Permissions**

* Typical permissions:

```
-rw-r--r-- 1 root root 2659 Oct 10 10:00 /etc/passwd
```

* Explanation:

  * `rw-` → owner (root) can read/write
  * `r--` → group read-only
  * `r--` → others read-only
* **Important:** Write access should only be root to prevent security issues.

**Commands:**

```bash
ls -l /etc/passwd
stat /etc/passwd
```

---

## **6. How to Read `/etc/passwd`**

* **View full file**:

```bash
cat /etc/passwd
```

* **Page by page**:

```bash
less /etc/passwd
more /etc/passwd
```

* **Check first/last lines**:

```bash
head /etc/passwd -n 10
tail /etc/passwd -n 10
```

* **Search for specific users**:

```bash
grep username /etc/passwd
grep -w '^username' /etc/passwd
egrep -w '^(user1|user2|user3)' /etc/passwd
getent passwd username
```

* **Print only usernames**:

```bash
awk -F: '{print $1}' /etc/passwd
```

---

## **7. How to Edit `/etc/passwd`**

**Important:** Only root or sudo users should modify this file. Always create a backup:

```bash
sudo cp /etc/passwd /etc/passwd.bak
```

### **Methods:**

1. **vipw (Safe Editing)**

```bash
sudo vipw
```

* Locks the file against simultaneous edits.
* Uses default editor (usually `vi` or `nano`).

2. **usermod (Command-line Modification)**

```bash
sudo usermod -c "Full Name" username   # Update GECOS
sudo usermod -d /new/home username    # Change home directory
sudo usermod -s /bin/zsh username     # Change shell
sudo usermod -l newname oldname       # Change username
```

3. **Direct editing (not recommended)**

```bash
sudo vim /etc/passwd
sudo nano /etc/passwd
```

* Risky → can break login functionality if incorrect.

---

## **8. `/etc/shadow` File**

* Companion file to `/etc/passwd`.
* Stores **hashed passwords**, password aging info, and account locking info.
* Only **root** can read it:

```bash
ls -l /etc/shadow
```

**Example entry:**

```
sara:$6$abcdefgh$abcdefghijklmno:18715:0:99999:7:::
```

* `$6$` → SHA-512 hash
* Numbers → password age, expiration, etc.

---

## **9. Related Commands**

| Command                            | Purpose                                                       |
| ---------------------------------- | ------------------------------------------------------------- |
| `cat /etc/passwd`                  | Display all user accounts                                     |
| `getent passwd`                    | Display users from `/etc/passwd` (supports network users too) |
| `grep username /etc/passwd`        | Search for a specific user                                    |
| `awk -F: '{print $1}' /etc/passwd` | List all usernames                                            |
| `vipw`                             | Safely edit `/etc/passwd`                                     |
| `usermod`                          | Modify user accounts                                          |
| `useradd`                          | Add new user                                                  |
| `passwd`                           | Set or change password                                        |

---

## **10. Best Practices**

* Never edit `/etc/passwd` manually unless necessary.
* Use `vipw` or `usermod` for safety.
* Keep `/etc/passwd` readable but writable **only by root**.
* Use `/etc/shadow` for password security.
* Regularly review system and user accounts for inactive users.

---

### **11. Summary**

* `/etc/passwd` is **vital for user account management**.
* Stores **username, UID, GID, home directory, shell, and user info**.
* **Passwords are not stored here anymore**; use `/etc/shadow`.
* Safe viewing → `cat`, `less`, `grep`.
* Safe editing → `vipw` or `usermod`.

Mastering `/etc/passwd` is essential for **Linux system administration**, **security**, and **user management**.


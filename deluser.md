# **`deluser` Command in Linux**

**Last Updated:** October 2025

The **`deluser`** command is a **high-level utility** to remove a user account. It is **Debian/Ubuntu specific** and is essentially a more user-friendly alternative to `userdel`. It can remove the user, their home directory, and optionally their group.

---

## 🧠 **Purpose**

* Delete a user account safely.
* Optionally remove the home directory and user’s mail spool.
* Optionally remove the user’s primary group if it exists.
* Simplifies deletion compared to `userdel`.

---

## 🧩 **Syntax**

```bash
sudo deluser [OPTIONS] USERNAME
```

### **Options**

| Option               | Description                                 |
| -------------------- | ------------------------------------------- |
| `--remove-home`      | Remove user’s home directory and mail spool |
| `--remove-all-files` | Remove all files owned by the user          |
| `--backup`           | Backup files before deletion                |
| `--backup-to DIR`    | Specify directory for backup                |
| `--group`            | Delete a group instead of a user            |
| `--help`             | Show help message                           |
| `--version`          | Show version info                           |

---

## 🧪 **Practical Examples**

### 🟢 **1. Delete a user (without removing home)**

```bash
sudo deluser mahin
```

* Removes user `mahin` from the system.
* Home directory and files remain.

---

### 🟢 **2. Delete a user and remove home directory**

```bash
sudo deluser --remove-home mahin
```

* Deletes user `mahin` and their home directory `/home/mahin`.
* Also removes mail spool.

---

### 🟢 **3. Delete a user and all files owned**

```bash
sudo deluser --remove-all-files mahin
```

* Removes the user and **all files owned by the user** across the system.

---

### 🟢 **4. Delete a group**

```bash
sudo deluser --group developers
```

* Removes the group `developers`.
* Only applicable if the group exists and is not primary for other users.

---

### 🟢 **5. Backup before deletion**

```bash
sudo deluser --backup --backup-to /root/backup mahin
```

* Deletes the user `mahin` but backs up their files to `/root/backup`.

---

## 📁 **Related Files**

| File             | Purpose                                |
| ---------------- | -------------------------------------- |
| `/etc/passwd`    | Stores user accounts                   |
| `/etc/group`     | Stores group memberships               |
| `/etc/shadow`    | Stores encrypted passwords             |
| `/home/USERNAME` | User home directory (optional removal) |

---

## ⚠️ **Important Notes**

* `deluser` is **Debian/Ubuntu specific**; on Red Hat/CentOS, use `userdel`.
* Always check for important files before deletion.
* Use `--remove-home` carefully; it permanently deletes data.
* `deluser` will not delete a user currently logged in; log out or use `--force` if necessary (with caution).

---

## ✅ **Quick Comparison: `deluser` vs `userdel`**

| Feature        | `deluser`                 | `userdel`                |
| -------------- | ------------------------- | ------------------------ |
| Type           | High-level, user-friendly | Low-level system command |
| Home Directory | `--remove-home`           | `-r`                     |
| Extra Options  | Backup, remove all files  | Force, remove home       |
| Availability   | Debian/Ubuntu             | All Linux distros        |

---

💡 **Example Workflow**

```bash
# Delete user 'mahin' and remove home directory
sudo deluser --remove-home mahin

# Delete group 'developers'
sudo deluser --group developers
```

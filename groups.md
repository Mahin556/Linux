# 👥 **`groups` Command in Linux**

The **`groups`** command in Linux is used to **display the groups a user belongs to**. It shows both **primary** and **supplementary (secondary)** group memberships.

It’s a simple but essential command for system administrators to manage permissions, user access, and file ownership in multi-user environments.

---

## 🧠 **Purpose**

* Identify which **groups** a user is a member of.
* Verify **group-based permissions**.
* Troubleshoot access or permission issues.
* Confirm **user–group mapping** after modifications.

---

## 🧩 **Syntax**

```bash
groups [OPTION] [USERNAME...]
```

### **Parameters**

| Parameter  | Description                                                                                               |
| ---------- | --------------------------------------------------------------------------------------------------------- |
| `USERNAME` | (Optional) The user whose group memberships are to be displayed. If omitted, the current user is assumed. |

---

## ⚙️ **How It Works**

* Every user in Linux belongs to **one primary group** (defined in `/etc/passwd`) and may also belong to **additional secondary groups** (listed in `/etc/group`).
* The `groups` command reads these details from the system databases and displays them.

---

## 📋 **Default Behavior**

If no username is specified, it shows the groups of the **current logged-in user**.

**Example:**

```bash
$ groups
mahin adm cdrom sudo dip plugdev lpadmin sambashare
```

This means:

* **Primary group:** `mahin`
* **Supplementary groups:** `adm`, `cdrom`, `sudo`, `dip`, `plugdev`, `lpadmin`, `sambashare`

---

## 🧾 **Command Output Explanation**

Output format:

```
username : group1 group2 group3 ...
```

Example:

```bash
$ groups root
root : root adm systemd-journal
```

Here, `root` belongs to three groups — primary: `root`, supplementary: `adm`, `systemd-journal`.

---

## 🔧 **Options**

| Option      | Description                          |
| ----------- | ------------------------------------ |
| `--help`    | Display help message and exit        |
| `--version` | Display version information and exit |

👉 **Note:**
The `groups` command does not have many options — it’s designed for quick, straightforward group listing.

---

## 🧪 **Practical Examples**

### 🟢 **1. Show groups for the current user**

```bash
groups
```

Displays all groups associated with your current login session.

---

### 🟢 **2. Show groups for a specific user**

```bash
groups username
```

Example:

```bash
$ groups john
john : john adm sudo docker
```

Lists all groups that the user `john` belongs to.

---

### 🟢 **3. Display multiple users’ groups**

```bash
groups user1 user2
```

Example:

```bash
$ groups root mahin
root : root adm systemd-journal
mahin : mahin sudo plugdev
```

---

### 🟢 **4. Use `groups` with command substitution**

```bash
echo "User belongs to groups: $(groups)"
```

Displays group info in a formatted string.

---

### 🟢 **5. Check which group a user belongs to before permission changes**

Useful before assigning group-based access to directories:

```bash
groups developer
```

---

## 📁 **Important Configuration Files**

| File           | Purpose                                                             |
| -------------- | ------------------------------------------------------------------- |
| `/etc/passwd`  | Stores user account info including **primary group ID (GID)**       |
| `/etc/group`   | Stores all system groups and their members                          |
| `/etc/gshadow` | Secure version of `/etc/group` containing group passwords (if used) |

---

## 🧱 **Related Commands**

| Command                      | Description                                                       |
| ---------------------------- | ----------------------------------------------------------------- |
| `id`                         | Displays user ID (UID), group ID (GID), and all group memberships |
| `groupadd`                   | Creates a new group                                               |
| `groupdel`                   | Deletes an existing group                                         |
| `groupmod`                   | Modifies a group’s properties                                     |
| `usermod -aG <group> <user>` | Adds a user to a supplementary group                              |
| `getent group`               | Displays detailed group information from the system database      |

---

## ⚙️ **Example: How Groups Affect Permissions**

```bash
$ ls -l file.txt
-rw-r----- 1 mahin devteam 1234 Oct 10 11:00 file.txt
```

* Owner: `mahin`
* Group: `devteam`
* Permissions: `rw- r-- ---`

If another user belongs to the `devteam` group, they can **read** the file.
You can confirm group membership using:

```bash
groups otheruser
```

---

## 🧩 **Example of Files**

**/etc/passwd:**

```
mahin:x:1000:1000:Mahin Raza:/home/mahin:/bin/bash
```

* UID: 1000
* Primary GID: 1000 (links to `/etc/group` entry)

**/etc/group:**

```
sudo:x:27:mahin,root
devteam:x:1001:mahin,john
```

Shows members of the `sudo` and `devteam` groups.

---

## 🧰 **Verifying Group Membership**

| Command                  | Purpose                               | Example             |
| ------------------------ | ------------------------------------- | ------------------- |
| `id username`            | Full user/group details               | `id mahin`          |
| `groups username`        | List only groups                      | `groups mahin`      |
| `getent group groupname` | Check who belongs to a specific group | `getent group sudo` |

---

## ⚠️ **Common Administrative Uses**

* Verify user access for shared directories or devices.
* Troubleshoot permission denied errors.
* Check sudo access:

  ```bash
  groups user | grep sudo
  ```
* Confirm group membership after running `usermod -aG`.

---

## ✅ **Quick Summary**

| Feature              | Description                                     |
| -------------------- | ----------------------------------------------- |
| **Command Name**     | `groups`                                        |
| **Purpose**          | Display user’s primary and supplementary groups |
| **Syntax**           | `groups [username]`                             |
| **Default Behavior** | Shows current user’s groups                     |
| **Main Files Used**  | `/etc/passwd`, `/etc/group`                     |
| **Common Use**       | Permission verification, group management       |
| **Related Commands** | `id`, `getent`, `usermod`, `groupadd`           |


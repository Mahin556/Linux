```bash
apt-get install adduser
yum install adduser
dnf install adduser

adduser --version

adduser -h

adduser username

adduser username --shell /bin/sh

adduser username --conf custom_config.conf

adduser username --home /home/manav/
```

---

# **`adduser` Command in Linux**

**Last Updated:** October 2025

The **`adduser`** command is a **high-level utility** for creating new users in Linux. It is **more user-friendly** than `useradd` because it automatically creates the home directory, sets permissions, and can prompt for additional information.

> Note: `adduser` is often a **Perl script** in Debian/Ubuntu systems, whereas `useradd` is a **low-level binary**. Both achieve similar results, but `adduser` is easier for interactive use.

---

## 🧠 **Purpose**

* Create a new user account.
* Automatically create a **home directory** and set correct permissions.
* Optionally assign a **group, shell, and password**.
* Simplifies user creation compared to `useradd`.

---

## 🧩 **Syntax**

```bash
sudo adduser [options] USERNAME
```

### **Parameters**

| Parameter  | Description                    |
| ---------- | ------------------------------ |
| `USERNAME` | Name of the new user to create |

### **Options**

| Option                | Description                      |
| --------------------- | -------------------------------- |
| `--home DIR`          | Specify custom home directory    |
| `--shell SHELL`       | Set default login shell          |
| `--gecos GECOS`       | Set comment/full name and info   |
| `--disabled-password` | Create user without a password   |
| `--disabled-login`    | Create user without login access |
| `--ingroup GROUP`     | Assign primary group             |
| `--uid UID`           | Specify user ID                  |
| `--no-create-home`    | Do not create home directory     |

> Run `adduser --help` to see all available options.

---

## ⚙️ **How It Works**

1. Creates **user account** in `/etc/passwd` with default or specified UID.
2. Creates **home directory** (usually `/home/USERNAME`) with proper permissions.
3. Assigns **primary group** (usually same as username).
4. Prompts for optional **full name, room number, phone, etc.**
5. Sets the **password** for the user.

---

## 🧪 **Practical Examples**

### 🟢 **1. Create a simple user**

```bash
sudo adduser mahin
```

**Interactive prompts:**

```
Adding user `mahin' ...
Adding new group `mahin' (1001) ...
Adding new user `mahin' (1001) with group `mahin' ...
Creating home directory `/home/mahin' ...
Copying files from `/etc/skel' ...
Enter new UNIX password: ****
Retype new UNIX password: ****
Full Name []: Mahin Raza
Room Number []: 101
Work Phone []: 1234567890
Home Phone []: 9876543210
Other []: 
Is the information correct? [Y/n] Y
```

---

### 🟢 **2. Create user without password**

```bash
sudo adduser --disabled-password mahin
```

* User will be created but **cannot log in** until a password is set.

---

### 🟢 **3. Create user with custom home directory**

```bash
sudo adduser --home /opt/mahin mahin
```

* Home directory will be `/opt/mahin` instead of `/home/mahin`.

---

### 🟢 **4. Create user with specific shell**

```bash
sudo adduser --shell /bin/zsh mahin
```

* Sets the login shell to Zsh.

---

### 🟢 **5. Create user and assign primary group**

```bash
sudo adduser --ingroup developers mahin
```

* User `mahin` will belong to the `developers` group instead of a default private group.

---

### 🟢 **6. Non-interactive creation (useful in scripts)**

```bash
sudo adduser --disabled-password --gecos "Mahin Raza,101,1234567890,9876543210" mahin
```

* Creates the user and sets GECOS fields without prompting interactively.

---

## 📁 **Related Files**

| File          | Purpose                                                    |
| ------------- | ---------------------------------------------------------- |
| `/etc/passwd` | Stores user account info (username, UID, GID, home, shell) |
| `/etc/shadow` | Stores encrypted passwords                                 |
| `/etc/group`  | Stores group memberships                                   |
| `/etc/skel`   | Default files copied to new user home directory            |

---

## 🧱 **Related Commands**

| Command   | Purpose                                                     |
| --------- | ----------------------------------------------------------- |
| `useradd` | Low-level user creation utility                             |
| `usermod` | Modify existing user                                        |
| `passwd`  | Set or change user password                                 |
| `groups`  | Display user groups                                         |
| `deluser` | Remove user account (Debian/Ubuntu equivalent of `userdel`) |

---

## ✅ **Key Differences: `adduser` vs `useradd`**

| Feature        | `adduser`                      | `useradd`             |
| -------------- | ------------------------------ | --------------------- |
| Type           | High-level, interactive script | Low-level binary      |
| Prompts        | Yes (password, GECOS, etc.)    | No (requires options) |
| Home Directory | Created by default             | Must use `-m` option  |
| User-Friendly  | Very                           | Less                  |

---

## ⚠️ **Notes**

* Available by default on **Debian/Ubuntu**.
* On **RHEL/CentOS**, `adduser` is often a symbolic link to `useradd`.
* Always run as **root** or with `sudo`.



- https://www.geeksforgeeks.org/linux-unix/adduser-command-in-linux-with-examples/
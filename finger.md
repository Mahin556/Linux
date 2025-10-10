# 🧑‍💻 **`finger` Command in Linux**

**Last Updated:** October 2025

The **`finger`** command in Linux is used to **display information about system users**. It shows details such as the user’s login name, real name, home directory, shell, login time, idle time, and more.

It is often used by system administrators to monitor **who is logged in** and to get detailed information about users.

---

## 🧠 **Purpose**

* View information about users (logged-in or not).
* Check when a user last logged in.
* Display contact details and home directory info.
* Identify idle users or active sessions.

---

## 🧩 **Syntax**

```bash
finger [options] [user ...]
```

### **Parameters**

| Parameter | Description                              |
| --------- | ---------------------------------------- |
| `user`    | Displays information for a specific user |
| *none*    | Lists all users currently logged in      |

---

## ⚙️ **How It Works**

The `finger` command gathers information from:

* `/etc/passwd` → Basic user info (login name, home directory, shell, etc.)
* `/var/run/utmp` → Info about current logins
* `.plan` and `.project` files in a user’s home directory → Optional personal details

---

## 📋 **Default Output**

Example:

```bash
$ finger
Login     Name       Tty      Idle  Login Time   Office     Office Phone
mahin     Mahin Raza pts/0    02:03 Oct 10 10:15 (192.168.1.5)
```

Or for a specific user:

```bash
$ finger mahin
Login: mahin                     Name: Mahin Raza
Directory: /home/mahin           Shell: /bin/bash
On since Fri Oct 10 10:15 (IST) on pts/0 from 192.168.1.5
No mail.
No Plan.
```

---

## 🧾 **Information Displayed**

| Field              | Description                                      |
| ------------------ | ------------------------------------------------ |
| **Login**          | Username of the user                             |
| **Name**           | Full (real) name of the user                     |
| **TTY**            | Terminal line (e.g., pts/0, tty1)                |
| **Idle**           | Time since the user last interacted              |
| **Login Time**     | When the user logged in                          |
| **Office / Phone** | Optional info from `/etc/passwd`                 |
| **Directory**      | User’s home directory                            |
| **Shell**          | Default shell program                            |
| **Mail**           | Shows whether the user has unread mail           |
| **Plan / Project** | Custom info from `~/.plan` or `~/.project` files |

---

## 🔧 **Options (Flags)**

| Option | Description                                                               |
| ------ | ------------------------------------------------------------------------- |
| `-l`   | Long format — displays detailed info (default if username specified)      |
| `-m`   | Exact username match (useful for avoiding partial matches)                |
| `-p`   | Omit printing `.plan` and `.project` files                                |
| `-s`   | Short format (summary) — default when no username specified               |
| `-f`   | Suppress the column headers in short format                               |
| `-h`   | Omit the home directory and shell information                             |
| `-w`   | Wide format — show long login names and hostnames                         |
| `-i`   | Shorter info listing (similar to short format, but without extra details) |

---

## 🧪 **Practical Examples**

### 🟢 **1. List all currently logged-in users**

```bash
finger
```

Displays a summary table of all users logged in.

---

### 🟢 **2. Display detailed information about a specific user**

```bash
finger mahin
```

Shows the full user profile, including home directory, shell, and login details.

---

### 🟢 **3. Show exact username match**

```bash
finger -m mahin
```

Displays details only if the username exactly matches `mahin`.

---

### 🟢 **4. Display all users without `.plan` and `.project` info**

```bash
finger -p
```

Skips personal `.plan` and `.project` file outputs.

---

### 🟢 **5. Display users in short format**

```bash
finger -s
```

Shows a concise summary of all logged-in users.

---

### 🟢 **6. Hide column headers**

```bash
finger -f
```

Prints the user list without headers — useful for scripting.

---

### 🟢 **7. Wide output for better readability**

```bash
finger -w
```

Shows extended names and hostnames without truncation.

---

### 🟢 **8. Display details of multiple users**

```bash
finger root mahin john
```

Shows detailed info for the listed users.

---

### 🟢 **9. Display a user’s `.plan` and `.project` files**

If a user has these files in their home directory:

```bash
$ cat ~/.plan
Currently working on DevOps automation.

$ cat ~/.project
Linux Administration Project
```

Then running:

```bash
finger mahin
```

will display:

```
Plan:
Currently working on DevOps automation.
Project:
Linux Administration Project
```

---

## 📁 **Configuration and Data Sources**

| File                    | Description                                             |
| ----------------------- | ------------------------------------------------------- |
| `/etc/passwd`           | User details (name, home directory, shell, etc.)        |
| `/var/run/utmp`         | Tracks currently logged-in users                        |
| `/var/log/wtmp`         | Tracks past logins (used by `last`)                     |
| `~/.plan`, `~/.project` | Optional text files for user info displayed by `finger` |

---

## ⚙️ **Installing `finger` (if not available)**

On some systems, `finger` may not be preinstalled.

**Ubuntu / Debian:**

```bash
sudo apt install finger
```

**RHEL / CentOS / Fedora:**

```bash
sudo dnf install finger
```

**Arch Linux:**

```bash
sudo pacman -S finger
```

---

## 🔐 **Security Note**

* The `finger` service can expose sensitive user info (like login times, home directories, emails).
* Many administrators **disable the `finger` daemon** for security reasons.
* For local usage, `finger` is safe and useful for admin monitoring.

---

## 🧱 **Related Commands**

| Command | Description                             |
| ------- | --------------------------------------- |
| `who`   | Displays currently logged-in users      |
| `w`     | Shows users and their activities        |
| `users` | Displays usernames only                 |
| `last`  | Shows login/logout history              |
| `id`    | Displays UID, GID, and groups of a user |

---

## ✅ **Quick Summary**

| Feature                  | Description                                     |
| ------------------------ | ----------------------------------------------- |
| **Command Name**         | `finger`                                        |
| **Purpose**              | Displays detailed user information              |
| **Default Source Files** | `/etc/passwd`, `/var/run/utmp`                  |
| **Useful For**           | Viewing login details, user info, idle time     |
| **Similar Commands**     | `who`, `w`, `users`, `last`                     |
| **Security Note**        | Can reveal private data if exposed over network |

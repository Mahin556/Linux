```bash
ubuntu:~$ last --help

Usage:
 last [options] [<username>...] [<tty>...]

Show a listing of last logged in users.

Options:
 -<number>            how many lines to show
 -a, --hostlast       display hostnames in the last column
 -d, --dns            translate the IP number back into a hostname
 -f, --file <file>    use a specific file instead of /var/log/wtmp
 -F, --fulltimes      print full login and logout times and dates
 -i, --ip             display IP numbers in numbers-and-dots notation
 -n, --limit <number> how many lines to show
 -R, --nohostname     don't display the hostname field
 -s, --since <time>   display the lines since the specified time
 -t, --until <time>   display the lines until the specified time
 -p, --present <time> display who were present at the specified time
 -w, --fullnames      display full user and domain names
 -x, --system         display system shutdown entries and run level changes
     --time-format <format>  show timestamps in the specified <format>:
                               notime|short|full|iso

 -h, --help           display this help
 -V, --version        display version

For more details see last(1).
```

# 🧾 **`last` Command in Linux**

**Last Updated:** October 2025

The **`last`** command is used to **display a list of all logins and logouts** that have occurred on a Linux system. It reads data from the `/var/log/wtmp` file, which records every user login, logout, system reboot, and shutdown event.

---

## 🧠 **Purpose**

* View **login history** of users.
* Check **when and where** a user logged in from.
* See **system boot and shutdown times.**
* Audit user activity and identify **unauthorized access.**

---

## 🧩 **Syntax**

```bash
last [options] [username...] [tty...]
```

### **Parameters**

| Parameter  | Description                          |
| ---------- | ------------------------------------ |
| `username` | Show records of a specific user      |
| `tty`      | Show records for a specific terminal |
| *none*     | Show all login/logout events         |

---

## ⚙️ **How It Works**

`last` reads data from `/var/log/wtmp` (and optionally `/var/log/btmp` with `lastb`), which records each login and logout entry, including system reboots and shutdowns.

---

## 📋 **Output Explanation**

Example:

```bash
$ last
mahin   pts/0        192.168.1.5     Fri Oct 10 10:21   still logged in
root    pts/1        192.168.1.10    Fri Oct 10 09:15 - 10:00  (00:45)
reboot  system boot  5.15.0-78-gene  Fri Oct 10 09:00   still running
```

| Column       | Description                            |
| ------------ | -------------------------------------- |
| **Username** | The name of the user who logged in     |
| **TTY**      | Terminal line used (e.g., pts/0, tty1) |
| **FROM**     | Remote hostname or IP address          |
| **LOGIN@**   | Login date and time                    |
| **LOGOUT**   | Logout time or “still logged in”       |
| **DURATION** | Total time of the session              |

---

## 🔧 **Commonly Used Options**

| Option                       | Description                                           |
| ---------------------------- | ----------------------------------------------------- |
| `-a`                         | Display hostname in the last column                   |
| `-d`                         | Translate the IP address into hostname                |
| `-f <file>`                  | Use an alternate wtmp file instead of `/var/log/wtmp` |
| `-n <number>` or `-<number>` | Show only the last *n* lines                          |
| `-p <YYYY-MM-DD>`            | Show users logged in at a specific date/time          |
| `-R`                         | Do not display the hostname field                     |
| `-t <YYYY-MM-DDHH:MM>`       | Show entries until a specified time                   |
| `-w`                         | Display the full user and domain names                |
| `-x`                         | Show system shutdown and run-level changes too        |

---

## 🧪 **Practical Examples**

### 🟢 **1. Show all login history**

```bash
last
```

Lists all user login and logout activities from `/var/log/wtmp`.

---

### 🟢 **2. Show login history of a specific user**

```bash
last mahin
```

Displays only the login sessions of the user `mahin`.

---

### 🟢 **3. Show last 5 logins**

```bash
last -n 5
```

or

```bash
last -5
```

Displays only the 5 most recent entries.

---

### 🟢 **4. Show reboot and shutdown history**

```bash
last -x
```

Includes system boot, shutdown, and run-level change records.

---

### 🟢 **5. Display logins since a specific date**

```bash
last -p 2025-10-01
```

Shows users who were logged in since **October 1, 2025**.

---

### 🟢 **6. Show users logged in before a specific date/time**

```bash
last -t 202510100900
```

Displays logins up to **Oct 10, 2025, 09:00**.

---

### 🟢 **7. Show last logins on a specific terminal**

```bash
last tty1
```

Displays login activity for the terminal **tty1**.

---

### 🟢 **8. Use a custom log file**

```bash
last -f /var/log/wtmp.1
```

Reads login records from an older or custom `wtmp` file (often rotated logs).

---

### 🟢 **9. Display hostnames instead of IPs**

```bash
last -d
```

Translates IP addresses to their hostnames (if resolvable).

---

### 🟢 **10. Show hostname in last column**

```bash
last -a
```

Adds the hostname as the last column for clarity.

---

## 📁 **Log Files Used**

| File                                    | Purpose                                          |
| --------------------------------------- | ------------------------------------------------ |
| `/var/log/wtmp`                         | Stores successful login/logout data              |
| `/var/log/btmp`                         | Stores failed login attempts (used with `lastb`) |
| `/var/log/wtmp.1`, `/var/log/wtmp.2.gz` | Archived login logs (older data)                 |

---

## 🧱 **Related Commands**

| Command   | Description                                         |
| --------- | --------------------------------------------------- |
| `who`     | Shows currently logged-in users                     |
| `users`   | Displays usernames of currently logged-in users     |
| `w`       | Displays logged-in users and their activities       |
| `lastb`   | Shows failed login attempts (reads `/var/log/btmp`) |
| `lastlog` | Shows the most recent login of all users            |

---

## ⚠️ **Permissions**

* Normal users can view `/var/log/wtmp`.
* For rotated or archived logs, **root privileges** may be required.

---

## ✅ **Quick Summary**

| Feature              | Description                                              |
| -------------------- | -------------------------------------------------------- |
| **Command Name**     | `last`                                                   |
| **Purpose**          | Display login/logout history                             |
| **Default File**     | `/var/log/wtmp`                                          |
| **Common Uses**      | Audit login activity, check uptime, track system reboots |
| **Similar Commands** | `who`, `w`, `lastlog`, `lastb`                           |

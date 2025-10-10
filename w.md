# 🧩 **`w` Command in Linux**

The `w` command is used to **show information about users currently logged into the system** and their running processes.
It combines the output of several tools like `who`, `uptime`, and `ps`.

---

## ⚙️ **Basic Syntax**

```bash
w [options] [user]
```

* **`options`** – optional flags to modify output
* **`user`** – (optional) specify a username to show info for that user only

---

## 🧾 **Output Explanation**

Example:

```bash
$ w
 10:10:25 up 2 days,  3:12,  2 users,  load average: 0.01, 0.05, 0.07
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0    192.168.1.10     08:30    0.00s  0.05s  0.01s bash
mahesh   pts/1    :0               09:15    1:20m  0.10s  0.05s vim test.py
```

### Header Breakdown:

* **10:10:25** → current system time
* **up 2 days, 3:12** → system uptime
* **2 users** → number of logged-in users
* **load average: 0.01, 0.05, 0.07** → system load averages (1, 5, 15 minutes)

### Column Details:

| Column     | Description                                                   |
| ---------- | ------------------------------------------------------------- |
| **USER**   | Username of logged-in user                                    |
| **TTY**    | Terminal (pts/X or ttyX)                                      |
| **FROM**   | Remote host or IP (or `:0` for local)                         |
| **LOGIN@** | Time the user logged in                                       |
| **IDLE**   | How long the terminal has been idle                           |
| **JCPU**   | Total CPU time used by all processes attached to the terminal |
| **PCPU**   | CPU time used by the current process (`WHAT` column)          |
| **WHAT**   | Current command the user is running                           |

---

## 🧩 **Common Options**

| Option        | Description                                                             |
| ------------- | ----------------------------------------------------------------------- |
| **-h**        | Suppress the header (uptime/load info)                                  |
| **-u**        | Ignore the username while figuring out the current process and CPU time |
| **-s**        | Short format (less detailed)                                            |
| **-f**        | Display from (remote host) field (default, opposite of `-f`)            |
| **--help**    | Show help message                                                       |
| **--version** | Show version info                                                       |


```bash
ubuntu:~$ w --help

Usage:
 w [options] [user]

Options:
 -h, --no-header     do not print header
 -u, --no-current    ignore current process username
 -s, --short         short format
 -f, --from          show remote hostname field
 -o, --old-style     old style output
 -i, --ip-addr       display IP address instead of hostname (if possible)
 -p, --pids          show the PID(s) of processes in WHAT

     --help     display this help and exit
 -V, --version  output version information and exit

For more details see w(1).
```

---

## 🧠 **Detailed Examples**

### 1️⃣ Show all logged-in users

```bash
w
```

### 2️⃣ Show info for a specific user

```bash
w root
```

### 3️⃣ Show without header

```bash
w -h
```

### 4️⃣ Short output format

```bash
w -s
```

### 5️⃣ Hide remote host field

```bash
w -f
```

### 6️⃣ Combine options

```bash
w -hus
```

### 7️⃣ Check who is idle the longest

```bash
w -h | sort -k5
```

---

## 📂 **File Used**

The `w` command gathers data from:

```
/var/run/utmp
/proc
```

* `/var/run/utmp` → maintains information about current logins
* `/proc` → for process and system load data

---

## 🔐 **Permissions**

* Any user can run `w` to see currently logged-in users.
* Some fields (like process info) might be restricted if process visibility is limited by security policies (`hidepid` in `/proc`).

---

## 🧰 **Related Commands**

| Command        | Description                             |
| -------------- | --------------------------------------- |
| **who**        | Shows who is logged in (simpler output) |
| **users**      | Shows only usernames of logged-in users |
| **finger**     | Displays detailed info about users      |
| **uptime**     | Shows system uptime and load averages   |
| **ps**         | Shows running processes                 |
| **top / htop** | Live system process and resource usage  |

---

## 💡 **Tips**

* Use `watch w` to continuously monitor user activity.
* Combine with `grep` to filter:

  ```bash
  w | grep "ssh"
  ```
* Use `w -h | awk '{print $1}' | sort | uniq` to list unique logged-in users only.

---

## 🧾 **Exit Status**

* Returns **0** on success
* Non-zero on error (e.g., failure reading `utmp`)

---

### ✅ **In Short**

> The `w` command provides a **snapshot of logged-in users**, **their activities**, **system uptime**, and **load averages** — a handy tool for quick monitoring.



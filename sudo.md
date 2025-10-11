# 🛡️ **`sudo` Command in Linux**


**`sudo`** (superuser do) command allows a user to execute commands as the superuser (root) or another user, as specified in the `/etc/sudoers` file. 
It is the **preferred way to perform administrative tasks** without directly logging in as root.
It is all controll through /etc/sudoers file

---

## 🧠 **Purpose**
* Run commands with **elevated privileges** temporarily.
* Allow users to perform administrative tasks without sharing the root password.
* Provide **fine-grained control** over who can execute which commands.
* Log all administrative actions for auditing.

---

## 🧩 **Syntax**

```bash
sudo [OPTION] COMMAND
sudo -u USER COMMAND
```

### **Parameters**

| Parameter | Description                                          |
| --------- | ---------------------------------------------------- |
| `COMMAND` | Command to execute with elevated privileges          |
| `-u USER` | Run the command as a specific user (default is root) |
| `OPTION`  | Options like `-l`, `-v`, `-k`, etc.                  |

---

## 🔧 **Common Options**

| Option      | Description                                                     |
| ----------- | --------------------------------------------------------------- |
| `-u USER`   | Run command as a specific user                                  |
| `-l`        | List allowed (or forbidden) commands for the user               |
| `-v`        | Validate user credentials (extend timeout)                      |
| `-k`        | Invalidate cached credentials (force password prompt next time) |
| `-b`        | Run command in the background                                   |
| `--help`    | Show help                                                       |
| `--version` | Show version                                                    |

---

## ⚙️ **How It Works**

* When a user runs `sudo`, they are prompted for **their own password**, not the root password.
* The command is executed with the privileges of **root** (or another specified user).
* The user’s permissions and allowed commands are defined in `/etc/sudoers` (edited with `visudo`).
* A **timestamp** prevents repeated password prompts for a configurable period (usually 5–15 minutes).

---

## 🧪 **Practical Examples**

### 🟢 **1. Run a command as root**

```bash
sudo apt update
```

* Executes `apt update` with root privileges.

---

### 🟢 **2. Run command as another user**

```bash
sudo -u john whoami
```

* Executes `whoami` as user `john`. Output: `john`.

---

### 🟢 **3. List allowed commands**

```bash
sudo -l
```

* Shows the commands the current user is allowed or forbidden to run with `sudo`.

---

### 🟢 **4. Validate credentials without running a command**

```bash
sudo -v
```

* Extends the sudo session timeout without executing a command.

---

### 🟢 **5. Force password prompt**

```bash
sudo -k apt update
```

* Invalidates the cached timestamp, forcing a password prompt next time.

---

### 🟢 **6. Run command in the background**

```bash
sudo -b apt upgrade
```

* Executes the command in the background as root.


### To run the previous command with sudo in a Bash-based shell:
```bash
sudo !!
```

### # Refresh, revalidate, and list privileges 
```bash
sudo -k && sudo -v && sudo -l
```

### Check Logs
```bash
# Debian/Ubuntu
sudo grep -i sudo /var/log/auth.log | tail -n 20

# RHEL/CentOS/Fedora
sudo grep -i sudo /var/log/secure | tail -n 20
```



---

## 📁 **Configuration File**

| File              | Purpose                                                          |
| ----------------- | ---------------------------------------------------------------- |
| `/etc/sudoers`    | Defines users, groups, and commands allowed to execute with sudo |
| `/etc/sudoers.d/` | Directory for additional sudo configuration files                |

> Always edit `/etc/sudoers` with `visudo` to prevent syntax errors.

---

## 📌 **Differences: `sudo` vs `su`**

| Feature       | `sudo`                                      | `su`                                        |
| ------------- | ------------------------------------------- | ------------------------------------------- |
| Privileges    | Runs single command as root or another user | Switches session to another user            |
| Password      | User’s own password                         | Target user’s password                      |
| Logging       | Logs all commands to syslog                 | Not logged by default                       |
| Security      | Fine-grained access control                 | Full root access once switched              |
| Best Practice | Preferred for administrative tasks          | Use mainly for full root session or testing |

---

## ⚠️ **Security Notes**

* Limit `sudo` access only to trusted users.
* Always use `sudo` instead of logging in directly as root.
* Misconfigured `/etc/sudoers` can grant **full root access**, creating security risks.
* Never use `sudo` with untrusted scripts or commands.

---

## ✅ **Quick Summary**

| Feature             | Description                                           |
| ------------------- | ----------------------------------------------------- |
| **Command Name**    | `sudo`                                                |
| **Purpose**         | Execute commands with elevated privileges             |
| **Default User**    | root                                                  |
| **Password Prompt** | User’s own password                                   |
| **Key Options**     | `-u`, `-l`, `-v`, `-k`, `-b`                          |
| **Configuration**   | `/etc/sudoers`, `/etc/sudoers.d/`                     |
| **Use Case**        | Administrative tasks, system updates, user management |

---

💡 **Example Workflow**

```bash
$ sudo apt update
[sudo] password for mahin: ****
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
...
$ sudo -u john whoami
john
```

* `mahin` runs an update as root, then executes a command as user `john`.

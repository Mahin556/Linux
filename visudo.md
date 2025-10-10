# 🔐 **`visudo` Command in Linux**

**Last Updated:** October 2025

The **`visudo`** command is a safe utility for **editing the `/etc/sudoers` file**, which controls **sudo privileges** for users and groups on a Linux system. Unlike directly editing `/etc/sudoers`, `visudo` performs **syntax checks** to prevent mistakes that could lock out administrative access.

---

## 🧠 **Purpose**

* Safely edit `/etc/sudoers` file.
* Prevent syntax errors that could break sudo functionality.
* Enable adding, modifying, or removing **sudo privileges** for users or groups.
* Allow configuring **timeout, logging, and command restrictions** for sudo users.

---

## 🧩 **Syntax**

```bash
sudo visudo [OPTIONS]
```

### **Common Options**

| Option      | Description                                               |
| ----------- | --------------------------------------------------------- |
| `-f FILE`   | Edit a custom sudoers file instead of `/etc/sudoers`      |
| `-c`        | Check the syntax of the sudoers file and exit             |
| `-q`        | Enable quiet mode (suppress non-error messages)           |
| `-s`        | Edit sudoers in “strict mode” (perform strict validation) |
| `--help`    | Display help message                                      |
| `--version` | Display version info                                      |

> By default, `visudo` uses the editor specified by the `EDITOR` or `VISUAL` environment variable. Default is usually `vi`.

---

## ⚙️ **How It Works**

1. Opens `/etc/sudoers` in a safe editor.
2. Locks the file to prevent multiple simultaneous edits.
3. On saving, performs **syntax validation**.
4. Rejects invalid edits and warns the user to correct them.
5. Only writes changes if the syntax is correct.

---

## 🔧 **Practical Use Cases**

### 🟢 **1. Add a user to sudoers**

```bash
sudo visudo
```

Add the line at the end:

```
mahin ALL=(ALL:ALL) ALL
```

* Gives user `mahin` full sudo privileges on all hosts.
* Format: `USER HOST=(RUNAS) COMMANDS`.

---

### 🟢 **2. Add a group to sudoers**

```bash
%sudo ALL=(ALL:ALL) ALL
```

* `%` prefix indicates a **group**.
* Members of group `sudo` can run commands as root.

---

### 🟢 **3. Allow passwordless sudo**

```bash
mahin ALL=(ALL) NOPASSWD:ALL
```

* User `mahin` can run all sudo commands **without entering a password**.
* Useful for automated scripts or CI/CD environments.

---

### 🟢 **4. Restrict sudo to specific commands**

```bash
mahin ALL=(ALL) /usr/bin/apt,/usr/bin/systemctl
```

* User can only execute `apt` and `systemctl` with sudo.
* Prevents root-level access to all other commands.

---

### 🟢 **5. Editing a custom sudoers file**

```bash
sudo visudo -f /etc/sudoers.d/mahin
```

* Create per-user sudoers file in `/etc/sudoers.d/` (preferred over editing main file).
* Keeps main sudoers clean and easier to manage.

---

### 🟢 **6. Check syntax without editing**

```bash
sudo visudo -c
```

* Checks `/etc/sudoers` for syntax errors and reports issues.
* Useful after manual edits or for automated checks.

---

### 🟢 **7. Set default editor**

```bash
sudo EDITOR=nano visudo
```

* Opens sudoers file with `nano` instead of `vi`.
* Can also use `VISUAL` environment variable.

---

### 🟢 **8. Grant sudo privileges to a user for a specific host**

```bash
mahin server1=(ALL) ALL
```

* User `mahin` can use sudo **only on host `server1`**.
* Useful in multi-server environments.

---

## 📁 **Best Practices**

1. **Always use `visudo`** — never edit `/etc/sudoers` directly.
2. Use `/etc/sudoers.d/` for **per-user or per-group configuration**.
3. Use **`NOPASSWD`** sparingly — only for trusted automation scripts.
4. Validate syntax with `sudo visudo -c` before deploying changes.
5. Avoid giving unrestricted root access unless necessary.

---

## ⚠️ **Common Mistakes to Avoid**

* Editing `/etc/sudoers` with regular text editor → may corrupt file.
* Forgetting the `%` for groups.
* Improper syntax in command restrictions.
* Leaving NOPASSWD for untrusted users → security risk.

---

## ✅ **Quick Summary Table**

| Feature           | Description                                                    |
| ----------------- | -------------------------------------------------------------- |
| **Command Name**  | `visudo`                                                       |
| **Purpose**       | Safely edit `/etc/sudoers` file                                |
| **Default File**  | `/etc/sudoers`                                                 |
| **Custom File**   | `-f /etc/sudoers.d/filename`                                   |
| **Syntax Check**  | `-c`                                                           |
| **Key Use Cases** | Add user/group, restrict commands, allow passwordless sudo     |
| **Best Practice** | Always use `visudo`, prefer `/etc/sudoers.d/` for custom rules |

---

💡 **Example Workflow**

```bash
# Open sudoers file safely
sudo visudo

# Add user mahin to sudoers with full privileges
mahin ALL=(ALL:ALL) ALL

# Save and exit (in vi: ESC → :wq)

# Check syntax without editing
sudo visudo -c
```

# 🔑 **`su` Command in Linux**

**Last Updated:** October 2025

The **`su`** (substitute user or switch user) command allows you to **switch from the current user account to another user account** in Linux. It’s commonly used to gain **root privileges** or to operate as another user without logging out.

---

## 🧠 **Purpose**

* Switch to another user account temporarily.
* Execute commands as a different user.
* Gain administrative privileges by switching to the `root` account.
* Useful in multi-user environments for testing or management.

---

## 🧩 **Syntax**

```bash
su [OPTION] [USER]
```

### **Parameters**

| Parameter | Description                             |
| --------- | --------------------------------------- |
| `USER`    | Target user account (default is `root`) |
| `OPTION`  | Command options like `-l` or `-c`       |

---

## ⚙️ **How It Works**

* By default, `su` switches to **root** if no user is specified.
* It requires the **password of the target user**, not the current user.
* The command **does not start a login shell** unless specified with `-l`.

---

## 🔧 **Common Options**

| Option         | Description                                                               |
| -------------- | ------------------------------------------------------------------------- |
| `-` or `-l`    | Start a **login shell** (resets environment to target user’s environment) |
| `-c "COMMAND"` | Execute a **single command** as the target user                           |
| `-s SHELL`     | Use a specific shell instead of the default                               |
| `--help`       | Show help message                                                         |
| `--version`    | Show version info                                                         |

---

## 🧪 **Practical Examples**

### 🟢 **1. Switch to root**

```bash
su
```

* Prompts for **root password**.
* Changes to root user until `exit` is typed.

---

### 🟢 **2. Switch to a specific user**

```bash
su john
```

* Prompts for `john`’s password.
* Changes session to `john`.

---

### 🟢 **3. Start a login shell**

```bash
su - john
```

or

```bash
su -l john
```

* Loads the target user’s **environment variables**, including `PATH`, `HOME`, and shell startup files.

---

### 🟢 **4. Run a single command as another user**

```bash
su -c "ls /home/john" john
```

* Executes the command `ls /home/john` as `john` and returns to the current user.

---

### 🟢 **5. Switch to root with login shell**

```bash
su -
```

* Equivalent to logging in directly as root.
* Useful when performing administrative tasks.

---

### 🟢 **6. Using a specific shell**

```bash
su -s /bin/zsh john
```

* Starts `john`’s session with the `zsh` shell instead of the default shell.

---

## 📁 **Differences from Related Commands**

| Command | Purpose                                     | Password Required                   | Notes                                                  |
| ------- | ------------------------------------------- | ----------------------------------- | ------------------------------------------------------ |
| `su`    | Switch user temporarily                     | Target user                         | Can switch to any user                                 |
| `sudo`  | Run commands as another user (default root) | Current user (with sudo privileges) | More secure, logs command, preferred in modern systems |
| `login` | Log in as another user                      | Target user                         | Requires full logout/login, interactive only           |

---

## ⚠️ **Security Notes**

* Using `su` to switch to root requires **root password**, unlike `sudo` which uses the current user password.
* Prefer `sudo` for administrative tasks because it is **logged** and **restricted**.
* Limit `su` usage to trusted users.

---

## ✅ **Quick Summary**

| Feature          | Description                                          |
| ---------------- | ---------------------------------------------------- |
| **Command Name** | `su`                                                 |
| **Purpose**      | Switch user or root account                          |
| **Syntax**       | `su [OPTION] [USER]`                                 |
| **Default User** | root                                                 |
| **Key Option**   | `-` (login shell), `-c` (run command)                |
| **Password**     | Target user’s password required                      |
| **Use Case**     | Administrative tasks, testing, temporary user switch |

---

💡 **Example Workflow**

```bash
$ su -           # Switch to root
Password: ****
# whoami
root
# exit
$ whoami
mahin
```

* Temporarily switched to root, then returned to the original user.


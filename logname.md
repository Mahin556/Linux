# 🧑‍💻 **`logname` Command in Linux**

The **`logname`** command prints the **login name of the user who started the session**. Unlike commands like `whoami`, which show the current effective user, `logname` shows the **original login name**.

---

## 🧠 **Purpose**

* Identify the user who **initiated the login session**.
* Useful in scripts to determine the **real login user**, especially when commands are run with `sudo` or switched users (`su`).

---

## 🧩 **Syntax**

```bash
logname [OPTION]
```

### **Parameters**

* No arguments are required for typical usage.
* Only **options** like `--help` or `--version` are supported.

---

## ⚙️ **How It Works**

* Reads the **login name from the system records** (typically `/var/run/utmp`).
* Unlike `whoami` which returns the **effective username**, `logname` returns the **original login name**.

**Example Scenario:**

```bash
$ whoami
root
$ logname
mahin
```

* Here, the user `mahin` logged in, but switched to `root` via `sudo` or `su`.
* `logname` still reports the original login: `mahin`.

---

## 🔧 **Options**

| Option      | Description                          |
| ----------- | ------------------------------------ |
| `--help`    | Display usage information and exit   |
| `--version` | Display version information and exit |

> The `logname` command is **minimal** and designed to provide the login name only.

---

## 🧪 **Practical Examples**

### 🟢 **1. Display login name of the current session**

```bash
$ logname
mahin
```

---

### 🟢 **2. Using in a script**

```bash
echo "Original login user: $(logname)"
```

* Useful when running automated scripts to identify who invoked the session.

---

### 🟢 **3. Handling error “no login name”**

Sometimes, you may see:

```bash
$ logname
logname: no login name
```

**Causes:**

* The session was started without a proper login record.
* The command is run in **non-login shells**, Docker containers, cron jobs, or `su` sessions without `-l` (login) option.

**Workarounds:**

* Use `who am i` or `id -un` as alternatives:

```bash
who am i
id -un
```

---

## 📁 **Related Commands**

| Command  | Description                                      |
| -------- | ------------------------------------------------ |
| `whoami` | Shows the current effective username             |
| `id -un` | Shows current username (same as `whoami`)        |
| `users`  | Lists all currently logged-in users              |
| `who`    | Displays detailed info about logged-in users     |
| `w`      | Shows logged-in users and their current activity |

---

## ✅ **Quick Summary**

| Feature                      | Description                                                                        |
| ---------------------------- | ---------------------------------------------------------------------------------- |
| **Command Name**             | `logname`                                                                          |
| **Purpose**                  | Show the login name of the user who started the session                            |
| **Typical Use Case**         | Scripts, audit login, identify original user when using `sudo`                     |
| **Options**                  | `--help`, `--version`                                                              |
| **Difference from `whoami`** | `whoami` shows **current effective user**, `logname` shows **original login user** |
| **Common Error**             | “no login name” — occurs in non-login sessions                                     |

---

💡 **Example Comparison:**

```bash
$ whoami
root
$ logname
mahin
```

* `mahin` logged in, then used `sudo su` to become `root`.
* `whoami` = effective user, `logname` = original login user.


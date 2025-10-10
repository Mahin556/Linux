# 👤 **`users` Command in Linux**

The **`users`** command is used to **display a list of usernames of all users currently logged into the system**. It is a simple and quick way to see who is logged in.

---

## 🧠 **Purpose**

* List all currently logged-in users.
* Useful for system monitoring and simple auditing.
* Provides a concise output suitable for scripts or quick checks.

---

## 🧩 **Syntax**

```bash
users [OPTION]...
```

### **Parameters**

* The `users` command **does not require a username** as it only shows currently logged-in users.
* Any extra options are for help or version info.

---

## ⚙️ **How It Works**

* Reads the `/var/run/utmp` file, which tracks current logins.
* Displays only the **login names** in a **single line** separated by spaces.
* Repeated logins (multiple sessions of the same user) will appear multiple times.

---

## 📋 **Default Output**

```bash
$ users
mahin hduser
```

* Here, `mahin` and `hduser` are currently logged-in users.

```bash
$ users
mahin mahin hduser
```

* If a user has **multiple sessions**, their name appears multiple times.

---

## 🔧 **Options**

| Option      | Description          |
| ----------- | -------------------- |
| `--help`    | Display help message |
| `--version` | Display version info |

> Note: The `users` command is intentionally minimal and has **no extra features** for filtering or formatting.

---

## 🧪 **Practical Examples**

### 🟢 **1. Show all logged-in users**

```bash
users
```

Output:

```
mahin hduser john
```

---

### 🟢 **2. Use in scripts**

```bash
echo "Currently logged-in users: $(users)"
```

Output:

```
Currently logged-in users: mahin hduser
```

---

### 🟢 **3. Count number of logged-in users**

Combine with `wc -w`:

```bash
users | wc -w
```

* Returns the **number of logged-in sessions**.

---

## 📁 **Related Commands**

| Command  | Purpose                                                             |
| -------- | ------------------------------------------------------------------- |
| `who`    | Show detailed info about logged-in users (terminal, login time, IP) |
| `w`      | Show logged-in users and their current activity                     |
| `id`     | Display UID, GID, and groups for a user                             |
| `groups` | Show groups a user belongs to                                       |
| `last`   | Display login history                                               |

---

## ✅ **Quick Summary**

| Feature               | Description                                         |
| --------------------- | --------------------------------------------------- |
| **Command Name**      | `users`                                             |
| **Purpose**           | Show all currently logged-in users                  |
| **Output**            | Space-separated list of usernames                   |
| **Default File Read** | `/var/run/utmp`                                     |
| **Use Case**          | Quick user check, scripts, counting active sessions |

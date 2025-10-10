## 🧠 **What is `/etc/skel`?**

`/etc/skel` (skeleton directory) is a **template directory** that contains **default configuration files and folders** for new users.

Whenever you create a new user (with `useradd` or `adduser`), **the contents of `/etc/skel` are copied** into the user’s home directory automatically.

---

### 📍 Location

```
/etc/skel
```

**“skel”** = *skeleton* (base structure for home directories).

---

## ⚙️ **How It Works**

When you run:

```bash
sudo useradd -m mahin
```

or:

```bash
sudo adduser mahin
```

Linux will:

1. Create `/home/mahin`
2. Copy everything from `/etc/skel` → `/home/mahin`
3. Set proper ownership and permissions

So new users get **ready-to-use default configuration files** like `.bashrc`, `.profile`, `.bash_logout`, etc.

---

## 📦 **Default Files in `/etc/skel`**

Typical content of `/etc/skel`:

```bash
$ ls -A /etc/skel
.bash_logout  .bashrc  .profile
```

Depending on distribution, you might also find:

```
.bash_profile
.maildir
.tcshrc
.screenrc
.dircolors
.public_html/
```

These files initialize user environments (aliases, PATH, prompts, environment variables, etc.).

---

## 🧰 **Example: Default Structure**

| File                         | Purpose                                               |
| ---------------------------- | ----------------------------------------------------- |
| `.bashrc`                    | User-specific bash settings (aliases, prompt, colors) |
| `.bash_profile` / `.profile` | Runs on login (sets PATH, environment vars)           |
| `.bash_logout`               | Commands to run at logout                             |
| `.maildir/`                  | Default mail storage folder                           |
| `.screenrc`                  | Default config for GNU Screen                         |
| `.tcsh.config`               | For tcsh shell users                                  |

---

## 🧪 **Example Workflow**

### 🧩 Step 1 — Add Custom File to `/etc/skel`

```bash
sudo mkdir /etc/skel/Documents
sudo echo "Welcome to the system!" | sudo tee /etc/skel/README.txt
```

### 🧩 Step 2 — Create a New User

```bash
sudo useradd -m mahin
sudo passwd mahin
```

### 🧩 Step 3 — Check the User’s Home Directory

```bash
ls -A /home/mahin
```

You’ll see:

```
.bashrc  .profile  .bash_logout  README.txt  Documents/
```

✅ Everything from `/etc/skel` was copied to `/home/mahin`.

---

## ⚙️ **Changing the Skeleton Directory Location**

Default location is defined in:

```
/etc/default/useradd
```

Example content:

```bash
# useradd defaults file
GROUP=100
HOME=/home
INACTIVE=-1
EXPIRE=
SHELL=/bin/bash
SKEL=/etc/skel
```

### 🔧 To change it:

Edit `/etc/default/useradd` and modify:

```
SKEL=/etc/custom_skel
```

Now, all new users will copy files from `/etc/custom_skel` instead.

---

## 🧩 **Using `useradd` with Custom Skel**

You can override `/etc/skel` for a specific user:

```bash
sudo useradd -m -k /opt/mytemplates mahin
```

* `-m` → Create home directory
* `-k` → Copy from `/opt/mytemplates` instead of `/etc/skel`

---

## 🧩 **If You Don’t Want to Copy Skel**

If you use `useradd` without `-m`, no home directory (and thus no `/etc/skel` copy) will be created:

```bash
sudo useradd mahin
```

Home directory and skeleton files will **not exist** unless you manually create them.

---

## 🧰 **Best Practices for `/etc/skel`**

✅ Include:

* `.bashrc`, `.profile`, `.bash_logout`
* `.vimrc`, `.gitconfig`, `.dircolors`, etc.
* A “Welcome” file for new users
* Default directories like `Documents/`, `Downloads/`

🚫 Avoid:

* Private or sensitive files
* Machine-specific configs

---

## 🔐 **Permissions**

Ensure `/etc/skel` files have appropriate permissions:

```bash
sudo chmod -R 755 /etc/skel
```

They are copied with new user’s ownership, so root → user during creation.

---

## 🧩 **Summary**

| Feature                | Description                                       |
| ---------------------- | ------------------------------------------------- |
| **Purpose**            | Template for new user home directories            |
| **Default Path**       | `/etc/skel`                                       |
| **Config File**        | `/etc/default/useradd`                            |
| **Custom Path Option** | `useradd -k /custom/path`                         |
| **Common Files**       | `.bashrc`, `.profile`, `.bash_logout`, `.vimrc`   |
| **Auto-Copied When**   | Using `useradd -m` or `adduser`                   |
| **Editable?**          | Yes — Admins can modify to customize new accounts |

---

### 💡 **Quick Commands**

| Task                        | Command                          |
| --------------------------- | -------------------------------- |
| View skel directory         | `ls -A /etc/skel`                |
| Edit default useradd config | `sudo nano /etc/default/useradd` |
| Set custom skel dir         | `useradd -m -k /opt/skel mahin`  |
| Create home + copy skel     | `useradd -m mahin`               |
| Skip skel (no home)         | `useradd mahin`                  |

---

### ✅ **In short**

> `/etc/skel` is the **template home directory** for new users.
> It ensures every new account starts with the same default configuration and environment files.

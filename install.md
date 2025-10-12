The **`install`** command is a **utility to copy files and set attributes** in a single step. It is primarily used in **installing software binaries or scripts**. Unlike `cp`, it allows you to **set ownership, permissions, and create directories** in one command.

---

## ⚙️ **Syntax**

```bash
install [OPTION]... SOURCE... DEST
```

* **`SOURCE`** → File(s) or directory to install (copy).
* **`DEST`** → Destination directory or file name.

---

## 📄 **Common Options**

| Option                     | Description                                            |
| -------------------------- | ------------------------------------------------------ |
| `-m MODE`                  | Set permission mode (like chmod), e.g., `-m 755`       |
| `-o OWNER`                 | Set owner of the installed file                        |
| `-g GROUP`                 | Set group of the installed file                        |
| `-d`                       | Create directories instead of copying files            |
| `-t DIR`                   | Specify the destination directory for multiple sources |
| `-v`                       | Verbose output, show what is being done                |
| `-p`                       | Preserve timestamps of the source files                |
| `-b`                       | Make a backup if the file exists                       |
| `--strip-trailing-slashes` | Ignore trailing slashes in directories                 |

---

## 🧩 **Examples**

### 1️⃣ Install a single file to a directory

```bash
install script.sh /usr/local/bin/
```

* Copies `script.sh` to `/usr/local/bin/`
* Default permissions: `0755` for executable files

---

### 2️⃣ Install a file with specific permissions

```bash
install -m 644 config.conf /etc/myapp/
```

* Copies `config.conf` to `/etc/myapp/`
* Sets permissions to `rw-r--r--`

---

### 3️⃣ Install a file with specific owner and group

```bash
sudo install -o root -g root myapp /usr/local/bin/
```

* Ensures `myapp` is **owned by root** and **belongs to root group**

---

### 4️⃣ Create a directory

```bash
install -d /var/log/myapp
```

* Creates the directory `/var/log/myapp`
* Can combine with `-m` to set permissions:

```bash
install -d -m 755 /var/log/myapp
```

---

### 5️⃣ Install multiple files to a destination directory

```bash
install file1.txt file2.txt -t /tmp/install_test/
```

* Copies both `file1.txt` and `file2.txt` to `/tmp/install_test/`

---

### 6️⃣ Preserve timestamps

```bash
install -p -m 644 myfile.txt /backup/
```

* Preserves the modification and access times of `myfile.txt`

---

## ⚡ **Why use `install` instead of `cp`?**

* `install` allows **setting permissions, owner, and group while copying**.
* Can **create directories on the fly**.
* Widely used in **Makefiles** for building and installing software.
* Can make files **executable** in one step.

---

### ✅ Quick Recap

| Task                        | Command Example                            |
| --------------------------- | ------------------------------------------ |
| Copy file                   | `install source dest`                      |
| Copy file with permissions  | `install -m 644 source dest`               |
| Set owner and group         | `sudo install -o root -g root source dest` |
| Create a directory          | `install -d /path/to/dir`                  |
| Multiple files to directory | `install file1 file2 -t /dir`              |
| Preserve timestamps         | `install -p source dest`                   |

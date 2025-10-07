- `chsh` stands for Change Shell.
- It lets a user change their default login shell (the command-line interpreter that starts when they log in).
- Shell is an interactive user interface with an operating system and can be considered an outer layer of the operating system. 
- `bash` shell is one of the most widely used login shells in Linux.
- Give warning if the shell is not present in the /etc/shells file.
- The superuser can change the login shell for the existing accounts. 

* Check your current shell
```bash
ubuntu:~$ echo $SHELL
/bin/bash

ubuntu:~$ grep "^$USER" /etc/passwd
kc-internal:x:0:0::/root:/bin/bash
```

* To list all the available shells
```bash
cat /etc/shells
```
-> You can only switch to shells listed here.

* Change your own shell interactively
```bash
chsh #current user
sudo chsh user1 #specific user
```
-> Prompts you to enter the new shell path (e.g., /bin/zsh).

* Change your shell directly (non-interactive)
```bash
chsh -s <shell>
```
-> Changes your login shell to /bin/zsh.

* Change another user’s shell (root only)
```bash
sudo chsh -s /bin/bash username
```

* Switch from Bash to Zsh for better features (autocompletion, themes).
* Set a restricted shell for users (like /bin/rbash) for security.
* Change shell for automation accounts or service users.
* Regular users can only change their own shell.
* Root can change any user’s shell and use any path.
* After running chsh, the change applies at next login (not to the current session).
* User shell info is stored in /etc/passwd, when you log in, the system reads your entry from /etc/passwd.
* In Ubuntu (and Debian-based systems), the chsh binary comes from the passwd package (not from util-linux), and that version does not support the -l (list shells) option and other options, but it work on centos.rhel etc.
* The help output you’re seeing confirms that — only -h, -R, and -s are available.

---

### 🧠 **What `chsh -R` Does**

* The `-R` (or `--root`) option tells `chsh` to operate **inside a different root directory** (a *chroot environment*).
* It means that `chsh` won’t modify `/etc/passwd` on your main system — instead, it will modify the `/etc/passwd` inside the directory you specify (the chrooted environment).
* This is useful when you’re managing users or configuring login shells **for a different system image**, like:

  * a **container**,
  * a **mounted disk**, or
  * a **system rescue environment**.

---

### 🧩 **Command Syntax**

```bash
sudo chsh -R <CHROOT_DIR> -s <SHELL_PATH> <USERNAME>
```

Example:

```bash
sudo chsh -R /mnt/chroot -s /bin/sh sara
```

---

### 🧱 **Command Breakdown**

| Part             | Meaning                                                                  |
| ---------------- | ------------------------------------------------------------------------ |
| `sudo`           | Required to modify system-level user files.                              |
| `chsh`           | Command to change user shell.                                            |
| `-R /mnt/chroot` | Operate inside the `/mnt/chroot` directory instead of the real root `/`. |
| `-s /bin/sh`     | Sets `/bin/sh` as the new login shell.                                   |
| `sara`           | The username whose shell is being changed.                               |

---

### ⚙️ **How It Works Internally**

1. Normally, `chsh` edits `/etc/passwd` to update the shell field.
2. With `-R`, `chsh` looks for `/mnt/chroot/etc/passwd` instead.
3. It updates the user entry in that file, effectively changing the shell **inside the chroot system**, not your main OS.

---

### 🧰 **Practical Use Cases**

* **System recovery:**
  You’ve mounted a broken Linux installation under `/mnt/recovery`. You can update user shells there without booting into that OS:

  ```bash
  sudo chsh -R /mnt/recovery -s /bin/bash user1
  ```
* **Preparing a chroot environment:**
  When building a minimal Linux image or Docker base layer, you can preset user shells:

  ```bash
  sudo chsh -R /mnt/base -s /usr/bin/zsh root
  ```
* **Forensic or offline configuration:**
  If you need to modify a disk image or an offline partition safely, you can use this to change settings without running it.

---

### ⚠️ **Important Notes**

* Only works with **root privileges** (`sudo` required).
* The `CHROOT_DIR` must contain a valid `/etc/passwd` file.
* Not all `chsh` versions support `-R` — if your version doesn’t, you’ll see:

  ```
  chsh: invalid option -- 'R'
  ```

  In that case, you can **manually edit** the `/etc/passwd` file inside your chroot environment.

---

### 🧪 **Manual Equivalent (if `-R` unsupported)**

If your system’s `chsh` doesn’t have `-R`, do it manually:

```bash
sudo nano /mnt/chroot/etc/passwd
```

Find the user’s line:

```
sara:x:1001:1001:,,,:/home/sara:/bin/bash
```

Change the last field to desired shell, e.g. `/bin/sh`, then save.

---

Excellent 👌 — let’s go step-by-step through a **real, safe, and practical example** of creating a **chroot environment** and using **`chsh -R`** to change a user’s shell inside it.

This will help you *understand and test* how `chsh -R` works without touching your main Ubuntu system.

---

### 🧩 **Goal**

We’ll:

1. Create a minimal chroot environment at `/mnt/my_chroot`.
2. Add a fake user (`sara`) inside it.
3. Use `chsh -R` to change that user’s shell to `/bin/sh`.

---

### 🪜 **Step 1: Create a minimal Ubuntu base system**

Use `debootstrap` (a tool that installs a base Debian/Ubuntu system into a directory).

```bash
sudo apt update
sudo apt install debootstrap -y
```

Now create the chroot system:

```bash
sudo debootstrap focal /mnt/my_chroot http://archive.ubuntu.com/ubuntu/
```

> `focal` = Ubuntu 20.04 base (you can use `jammy` for 22.04).
> This may take a few minutes as it downloads core packages.

---

### 🧱 **Step 2: Mount essential filesystems**

Before entering or modifying chroot, mount basic directories so it can work properly:

```bash
sudo mount --bind /dev /mnt/my_chroot/dev
sudo mount --bind /proc /mnt/my_chroot/proc
sudo mount --bind /sys /mnt/my_chroot/sys
```

---

### 👩‍💻 **Step 3: Create a user inside the chroot**

Enter the chroot environment:

```bash
sudo chroot /mnt/my_chroot
```

Inside the chroot shell:

```bash
useradd -m sara
passwd sara
```

Set any password you like.

Exit the chroot:

```bash
exit
```

---

### 🧠 **Step 4: Check the user entry inside chroot**

Verify that `sara` exists in `/mnt/my_chroot/etc/passwd`:

```bash
grep sara /mnt/my_chroot/etc/passwd
```

Output should look like:

```
sara:x:1000:1000::/home/sara:/bin/bash
```

---

### 🧩 **Step 5: Change user shell inside chroot using `chsh -R`**

Now run:

```bash
sudo chsh -R /mnt/my_chroot -s /bin/sh sara
```

No output means it succeeded ✅

Verify the change:

```bash
grep sara /mnt/my_chroot/etc/passwd
```

You should now see:

```
sara:x:1000:1000::/home/sara:/bin/sh
```

---

### ⚙️ **Step 6: (Optional) Enter chroot and confirm**

```bash
sudo chroot /mnt/my_chroot
su - sara
echo $SHELL
```

Output should show:

```
/bin/sh
```

---

### 🧹 **Step 7: Cleanup (optional)**

When done testing, unmount everything:

```bash
sudo umount /mnt/my_chroot/dev
sudo umount /mnt/my_chroot/proc
sudo umount /mnt/my_chroot/sys
```

---

### 🧰 **Summary**

| Task                       | Command                                                                   |
| -------------------------- | ------------------------------------------------------------------------- |
| Install tools              | `sudo apt install debootstrap`                                            |
| Create chroot              | `sudo debootstrap focal /mnt/my_chroot http://archive.ubuntu.com/ubuntu/` |
| Create user                | `sudo chroot /mnt/my_chroot useradd -m sara`                              |
| Change shell inside chroot | `sudo chsh -R /mnt/my_chroot -s /bin/sh sara`                             |
| Verify                     | `grep sara /mnt/my_chroot/etc/passwd`                                     |




### **how to create and use a chroot environment on RHEL** (Red Hat Enterprise Linux) and apply the `chsh -R` command inside it.

This will let you safely test or modify another environment — like a mounted partition, minimal root filesystem, or recovery system — without affecting your main RHEL system.

---

## 🧠 **Concept Recap**

* `chsh -R /path/to/chroot` → changes a user’s shell *inside that chroot* environment.
* We’ll create a minimal RHEL-like chroot using `dnf` or `yum` and test it.

---

## 🪜 **Step-by-Step Setup**

### 🧩 **Step 1: Install the required tools**

You’ll need the `dnf` (or `yum`) utility and `coreutils` for basic tools.

```bash
sudo dnf install dnf-utils -y
```

*(On older RHEL/CentOS 7, use `sudo yum install yum-utils` instead.)*

---

### 🧱 **Step 2: Create the chroot directory**

```bash
sudo mkdir -p /mnt/my_chroot
```

---

### 🧰 **Step 3: Install a minimal RHEL base system**

Use `dnf --installroot` to create a minimal chroot root filesystem:

```bash
sudo dnf --installroot=/mnt/my_chroot --releasever=$(rpm -E %{rhel}) install bash coreutils passwd shadow-utils vim-minimal -y
```

Explanation:

* `--installroot` = where the environment will be built.
* `--releasever=$(rpm -E %{rhel})` = uses your RHEL version automatically.
* We install minimal packages:

  * `bash` (shell)
  * `coreutils` (basic commands)
  * `passwd` and `shadow-utils` (for `chsh`, useradd, etc.)

---

### 🧩 **Step 4: Mount essential filesystems**

Bind-mount necessary system directories so the chroot has basic functionality:

```bash
sudo mount --bind /dev /mnt/my_chroot/dev
sudo mount --bind /proc /mnt/my_chroot/proc
sudo mount --bind /sys /mnt/my_chroot/sys
```

---

### 👩‍💻 **Step 5: Create a user inside the chroot**

Enter the chroot environment:

```bash
sudo chroot /mnt/my_chroot
```

Inside the chroot shell:

```bash
useradd -m sara
passwd sara
exit
```

---

### 🧠 **Step 6: Change user shell inside the chroot using `chsh -R`**

Back in your main RHEL environment:

```bash
sudo chsh -R /mnt/my_chroot -s /bin/sh sara
```

✅ If successful, there will be **no output**.

Verify inside `/mnt/my_chroot/etc/passwd`:

```bash
grep sara /mnt/my_chroot/etc/passwd
```

Output should now show:

```
sara:x:1000:1000::/home/sara:/bin/sh
```

---

### 🧪 **Step 7: Test It**

Enter the chroot again:

```bash
sudo chroot /mnt/my_chroot
su - sara
echo $SHELL
```

You should see:

```
/bin/sh
```

---

### 🧹 **Step 8: Cleanup**

When you’re done testing, unmount the bind mounts:

```bash
sudo umount /mnt/my_chroot/dev
sudo umount /mnt/my_chroot/proc
sudo umount /mnt/my_chroot/sys
```

---

## ⚙️ **Summary Table**

| Task                      | Command                                                                               |
| ------------------------- | ------------------------------------------------------------------------------------- |
| Create chroot directory   | `sudo mkdir -p /mnt/my_chroot`                                                        |
| Install minimal RHEL base | `sudo dnf --installroot=/mnt/my_chroot install bash coreutils passwd shadow-utils -y` |
| Mount required dirs       | `sudo mount --bind /dev /mnt/my_chroot/dev` (and `/proc`, `/sys`)                     |
| Enter chroot              | `sudo chroot /mnt/my_chroot`                                                          |
| Add user                  | `useradd -m sara`                                                                     |
| Change shell (outside)    | `sudo chsh -R /mnt/my_chroot -s /bin/sh sara`                                         |
| Verify                    | `grep sara /mnt/my_chroot/etc/passwd`                                                 |
| Cleanup                   | `sudo umount /mnt/my_chroot/{dev,proc,sys}`                                           |


# 🔐 **SUDO and SUDOERS in Linux**

## 1️⃣ **What is `sudo`?**
* **Meaning:** “substitute user do” or “super user do.”
* **Purpose:** Temporarily elevate a regular (non-root) user to perform commands with **root privileges**.
* Incorrect modifications can lock you out of administrative access or create vulnerabilities.
* sudo means “super user do” → run a command with temporary root privileges.
* It checks /etc/sudoers (and any files under /etc/sudoers.d/) to see who’s allowed to do what.
* su switches to the root account entirely (riskier).
* **Example:**

```bash
sudo cat /etc/shadow
```

* Normally, `/etc/shadow` is restricted; using `sudo` allows authorized users to view it.

---

## 2️⃣ **What is the SUDOERS file?**

* File controlling **who can run sudo commands and what commands they can run**.
* Location: `/etc/sudoers` (main file).
* Custom configurations can be placed in `/etc/sudoers.d/` (directory).

---

## 3️⃣ **Why sudoers and sudo?**

* Local users have limited privileges by default.
* Sudo allows granting temporary administrative access **without sharing the root password**.
* Helps **secure sensitive files** like `/etc/shadow` while giving controlled access.
* we can control who can do what and where.
* Commands, Hosts, users, groups etc
* User `visudo` to edit /etc/sudoers file(safety ---> visudo locks the file and validates syntax on save, preventing lockouts.)


---

## 4️⃣ **What is `/etc/sudoers.d/`?**

* Directory where we can create **custom sudoers files**.
* Benefits:
  * Keeps `/etc/sudoers` clean.
  * Custom rules remain intact after system upgrades.
  * Reduces risk of **system-wide lockout** due to misconfiguration.

---

## 5️⃣ **Sudoers File Structure**

Format:

```text
user/group host(s) = (user ownership : group ownership) command(s)
```

### **Aliases**

Aliases help group users, commands, or hosts to simplify rules.

| Alias Type      | Example                                            | Purpose                        |
| --------------- | -------------------------------------------------- | ------------------------------ |
| **User_Alias**  | `User_Alias FULLTIMERS = albert, ronald, ann`      | Group of users                 |
| **Runas_Alias** | `Runas_Alias DB = oracle, mysql`                   | Users that commands can run as |
| **Host_Alias**  | `Host_Alias DEVSERVERS = testdb, devapp1, preprod` | Group of hostnames             |
| **Cmnd_Alias**  | `Cmnd_Alias VIEWSHADOW = /usr/bin/cat /etc/shadow` | Group of commands              |

---

```bash
touch /etc/sudoers.d/mahin

mahin ALL=(root) NOPASSWD: /usr/bin/touch /root/* #All mahin user to run touch command as root in /root/.
mahin ALL=(raza) NOPASSWD: /usr/bin/ls /home/raza/* #All mahin user to run ls command as raza in /home/raza/.

mahin ALL = (ALL) ALL #mahin can run anything on any host as any user
mahin ALL=(ALL:ALL) ALL #Gives user `mahin` full sudo privileges on all hosts.

%wheel ALL = (ALL) ALL #Users in group `wheel` can run anything 
%sudo ALL=(ALL:ALL) ALL #`%` prefix indicates a **group**, Members of group `sudo` can run commands as root.

User_Alias FULLTIMERS = albert, ronald, ann
FULLTIMERS ALL = NOPASSWD: ALL  #Full-time users can run anything **without password** 

mahin ALL=(ALL) NOPASSWD:ALL

Host_Alias DEVSERVERS = testdb, devapp1, preprod
peter DEVSERVERS = ALL #Peter can run any command on DEVSERVERS hosts


jane PRODSERVERS = /usr/bin/passwd [A-z]*, !/usr/bin/passwd root #Jane can change passwords for anyone except root on PRODSERVERS

sam DEVSERVERS = (DB) ALL #Sam can run commands as `oracle` or `mysql` on DEVSERVERS

fred ALL = (DB) NOPASSWD: ALL #Fred can run DB commands **without password**

jen ALL, !PRODSERVERS = VIEWSHADOW #Jen can run `VIEWSHADOW` commands on all hosts except PRODSERVERS

mahin ALL=(ALL) /usr/bin/apt,/usr/bin/systemctl #User can only execute `apt` and `systemctl` with sudo, Prevents root-level access to all other commands.

mahin server1=(ALL) ALL #User `mahin` can use sudo **only on host `server1`**, Useful in multi-server environments.

%deployers ALL=(root) NOPASSWD: /usr/bin/systemctl restart myapp.service #Restrict Command Scope (Principle of Least Privilege), Never allow ALL unless absolutely necessary.

mahin ALL=(root) NOPASSWD: /usr/bin/apt-get update #User mahin can run /usr/bin/apt-get update as root, without being asked for a password.

```
```bash
User_Alias   ADMINS = mahin, sharmila, ramesh
Cmnd_Alias   UPDATE = /usr/bin/apt-get update, /usr/bin/apt upgrade
Cmnd_Alias   REBOOT = /sbin/reboot, /sbin/shutdown

ADMINS ALL=(ALL) NOPASSWD: UPDATE, REBOOT
```
* This means all users in ADMINS can update and reboot the system passwordlessly.

* Always specify full paths, or sudo won’t match.
```bash
which reboot
which apt-get
which systemctl
```
* Validate Your Configuration
```bash
visudo -c
```
* Test the Rule
```bash
sudo -l 
```
-> List what you are allowed to do

![](/images/image.webp)
![](/images/image1.webp)

---

## 6️⃣ **Using `/etc/sudoers` Effectively**

1. **Always use `visudo`** to edit `/etc/sudoers`.
2. Prefer placing custom files in `/etc/sudoers.d/` for upgrades and safety.
3. Use aliases to **simplify configuration** for multiple users, commands, or hosts.
4. Use `NOPASSWD` **sparingly**, only for trusted users or scripts.
5. Use negative permissions (`!`) to **deny specific commands**.

---
### Use admin groups instead of granting per-user ALL privileges.

| Distro Family          | Recommended Admin Group |
| ---------------------- | ----------------------- |
| **Ubuntu/Debian**      | `sudo`                  |
| **RHEL/CentOS/Fedora** | `wheel`                 |


---

## 7️⃣ **Sudoers Best Practices**

* Avoid direct editing of `/etc/sudoers` with text editors.
* Group users logically (FULLTIMERS, DEVSERVERS).
* Test changes with `sudo -l` (list allowed commands).
* Keep rules minimal and clear.
* Backup `/etc/sudoers` before major edits.

### Keep Policies Modular
* Use purpose-specific files in `/etc/sudoers.d/`.
  ```bash
  sudo visudo -f /etc/sudoers.d/<filename>
  ```
Modular design:
  * Easier to audit and roll back.
  * Compatible with config management tools (e.g., Ansible, Puppet).
  * Easier packaging and deployment.

---

* Command paths can differ:
  ```bash
  command -v systemctl
  ```
  Adjust sudoers accordingly:
    /usr/bin/systemctl (common in newer distros)
    /bin/systemctl (older or minimal systems)
---

## 🧭 Step-by-Step Recovery Plan for Broken `sudo`

### **1️⃣ Try the safest method first — `pkexec visudo`**

If you can still log in with your normal user:

```bash
pkexec visudo
```

* `pkexec` is part of **polkit** and lets you run a command as root using a GUI or password prompt.
* It opens the same secure editor as `visudo`.
* Fix syntax errors, save, and exit.

✅ If this works, you’re done.

---

### **2️⃣ If `pkexec` is unavailable or fails: use `su -`**

If you know the **root password**:

```bash
su -
visudo
```

Fix `/etc/sudoers` or delete any bad fragment in `/etc/sudoers.d/`.

---

### **3️⃣ If even `su` doesn’t work — go into single-user or rescue mode**

#### 🔹 **For RHEL / CentOS / Fedora**

1. Reboot your system.
2. At the GRUB menu, press `e` to edit the boot entry.
3. Find the line that starts with `linux` and append:

   ```
   systemd.unit=rescue.target
   ```

   or:

   ```
   single
   ```
4. Press `Ctrl + X` or `F10` to boot.

You’ll be dropped into a **root shell** without a password.

---

### **4️⃣ Remount the filesystem read-write**

By default, rescue/single mode may mount `/` as read-only.

Run:

```bash
mount -o remount,rw /
```

Then verify:

```bash
mount | grep ' / '
```

It should show `(rw,...)`.

---

### **5️⃣ Repair the sudoers file**

Run:

```bash
visudo
```

or to edit a specific fragment:

```bash
visudo -f /etc/sudoers.d/yourfile
```

If you just need to restore minimal sudo access, add:

```
root ALL=(ALL) ALL
%wheel ALL=(ALL) ALL
```

Or for a specific user (example: mahin):

```
mahin ALL=(ALL) ALL
```

Save and exit.

---

### **6️⃣ Validate and reboot**

Check syntax before exiting rescue mode:

```bash
visudo -c
```

If it says:

```
/etc/sudoers: parsed OK
```

you’re safe to reboot:

```bash
reboot
```

---

### ✅ **Quick Summary Table**

| Scenario                      | Command to Try                                                 |
| ----------------------------- | -------------------------------------------------------------- |
| You can log in as normal user | `pkexec visudo`                                                |
| You know root password        | `su -` → `visudo`                                              |
| No sudo or su access          | Boot **single-user mode** → `mount -o remount,rw /` → `visudo` |



## ✅ **Conclusion**

* Understanding sudo and sudoers is essential for multi-user Linux environments.
* The combination of **sudo, /etc/sudoers, and /etc/sudoers.d/** allows secure and flexible management of administrative privileges.
* Proper use ensures **security, controlled access, and system stability**.

### References:
- https://heshandharmasena.medium.com/explain-sudoers-file-configuration-in-linux-1fe00f4d6159
- https://www.geeksforgeeks.org/linux-unix/useful-sudoers-configurations-for-setting-sudo-in-linux/
- https://www.linuxfoundation.org/blog/blog/classic-sysadmin-configuring-the-linux-sudoers-file
- https://www.digitalocean.com/community/tutorials/how-to-edit-the-sudoers-file
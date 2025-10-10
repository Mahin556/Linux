# 🔐 **SUDO and SUDOERS in Linux**

## 1️⃣ **What is `sudo`?**

* **Meaning:** “substitute user do” or “super user do.”
* **Purpose:** Temporarily elevate a regular (non-root) user to perform commands with **root privileges**.
* Incorrect modifications can lock you out of administrative access or create vulnerabilities.
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

---

## 4️⃣ **What is `/etc/sudoers.d/`?**

* Directory for **custom sudoers files**.
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

### **Sample Entries**

| Entry                                                              | Meaning                                                           |
| ------------------------------------------------------------------ | ----------------------------------------------------------------- |
| `root ALL = (ALL) ALL`                                             | Root can run anything on any host as any user                     |
| `%wheel ALL = (ALL) ALL`                                           | Users in group `wheel` can run anything                           |
| `FULLTIMERS ALL = NOPASSWD: ALL`                                   | Full-time users can run anything **without password**             |
| `peter DEVSERVERS = ALL`                                           | Peter can run any command on DEVSERVERS hosts                     |
| `jane PRODSERVERS = /usr/bin/passwd [A-z]*, !/usr/bin/passwd root` | Jane can change passwords for anyone except root on PRODSERVERS   |
| `sam DEVSERVERS = (DB) ALL`                                        | Sam can run commands as `oracle` or `mysql` on DEVSERVERS         |
| `fred ALL = (DB) NOPASSWD: ALL`                                    | Fred can run DB commands **without password**                     |
| `jen ALL, !PRODSERVERS = VIEWSHADOW`                               | Jen can run `VIEWSHADOW` commands on all hosts except PRODSERVERS |

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

## 7️⃣ **Sudoers Best Practices**

* Avoid direct editing of `/etc/sudoers` with text editors.
* Group users logically (FULLTIMERS, DEVSERVERS).
* Test changes with `sudo -l` (list allowed commands).
* Keep rules minimal and clear.
* Backup `/etc/sudoers` before major edits.

---

## ✅ **Conclusion**

* Understanding sudo and sudoers is essential for multi-user Linux environments.
* The combination of **sudo, /etc/sudoers, and /etc/sudoers.d/** allows secure and flexible management of administrative privileges.
* Proper use ensures **security, controlled access, and system stability**.


### References:
- https://heshandharmasena.medium.com/explain-sudoers-file-configuration-in-linux-1fe00f4d6159
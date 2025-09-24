
# 📘 The Complete Guide to `/etc/default/useradd`

## 1. **What is `/etc/default/useradd`?**

* A configuration file read by the `useradd` binary to **set defaults** when creating new user accounts.
* Instead of typing options (`-s`, `-g`, `-e`, etc.) every time, the defaults in this file are used automatically.
* Works in conjunction with:

  * `/etc/login.defs` → global system defaults (UID ranges, password aging, etc.)
  * `/etc/skel` → skeleton files copied into a new user’s home directory
  * `/etc/passwd`, `/etc/shadow`, `/etc/group` → actual user DBs

---

## 2. **View Current Defaults**

Run:

```bash
useradd -D
```

Example output (CentOS 7/8/9):

```
GROUP=100
HOME=/home
INACTIVE=-1
EXPIRE=
SHELL=/bin/bash
SKEL=/etc/skel
CREATE_MAIL_SPOOL=yes
```

---

## 3. **Parameters in `/etc/default/useradd`**

Here are the **valid keys** (RHEL/CentOS + Debian differences noted):

| Parameter           | Description                                                                                   | Example                 |
| ------------------- | --------------------------------------------------------------------------------------------- | ----------------------- |
| `GROUP`             | Default primary group ID (GID). If missing, a new group is created with the same name as user | `GROUP=100`             |
| `HOME`              | Base directory for home dirs (the user’s home is `$HOME/username`)                            | `HOME=/home`            |
| `INACTIVE`          | Days after password expires before account is disabled. `-1` = disable feature                | `INACTIVE=30`           |
| `EXPIRE`            | Date (YYYY-MM-DD) when account is locked                                                      | `EXPIRE=2025-12-31`     |
| `SHELL`             | Default login shell                                                                           | `SHELL=/bin/bash`       |
| `SKEL`              | Skeleton dir; files copied here go into every new home dir                                    | `SKEL=/etc/skel`        |
| `CREATE_MAIL_SPOOL` | Whether to create a mail spool in `/var/spool/mail/`                                          | `CREATE_MAIL_SPOOL=yes` |

---

## 4. **Where Other Defaults Live**

Some defaults **do not live in `/etc/default/useradd`** but elsewhere:

* `/etc/login.defs` → UID/GID ranges, password max/min days, umask
  Example:

  ```bash
  UID_MIN           1000
  UID_MAX           60000
  PASS_MAX_DAYS     90
  PASS_MIN_DAYS     7
  PASS_WARN_AGE     7
  ```
* `/etc/skel/` → template files copied into home dirs (`.bashrc`, `.profile`)
* `/etc/adduser.conf` (Debian/Ubuntu only, not CentOS) → adduser defaults

---

## 5. **Unsupported Ideas**

* `GROUPS=wheel,dialout,tftp` → ❌ not valid in `/etc/default/useradd` (works only per-command `-G`)
* `DIR_MODE=1770` → ❌ not supported here. Directory mode must be set via `umask` or `mkdir` scripts.

If you want that kind of behavior, you need **wrapper scripts** or system-wide PAM/modules (e.g., `pam_mkhomedir` with `umask=0077`).

---

## 6. **Practical Examples**

### Example 1: Default shell = zsh

```bash
echo 'SHELL=/bin/zsh' >> /etc/default/useradd
```

Now:

```bash
sudo useradd alice
```

→ `alice` will have `/bin/zsh` as her shell.

---

### Example 2: Set account expiry date for new users

```bash
echo 'EXPIRE=2025-12-31' >> /etc/default/useradd
```

Every new user will have account locked after that date.

---

### Example 3: Enforce home dir under `/srv/users`

```bash
echo 'HOME=/srv/users' >> /etc/default/useradd
```

→ `useradd bob` gets `/srv/users/bob`

---

### Example 4: Force skeleton files

Add templates to `/etc/skel/`:

```bash
echo "Welcome to this system" > /etc/skel/README.txt
```

Now every new user gets this file in their home dir.

---

## 7. **Best Practices**

* Don’t try unsupported options (`GROUPS`, `DIR_MODE`) in `/etc/default/useradd`.
* For **multiple default groups**, use `useradd` wrapper scripts.
* For **home dir permissions**, use `/etc/login.defs` (`UMASK`) or PAM.
* Verify changes with `useradd -D`.

---

## 8. **Official References**

* `man useradd` (look for *FILES* section)
* [shadow-utils source (RHEL)](https://github.com/shadow-maint/shadow)
* [Debian passwd package](https://manpages.debian.org/useradd)
* http://uw714doc.xinuos.com/en/SM_basics/etc_default_useradd.html




# **Linux `login.defs` — Complete Guide**

The **`/etc/login.defs`** file is part of the **shadow password suite** and defines **site-specific configuration** for user account management, password aging, UID/GID ranges, and other account-related parameters. It’s a **text file** and typically required for smooth system operations.

The /etc/login.defs file controls default values for newly created users. Changes here do not affect existing users.

* **Location:** `/etc/login.defs`
* **Purpose:** Configure defaults for user creation, login, and password policies.
* **Format:**

  * Each line contains a parameter and its value separated by whitespace.
  * Blank lines and lines starting with `#` are ignored.
  * Parameter types: string, boolean (`yes/no`), number, long number.

---

## **1. User and Password Parameters**

These parameters define user password behavior and account aging policies. They are essential for **security compliance**.

| Parameter              | Type    | Description                                                                                                                        |
| ---------------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `PASS_MAX_DAYS`        | number  | Maximum number of days a password may be used. Users must change password after this. `-1` disables.                               |
| `PASS_MIN_DAYS`        | number  | Minimum number of days between password changes. Prevents rapid password changes.                                                  |
| `PASS_WARN_AGE`        | number  | Number of days before password expires when the user is warned. `0` = warning on expiry day, `-1` = no warning.                    |
| `ENCRYPT_METHOD`       | string  | Default password hashing algorithm: `DES`, `MD5`, `SHA256`, `SHA512`. SHA256/512 recommended.                                      |
| `MD5_CRYPT_ENAB`       | boolean | Deprecated. Enable MD5 password encryption (`yes/no`). Superseded by `ENCRYPT_METHOD`.                                             |
| `SHA_CRYPT_MIN_ROUNDS` | number  | Minimum SHA rounds for SHA256/512 passwords. More rounds = stronger password, more CPU usage.                                      |
| `SHA_CRYPT_MAX_ROUNDS` | number  | Maximum SHA rounds.                                                                                                                |
| `CHFN_RESTRICT`        | string  | Restrict which GECOS fields users can change: `f`=Full name, `r`=Room, `w`=Work phone, `h`=Home phone. `yes` = `rwh`, `no`=`frwh`. |

**Practical Use:** Controls password strength, aging, and warnings, ensuring compliance with security policies.

### See the password aging
```
chage -l username
```

---

## **2. UID and GID Ranges**

Defines default ranges for **user and group IDs** during account creation.

| Parameter                                     | Type   | Description                                                             |
| --------------------------------------------- | ------ | ----------------------------------------------------------------------- |
| `UID_MIN`, `UID_MAX`                          | number | Range for regular users. Default: `1000-60000`.                         |
| `SYS_UID_MIN`, `SYS_UID_MAX`                  | number | Range for system users. Default: `101-UID_MIN-1`.                       |
| `GID_MIN`, `GID_MAX`                          | number | Range for regular groups. Default: `1000-60000`.                        |
| `SYS_GID_MIN`, `SYS_GID_MAX`                  | number | Range for system groups. Default: `101-GID_MIN-1`.                      |
| `SUB_UID_MIN`, `SUB_UID_MAX`, `SUB_UID_COUNT` | number | Range for subordinate user IDs for unprivileged containers or `userns`. |
| `SUB_GID_MIN`, `SUB_GID_MAX`, `SUB_GID_COUNT` | number | Range for subordinate group IDs.                                        |

**Why Important:**

* Avoid UID/GID conflicts.
* Ensures regular and system users are properly separated.
* Useful for containers and sandboxed users.

---

## **3. Home Directory and Shell Settings**

| Parameter      | Type    | Description                                                           |
| -------------- | ------- | --------------------------------------------------------------------- |
| `CREATE_HOME`  | boolean | Create home directory by default for new users (`yes/no`).            |
| `DEFAULT_HOME` | boolean | Allow login if home directory doesn’t exist (`yes/no`). Default `no`. |
| `HOME_MODE`    | number  | File mode for new home directories. Overrides `UMASK` if set.         |
| `FAKE_SHELL`   | string  | Shell executed at login instead of user's `/etc/passwd` shell.        |

**Practical Use:**

* Automatically manage home directories for new users.
* Control login behavior for system or incomplete accounts.

---

## **4. Login Behavior and Security**

| Parameter          | Type    | Description                                                           |
| ------------------ | ------- | --------------------------------------------------------------------- |
| `LOGIN_RETRIES`    | number  | Maximum login retries before denying access.                          |
| `LOGIN_TIMEOUT`    | number  | Max time allowed for login prompt.                                    |
| `FAIL_DELAY`       | number  | Delay in seconds after a failed login attempt.                        |
| `LOG_OK_LOGINS`    | boolean | Enable logging of successful logins.                                  |
| `LOG_UNKFAIL_ENAB` | boolean | Log failed attempts with unknown usernames. Security risk if enabled. |
| `HUSHLOGIN_FILE`   | string  | If file exists, suppress login messages (quiet login).                |

**Practical Use:**

* Control login retries and timing to prevent brute-force attacks.
* Log login activity for auditing.

---

## **5. Mail Configuration**

| Parameter   | Type   | Description                             |
| ----------- | ------ | --------------------------------------- |
| `MAIL_DIR`  | string | Default mail spool directory for users. |
| `MAIL_FILE` | string | Mail file location relative to home.    |

**Practical Use:**

* `useradd`, `usermod`, and `userdel` use these to create/move/delete mail spools automatically.

---

## **6. Terminal Settings**

| Parameter      | Type   | Description                                                     |
| -------------- | ------ | --------------------------------------------------------------- |
| `ERASECHAR`    | number | Terminal erase character (backspace or DEL).                    |
| `KILLCHAR`     | number | Terminal kill character (e.g., CTRL+U).                         |
| `TTYGROUP`     | string | Group that owns login terminals. Default: user’s primary group. |
| `TTYPERM`      | number | Permissions for login terminal. Default: `0600`.                |
| `TTYTYPE_FILE` | string | File mapping TTY line to TERM environment variable.             |

**Practical Use:**

* Ensures proper ownership and permissions on terminal devices.
* Useful for multi-user systems with shared terminals.

---

## **7. Logging and SU/SUDO**

| Parameter        | Type    | Description                                 |
| ---------------- | ------- | ------------------------------------------- |
| `SULOG_FILE`     | string  | File to log all `su` activity.              |
| `SU_NAME`        | string  | Command name displayed when running `su -`. |
| `SYSLOG_SU_ENAB` | boolean | Enable syslog logging for `su`.             |
| `SYSLOG_SG_ENAB` | boolean | Enable syslog logging for `sg`.             |

**Practical Use:**

* Audit privilege escalation (`su`) activity.
* Can enforce logging in secure environments.

---

## **8. Miscellaneous**

| Parameter               | Type    | Description                                                                        |
| ----------------------- | ------- | ---------------------------------------------------------------------------------- |
| `UMASK`                 | number  | Default file creation mask (`022` by default).                                     |
| `USERDEL_CMD`           | string  | Command executed during user deletion to clean cron, at, print jobs.               |
| `USERGROUPS_ENAB`       | boolean | If `yes`, userdel removes user's group if empty, useradd creates a group per user. |
| `MAX_MEMBERS_PER_GROUP` | number  | Maximum members allowed in a single group entry. Useful for NIS compatibility.     |
| `NONEXISTENT`           | string  | Placeholder for accounts with no home directory to suppress `pwck` warnings.       |

---

## **9. Cross References**

`login.defs` parameters are used by:

* **User management commands:** `useradd`, `usermod`, `userdel`, `newusers`
* **Group management commands:** `groupadd`, `groupdel`, `groupmod`
* **Password management:** `passwd`, `chfn`, `chpasswd`, `chgpasswd`
* **Login & shell:** `login`, `su`, `newgrp`
* **Audit & logs:** `lastlog`, `sulog`, syslog settings

---

## **10. Notes and Best Practices**

1. **PAM vs login.defs**

   * Many settings in `login.defs` (e.g., password expiry) are now handled by **PAM (Pluggable Authentication Modules)**.
   * Always align `login.defs` with PAM policies (`/etc/pam.d/`).

2. **Security Recommendations**

   * Use `SHA512` for password hashing (`ENCRYPT_METHOD=SHA512`).
   * Set reasonable password aging:

     ```bash
     PASS_MAX_DAYS=90
     PASS_MIN_DAYS=7
     PASS_WARN_AGE=7
     ```
   * Enforce logging for `su` and failed login attempts:

     ```bash
     SULOG_FILE=/var/log/sulog
     SYSLOG_SU_ENAB=yes
     LOG_UNKFAIL_ENAB=no
     ```

3. **UID/GID Planning**

   * Keep regular users >1000, system users <1000.
   * Assign separate subordinate UID/GID ranges for containers.

4. **Automation**

   * Combine `login.defs` with `useradd` and `newusers` scripts for bulk user management.
   * Example: new user creation automatically respects UID/GID, password policies, home directories, and mail spools.

---

## **Summary**

* `login.defs` controls **default behavior for users, passwords, groups, login, mail, and terminal devices**.
* Essential parameters: `PASS_MAX_DAYS`, `PASS_MIN_DAYS`, `PASS_WARN_AGE`, `UID_MIN/MAX`, `GID_MIN/MAX`, `ENCRYPT_METHOD`.
* Many settings are now supplemented by **PAM**, but `login.defs` remains a foundational configuration file for account management.
* Properly configuring it ensures **secure and predictable user management** in Linux.


#### login.defs file
```bash
#
# Please note that the parameters in this configuration file control the
# behavior of the tools from the shadow-utils component. None of these
# tools uses the PAM mechanism, and the utilities that use PAM (such as the
# passwd command) should therefore be configured elsewhere. Refer to
# /etc/pam.d/system-auth for more information.
#

# *REQUIRED*
#   Directory where mailboxes reside, _or_ name of file, relative to the
#   home directory.  If you _do_ define both, MAIL_DIR takes precedence.
#   QMAIL_DIR is for Qmail
#
#QMAIL_DIR      Maildir
MAIL_DIR        /var/spool/mail
#MAIL_FILE      .mail

# Password aging controls:
#
#       PASS_MAX_DAYS   Maximum number of days a password may be used.
#       PASS_MIN_DAYS   Minimum number of days allowed between password changes.
#       PASS_MIN_LEN    Minimum acceptable password length.
#       PASS_WARN_AGE   Number of days warning given before a password expires.
#
PASS_MAX_DAYS   180
PASS_MIN_DAYS   1
PASS_MIN_LEN    15
PASS_WARN_AGE   30

#
# Min/max values for automatic uid selection in useradd
#
UID_MIN                   500
UID_MAX                 60000

#
# Min/max values for automatic gid selection in groupadd
#
GID_MIN                   500
GID_MAX                 60000

#
# If defined, this command is run when removing a user.
# It should remove any at/cron/print jobs etc. owned by
# the user to be removed (passed as the first argument).
#
#USERDEL_CMD    /usr/sbin/userdel_local

#
# If useradd should create home directories for users by default
# On RH systems, we do. This option is overridden with the -m flag on
# useradd command line.
#
CREATE_HOME     yes

# The permission mask is initialized to this value. If not specified, 
# the permission mask will be initialized to 022.
UMASK           077

# This enables userdel to remove user groups if no members exist.
#
USERGROUPS_ENAB yes

# Use SHA512 to encrypt password.
ENCRYPT_METHOD SHA512
```

#### Password Hashing
- Stored in /etc/shadow
- Modern Linux uses SHA512 ($6$ prefix in shadow file).
- Example entry in /etc/shadow:
  ```
  user:$6$SALTv3U$HashedPasswordHere:19023:0:99999:7:::
  ```

### References:
- https://man7.org/linux/man-pages/man5/login.defs.5.html
- https://gist.github.com/centminmod/9488921
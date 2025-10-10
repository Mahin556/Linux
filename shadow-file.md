The `/etc/shadow` file stores **secure user account information**, including **hashed passwords** and optional **password aging policies**. Unlike `/etc/passwd`, it is **accessible only to root** (or via SUID-enabled commands like `passwd`).

It plays a crucial role in **authentication** and **password management**.

---

## **1. Purpose of `/etc/shadow`**

* Stores **hashed passwords** for system users.
* Provides **password aging and account expiration info**.
* Enhances security by **separating password hashes from `/etc/passwd`**.
* Prevents unauthorized users from reading password hashes.

---

## **2. Format of `/etc/shadow`**

Each line corresponds to one user and contains **nine fields**, separated by colons `:`:

```
username:password:last_change:min_age:max_age:warn:inactive:expire:reserved
```

### **Fields Explained**

| Field         | Description                                                                                                   |
| ------------- | ------------------------------------------------------------------------------------------------------------- |
| `username`    | Name of the user account (must exist in `/etc/passwd`).                                                       |
| `password`    | Hashed password (or special characters for locked/disabled accounts). Format: `$id$salt$hash`.                |
| `last_change` | Date of last password change (days since Jan 1, 1970). `0` forces change on next login. Empty disables aging. |
| `min_age`     | Minimum days between password changes. `0` means no restriction.                                              |
| `max_age`     | Maximum days password is valid. After this, user must change password.                                        |
| `warn`        | Days before expiration to warn user.                                                                          |
| `inactive`    | Days after password expiration before account is disabled.                                                    |
| `expire`      | Date when account expires (days since Jan 1, 1970).                                                           |
| `reserved`    | Reserved for future use (often empty).                                                                        |

---

## **3. Password Hashing in `/etc/shadow`**

Passwords are **never stored in plain text**. They use a **salted hash**:

```
$ID$SALT$HASH
```

### **Common Algorithms ($id):**

| ID     | Algorithm                                                |
| ------ | -------------------------------------------------------- |
| `$1$`  | MD5                                                      |
| `$2a$` | Blowfish                                                 |
| `$2y$` | Blowfish                                                 |
| `$5$`  | SHA-256                                                  |
| `$6$`  | SHA-512                                                  |
| `$y$`  | yescrypt (modern Linux, scalable, default on Debian 11+) |

**Example entry:**

```
sai:$6$YTJ7JKnfsB4esnbS$5XvmYk2.GXVWhDo2TYGN2hCitD/wU9Kov.uZD8xsnleuf1r0ARX3qodIKiDsdoQA444b8IMPMOnUWDmVJVkeg1:19446:0:99999:7:::
```

* `sai` → username
* `$6$` → SHA-512 hash algorithm
* `YTJ7JKnfsB4esnbS` → salt
* Remaining → encrypted password hash
* `19446:0:99999:7:::` → password aging fields

---

### **Why Use Salt?**

* Prevents identical passwords from producing the same hash.
* Enhances security against dictionary and rainbow table attacks.

---

## **4. Password Verification Process**

1. User enters password at login.
2. System looks up the **salt and hash** in `/etc/shadow`.
3. Combines salt with entered password and hashes it.
4. Compares with stored hash.
5. Login succeeds only if hashes match.

---

## **5. Locked or Disabled Accounts**

* Password field starting with `!` → account is locked.
* Remaining hash is preserved for potential unlocking.

---

## **6. Viewing `/etc/shadow`**

Only root or SUID-enabled commands can access:

```bash
sudo cat /etc/shadow
sudo more /etc/shadow
```

Regular users get **Permission Denied**.

---

## **7. Changing Passwords**

### **For Current User**

```bash
passwd
```

* Uses **SUID-enabled `passwd`** command.
* Updates `/etc/shadow` securely without root access.

### **For Other Users (root only)**

```bash
sudo passwd username
```

---

## **8. Password Aging & Account Expiration**

Use the **`chage`** command to view or set password aging:

```bash
# View aging info
sudo chage -l username

# Set maximum password age
sudo chage -M 90 username

# Force password change on next login
sudo chage -d 0 username

# Set account expiration
sudo chage -E YYYY-MM-DD username
```

### **Key `chage` Options**

| Option | Description                        |
| ------ | ---------------------------------- |
| `-d`   | Last password change               |
| `-E`   | Account expiration date            |
| `-I`   | Inactive days after expiration     |
| `-l`   | Show aging info                    |
| `-m`   | Minimum days between changes       |
| `-M`   | Maximum days for password validity |
| `-W`   | Warning days before expiration     |

---

## **9. Integrity Check**

Use `pwck` to verify `/etc/passwd` and `/etc/shadow` entries:

```bash
sudo pwck -r /etc/passwd
sudo pwck -r /etc/shadow
sudo pwck -r /etc/passwd /etc/shadow
```

---

## **10. Relationship with SUID Commands**

* `/etc/shadow` is **not directly writable** by normal users.
* Commands like `/usr/bin/passwd` have **SUID bit set**, allowing users to **change their own passwords** without root access.
* Example of SUID:

```bash
ls -l /usr/bin/passwd
# -rwsr-xr-x 1 root root ...
```

`s` → SUID, runs with **root privileges**.

---

## **11. Summary**

* `/etc/shadow` stores **secure password hashes and aging info**.
* Only **root or SUID-enabled commands** can read/write.
* Passwords are stored using **salted hashes** (`SHA-512`, `yescrypt`, etc.).
* Password aging and account expiration are controlled via `chage`.
* Commands: `passwd`, `chage`, `pwck` help manage users securely.

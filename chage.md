- The chage command (short for change age) is used to manage user password expiry and account aging information. It allows system administrators to enforce password policies, set expiration dates, and manage account inactivity.
- Requires: Root or sudo privileges to modify other users.
- Files affected: /etc/shadow (where password aging info is stored).

```bash
chage username  #open a interactive mode


# View Account Aging Information
chage -l john #List Account Aging Information
Output shows:
  Last password change
  Password expires
  Password inactive
  Account expires
  Minimum / maximum days between password changes
  Warning period

sudo chage -d 2024-09-01 user1 #Set Last Password Change Date
sudo chage -l user1   # Verify

chage -d 0 rheluser #Force password change at next login

sudo chage -E 2025-12-31 user1 #Set Account Expiry Date
sudo chage -l user1   # Verify

sudo chage -M 90 user1   # Max 90 days between password changes
sudo chage -m 7 user1    # Min 7 days between changes
sudo chage -l user1      # Verify

sudo chage -I 5 user1 # Set Inactivity Period After Password Expiry
sudo chage -l user1   # Verify inactivity period

chage -I -1 rheluser #Reset to default

sudo chage -W 10 user1 # Set Password Expiry Warning
sudo chage -l user1   # Verify warning period

sudo chage -M 90 -m 7 -W 10 -E 2025-12-31 user1 
```

### Password Aging Policy Explained
```bash
Last password change date → Used as reference for expiry calculation.
Password expiry date → Last change + Max days.
Password inactive date → Expiry + Inactivity days. Locks account if password not changed.
Account expiry date → Absolute date when account is disabled.
Minimum days → Minimum days before password can be changed again.
Maximum days → Maximum days password is valid.
Warning days → Days before expiry to notify user.
```

### Example Policy
```bash
User changes password on 1 Jan with policy:
  Min days: 2
  Max days: 20
  Warning: 5
  Inactive: 3
Result:
  Can’t change again till 3 Jan
  Expires on 20 Jan
  Warning starts 16 Jan
  Account locks 23 Jan if password not updated
```

### Default Values from /etc/login.defs
- The default aging policies are defined in /etc/login.defs (used by useradd and chage for new accounts):
| Field           | Description                    | Typical Default       |
| --------------- | ------------------------------ | --------------------- |
| `PASS_MAX_DAYS` | Maximum password age           | 99999 (never expires) |
| `PASS_MIN_DAYS` | Minimum password age           | 0                     |
| `PASS_WARN_AGE` | Warning days before expiration | 7                     |
| `PASS_MIN_LEN`  | Minimum password length        | 8                     |
| `UID_MIN`       | Minimum UID for normal users   | 1000                  |
| `UID_MAX`       | Maximum UID for normal users   | 60000                 |

- Note: These defaults apply only to newly created users. Existing users may have their own settings.


### /etc/default/usermod
| Field         | Description                                                   | Default/Example       |
| ------------- | ------------------------------------------------------------- | --------------------- |
| `UMASK`       | Default file creation mask when modifying accounts            | `022`                 |
| `HOME`        | Default home directory base (used if `-d` not specified)      | `/home`               |
| `SHELL`       | Default login shell                                           | `/bin/bash`           |
| `CREATE_HOME` | Whether to create a home directory when adding/modifying user | `yes`                 |
| `SKEL`        | Default skeleton directory for copying files                  | `/etc/skel`           |
| `GROUP`       | Default primary group for new users (if not specified)        | `users`               |
| `INACTIVE`    | Default inactivity period for password expiry                 | Usually unset or `-1` |
| `EXPIRE`      | Default account expiration                                    | Usually unset         |


### 🔹 **Password Expiration in Linux**

**Password expiration** ensures that users **change their passwords periodically** to maintain system security. Linux supports password aging policies using `chage`, `passwd`, and defaults from `/etc/login.defs`.

---

### **1️⃣ Password Expiration Concepts**

| Concept                  | Description                                                         |
| ------------------------ | ------------------------------------------------------------------- |
| **Maximum password age** | Maximum days a password is valid (`chage -M`)                       |
| **Minimum password age** | Minimum days before a password can be changed (`chage -m`)          |
| **Warning period**       | Days before password expiry when user is warned (`chage -W`)        |
| **Inactive period**      | Days after password expires before account is disabled (`chage -I`) |
| **Account expiration**   | Date when account is disabled (`usermod -e`)                        |

---

### **2️⃣ View Password Expiration Info**

```bash
sudo chage -l USERNAME
```

### **Example**

```bash
sudo chage -l mahin
```

Output:

```
Last password change                                    : Oct 10, 2025
Password expires                                        : Jan 8, 2026
Password inactive                                       : 30
Account expires                                         : never
Minimum number of days between password change          : 7
Maximum number of days between password change          : 90
Number of days of warning before password expires       : 7
```

* **Password expires** → date when the password must be changed.
* **Password inactive** → days after expiry before account is locked.
* **Minimum/Maximum days** → control how often users can or must change passwords.
* **Warning** → system warns user before expiry.

---

### **3️⃣ Set Password Expiration**

#### **1. Set maximum password age**

```bash
sudo chage -M 90 mahin
```

* Password must be changed every 90 days.

#### **2. Set minimum password age**

```bash
sudo chage -m 7 mahin
```

* Users cannot change password for the first 7 days after setting it.

#### **3. Set warning period**

```bash
sudo chage -W 7 mahin
```

* User receives a warning 7 days before password expiry.

#### **4. Set inactivity after expiry**

```bash
sudo chage -I 30 mahin
```

* Account is disabled 30 days after password expires if not changed.

---

### **4️⃣ Default Password Expiration (New Users)**

Default values are defined in `/etc/login.defs`:

| Field           | Description                | Typical Default       |
| --------------- | -------------------------- | --------------------- |
| `PASS_MAX_DAYS` | Maximum password age       | 99999 (never expires) |
| `PASS_MIN_DAYS` | Minimum password age       | 0                     |
| `PASS_WARN_AGE` | Warning days before expiry | 7                     |

> These defaults are used when creating new users with `useradd`. Existing users can be modified with `chage`.

---

### **5️⃣ Force Immediate Password Expiry**

```bash
sudo chage -d 0 mahin
```

* Forces user to **change password on next login**.

---

### **6️⃣ Lock or Disable Accounts Due to Password Expiry**

* **Lock account manually**

```bash
sudo passwd -l mahin
```

* **Unlock account**

```bash
sudo passwd -u mahin
```

* **Expire password immediately**

```bash
sudo chage -E $(date +%Y-%m-%d) mahin
```

---

### **7️⃣ Practical Workflow Example**

```bash
# Set password policies
sudo chage -m 7 -M 90 -W 7 -I 30 mahin

# Force user to change password immediately
sudo chage -d 0 mahin

# Check current status
sudo chage -l mahin
```

---

## **8️⃣ Summary Table**

| Option                  | Command              | Description                                      |
| ----------------------- | -------------------- | ------------------------------------------------ |
| Maximum password age    | `chage -M DAYS USER` | Password must be changed within this many days   |
| Minimum password age    | `chage -m DAYS USER` | Password cannot be changed before this many days |
| Warning before expiry   | `chage -W DAYS USER` | Warn user DAYS before password expires           |
| Inactivity after expiry | `chage -I DAYS USER` | Disable account DAYS after password expires      |
| Force password change   | `chage -d 0 USER`    | User must change password on next login          |

---

**Tip:**
* Combine **password expiration** with **account inactivity** to enforce strict security policies.
* For automation or bulk users, use `chpasswd` + `chage` in scripts.

### References:
- https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/
- https://www.geeksforgeeks.org/linux-unix/chage-command-in-linux-with-examples/
- https://www.computernetworkingnotes.com/linux-tutorials/the-chage-command-examples-and-usages.html
- https://www.computernetworkingnotes.com/linux-tutorials/password-aging-policy-explained-with-chage-command.html
- https://man7.org/linux/man-pages/man1/chage.1.html
- https://www.geeksforgeeks.org/linux-unix/chage-command-in-linux-with-examples/

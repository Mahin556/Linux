`vipw` is a **Linux command** used to safely edit the **`/etc/passwd`** file, which contains user account information. Editing this file directly with a normal text editor is risky, because a syntax error can lock users out. `vipw` prevents that.

* Safely edit **user accounts** stored in `/etc/passwd`.
* Ensures **exclusive lock** on `/etc/passwd` while editing.
* Automatically checks for **syntax errors** before saving.

---

### 2. **Usage**

```bash
sudo vipw
```

* Opens `/etc/passwd` in your default editor (usually `vi`).
* Only one user can edit at a time.

---

### 3. **Editing**

Each line in `/etc/passwd` looks like:

```
username:x:UID:GID:Comment:HomeDirectory:Shell
```

Example:

```
mahin:x:1001:1001:Mahin Raza:/home/mahin:/bin/bash
```

* **username** – Login name
* **x** – Password placeholder (real password in `/etc/shadow`)
* **UID** – User ID
* **GID** – Primary group ID
* **Comment** – Full name or description
* **HomeDirectory** – User’s home path
* **Shell** – Default shell

---

### 4. **Related Commands**

* `vigr` – Safely edit `/etc/group` (group info)
* `vipw -s` – Edit **`/etc/shadow`** safely (password hashes)

---

### 5. **Example**

```bash
sudo vipw
```

* Find the user line:

```
mahin:x:1001:1001:Mahin Raza:/home/mahin:/bin/bash
```

* Change shell:

```
mahin:x:1001:1001:Mahin Raza:/home/mahin:/bin/zsh
```

* Save and exit. Changes take effect immediately.

---

✅ **Tip:** Always use `vipw` instead of directly editing `/etc/passwd` to prevent accidental lockouts.


---
---


## **1. What is `vipw -s`?**

* `vipw -s` is a **Linux command** used to safely edit the **`/etc/shadow` file**.
* `/etc/shadow` stores **password hashes and account expiration info** for users.
* Editing this file directly is **dangerous**; even a small mistake can **lock users out**.
* `vipw -s` ensures **exclusive lock** and **syntax validation**.

---

## **2. Purpose**

* Manage **user passwords** and **account aging information**.
* Works with **hashed passwords**, not plain text.
* Allows editing of:

  * Last password change
  * Minimum/maximum password age
  * Warning period before expiration
  * Account inactivity
  * Expiration date

---

## **3. Usage**

```bash
sudo vipw -s
```

* Opens `/etc/shadow` in your default editor (`vi` usually).

---

## **4. `/etc/shadow` File Format**

Each line in `/etc/shadow`:

```
username:password_hash:last_change:min:max:warn:inactive:expire:reserved
```

**Fields explained:**

| Field           | Description                                           |
| --------------- | ----------------------------------------------------- |
| `username`      | Login name                                            |
| `password_hash` | Hashed password (`$6$...` for SHA-512)                |
| `last_change`   | Days since Jan 1, 1970 when password was last changed |
| `min`           | Minimum days before password can be changed           |
| `max`           | Maximum days password is valid                        |
| `warn`          | Days before expiration to warn user                   |
| `inactive`      | Days after expiration account becomes inactive        |
| `expire`        | Absolute day when account expires                     |
| `reserved`      | Reserved field, usually empty                         |

**Example:**

```
mahin:$6$abc123...:19600:0:99999:7:::
```

* Mahin’s password last changed on day 19600 since Jan 1, 1970
* Minimum password age = 0 days
* Maximum password age = 99999 days
* Warn user 7 days before expiration
* Account never inactive or expired

---

## **5. Editing `/etc/shadow` Safely**

* Open:

```bash
sudo vipw -s
```

* Example: force user to change password next login:

```
mahin:$6$abc123...:19600:0:30:7:::
```

* Here, `max=30` → password expires every 30 days.

* Save and exit (`:wq` in `vi`). Changes take effect **immediately**.

---

## **6. Summary**

* `vipw -s` = safe editing of **hashed passwords and account aging info**.
* Never edit `/etc/shadow` directly.
* Works together with `vipw` and `vigr` for **full user/group management**.


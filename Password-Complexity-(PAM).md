### **Why Configure Password Complexity and Reuse in PAM?**

The goal is to make user passwords **harder to guess** and **safer against brute-force or dictionary attacks**. Without these rules, users often choose weak or reused passwords like `123456`, `password`, or even reuse their last password repeatedly.

By using **PAM modules** (`pam_cracklib.so` or `pam_pwquality.so`), we enforce **system-wide rules** that apply to every user when creating or changing passwords.

---

#### Two Modules:
1. pam_cracklib.so (older, CentOS 6/7, deprecated)
2. pam_pwquality.so (modern, CentOS/RHEL 8+, Ubuntu, Debian)
📌 Files: /etc/pam.d/system-auth, /etc/pam.d/password-auth (RHEL-based)
📌 Config: /etc/security/pwquality.conf (pwquality module)


#### **Reasons for Each Control**

1. **Password Complexity (ucredit, lcredit, dcredit, ocredit)**

   * Forces users to mix **uppercase, lowercase, digits, and symbols**.
   * Example: `MyPass123!` is much harder to crack than `mypassword`.
   * Reduces the risk of **dictionary-based attacks**, since attackers can’t just try common words.

2. **Password Reuse (remember=X)**

   * Prevents users from cycling between the same few passwords (e.g., `Password1` → `Password2` → back to `Password1`).
   * Ensures that if a password was ever compromised, it **can’t be reused**.

3. **Strong Hashing (SHA512 with pam\_unix.so)**

   * Stores passwords in the system using a **secure, salted hash**.
   * Even if `/etc/shadow` is leaked, cracking SHA512 hashes is far harder than older MD5 or DES.

---

### **Why Configure Login Failure Limits (Step 3)?**

This defends against **brute-force login attempts** where an attacker tries thousands of passwords.

* `pam_tally2.so deny=3` means:

  * If someone enters the wrong password **3 times in a row**, the account is **locked**.
  * An administrator must unlock it manually.
  * This stops automated password-guessing tools.

---

### **Step 1: Configure Password Complexity and Reuse in PAM**

Password complexity is enforced through the **PAM (Pluggable Authentication Module)** configuration files:

* **File:** `/etc/pam.d/system-auth`
* **Module used:** `pam_cracklib.so` or `pam_pwquality.so`

**Complexity Controls:**

| Option       | Description                           |
| ------------ | ------------------------------------- |
| `ucredit=-X` | Require at least X uppercase letters. |
| `lcredit=-X` | Require at least X lowercase letters. |
| `dcredit=-X` | Require at least X digits.            |
| `ocredit=-X` | Require at least X symbols.           |
| `remember=X` | Deny reuse of X previous passwords.   |

**Example PAM configuration for complexity:**

```text
password requisite pam_cracklib.so try_first_pass retry=3 minlen=12 ucredit=-2 lcredit=-2 dcredit=-2 ocredit=-2
password sufficient pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5
```

##### Preventing Password Reuse
- Handled by pam_unix.so with remember=X.
- Example (/etc/pam.d/system-auth):
  ```
  password sufficient pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5
  ```
  This prevents reusing the last 5 passwords.


**Explanation:**

* Password must contain **≥2 uppercase, ≥2 lowercase, ≥2 digits, ≥2 symbols**.
* Last **5 passwords** cannot be reused.
* Uses **SHA512 hashing** for strong encryption.

---

### **Step 2: Configure Login Failure Limits**

To prevent brute-force attacks, Linux can **lock accounts** after repeated failed login attempts using **PAM**:

* **File:** `/etc/pam.d/password-auth`
* **Module used:** `pam_tally2.so`

**Key option:**

| Option   | Description                                 |
| -------- | ------------------------------------------- |
| `deny=X` | Lock account after X failed login attempts. |

**Example configuration:**

```text
auth required pam_tally2.so deny=3
account required pam_tally2.so
```

*Admin unlock:
```
pam_tally2 --user username --reset
```

**Explanation:**

* User account is locked after **3 failed login attempts**.
* Administrator must unlock the account manually.

**Combined Example (system-auth):**

```text
# PAM password complexity
password requisite pam_cracklib.so try_first_pass retry=3 ucredit=-2 lcredit=-2 dcredit=-2 ocredit=-2
password sufficient pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5

# PAM login failures
auth required pam_tally2.so deny=3
account required pam_tally2.so
```

#### pam_faillock.so (modern RHEL 7+)
* File: /etc/pam.d/system-auth and /etc/pam.d/password-auth
```bash
auth required pam_faillock.so preauth silent deny=3 unlock_time=600
auth required pam_faillock.so authfail deny=3 unlock_time=600
account required pam_faillock.so
```
- deny=3 → lock after 3 attempts
- unlock_time=600 → unlock after 10 minutes
- Check status:
  ```
  faillock --user username
  ```

---

#### pam_pwquality.so Options (modern)
* Config file: /etc/security/pwquality.conf

| Option             | Description                                                              |
| ------------------ | ------------------------------------------------------------------------ |
| `minlen=N`         | Minimum total password length                                            |
| `minclass=N`       | Require at least N types of character classes (upper/lower/digit/symbol) |
| `ucredit=-X`       | Require ≥ X uppercase                                                    |
| `lcredit=-X`       | Require ≥ X lowercase                                                    |
| `dcredit=-X`       | Require ≥ X digits                                                       |
| `ocredit=-X`       | Require ≥ X symbols                                                      |
| `maxrepeat=N`      | Max number of repeated characters                                        |
| `maxclassrepeat=N` | Max repeated chars from one class                                        |
| `dictcheck=1`      | Prevent dictionary words                                                 |

* Example /etc/security/pwquality.conf:
```bash
minlen = 12
minclass = 4
ucredit = -1
lcredit = -1
dcredit = -1
ocredit = -1
maxrepeat = 3
dictcheck = 1
```

---

### **Summary of Password Policy Implementation**

| Policy Aspect       | Location                   | Mechanism                                         | Notes                                           |
| ------------------- | -------------------------- | ------------------------------------------------- | ----------------------------------------------- |
| Password aging      | `/etc/login.defs`          | `PASS_MAX_DAYS`, `PASS_MIN_DAYS`, `PASS_WARN_AGE` | Only applies to new users.                      |
| Password length     | `/etc/login.defs`          | `PASS_MIN_LEN`                                    | Minimum characters enforced for new users.      |
| Password complexity | `/etc/pam.d/system-auth`   | `pam_cracklib.so` / `pam_pwquality.so`            | Enforces uppercase, lowercase, digits, symbols. |
| Password reuse      | `/etc/pam.d/system-auth`   | `remember=X`                                      | Prevents reusing last X passwords.              |
| Login failures      | `/etc/pam.d/password-auth` | `pam_tally2.so deny=X`                            | Locks account after X failed logins.            |
|                     | `/etc/security/pwquality.conf` |                                               |Used with pam_pwquality.so for modern password complexity enforcement. |

---

✅ **Best Practices:**

1. Use **SHA512** hashing for passwords.
2. Minimum password length: **≥8–12 characters**.
3. Complexity: enforce uppercase, lowercase, digits, symbols.
4. Age passwords every 60–90 days.
5. Warn users **7–14 days** before password expires.
6. Lock accounts after **3–5 failed login attempts**.
7. Deny reuse of at least **5 previous passwords**.


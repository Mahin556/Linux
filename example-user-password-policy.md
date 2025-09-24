### **1. Example Full Policy (RHEL/CentOS 9)**

📌 `/etc/login.defs`

```ini
PASS_MAX_DAYS   90
PASS_MIN_DAYS   7
PASS_WARN_AGE   14
```

📌 `/etc/security/pwquality.conf`

```ini
minlen = 12
minclass = 4
ucredit = -1
lcredit = -1
dcredit = -1
ocredit = -1
maxrepeat = 3
dictcheck = 1
```

📌 `/etc/pam.d/system-auth` (relevant lines)

```bash
# Password quality
password requisite pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=

# Prevent reuse
password sufficient pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5

# Failed login attempts
auth required pam_faillock.so preauth silent deny=3 unlock_time=600
auth required pam_faillock.so authfail deny=3 unlock_time=600
account required pam_faillock.so
```

---

## **2. Verification & Commands**

* View password aging:

```bash
chage -l username
```

* Test failed login lockouts:

```bash
faillock --user username
```

* Reset failed logins:

```bash
faillock --user username --reset
```

* Show password hashes:

```bash
sudo cat /etc/shadow | grep username
```

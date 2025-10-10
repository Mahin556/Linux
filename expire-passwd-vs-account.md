### 🔹 **User Account Expiration in Linux**

**Account expiration** is a way to **automatically disable a user account after a specific date**. This is different from password expiration (which requires users to change their password periodically).

---

## **1️⃣ Using `usermod` to Set Expiration**

### **Syntax**

```bash
sudo usermod -e YYYY-MM-DD USERNAME
```

* `-e` or `--expiredate` → Set the account expiration date.
* `USERNAME` → Target user.

### **Example**

```bash
sudo usermod -e 2025-12-31 mahin
```

* The user `mahin` account will **become disabled after December 31, 2025**.
* User cannot log in after this date.

---

### **Check Expiration Date**

```bash
sudo chage -l mahin
```

Sample output:

```
Account expires                                         : Dec 31, 2025
```

---

## **2️⃣ Using `chage` to Set Expiration**

### **Syntax**

```bash
sudo chage -E YYYY-MM-DD USERNAME
```

### **Example**

```bash
sudo chage -E 2025-12-31 mahin
```

* Same effect as `usermod -e`.
* Useful if you want to **manage all password/account aging in one place**.

---

## **3️⃣ Default Expiration Value**

### **In `/etc/default/usermod`**

```text
EXPIRE=
```

* By default, the field is **empty**, meaning **accounts do not expire** automatically.
* You can set a default expiration for new users by editing this field:

```text
EXPIRE=2025-12-31
```

* When `useradd` or `usermod` creates a new user without specifying `-e`, it will use this date.

### **In `/etc/login.defs`**

* `useradd` may also refer to `/etc/login.defs` for default expiration behavior, but typically `/etc/default/usermod` is preferred for Debian/Ubuntu systems.

---

## **4️⃣ Lock vs Expire**

| Feature                 | Description                                                            |
| ----------------------- | ---------------------------------------------------------------------- |
| **Password Expiration** | Forces user to change password after certain days (`chage -M`)         |
| **Account Expiration**  | Disables user login after a specific date (`usermod -e` or `chage -E`) |
| **Account Lock**        | Immediately prevents login (`usermod -L` or `passwd -l`)               |

---

## **5️⃣ Practical Use Cases**

1. **Temporary accounts**

```bash
sudo useradd tempuser
sudo usermod -e 2025-11-30 tempuser
```

* Account automatically expires after Nov 30, 2025.

2. **Contractor accounts**

```bash
sudo chage -E 2025-10-31 contractor
```

* Forces expiration at the end of the contract.

3. **Check all users with expiration**

```bash
sudo chage -l mahin
```

* View which accounts will expire and when.

---

## **6️⃣ Quick Reference**

| Command                      | Purpose                                          |
| ---------------------------- | ------------------------------------------------ |
| `usermod -e YYYY-MM-DD USER` | Set account expiration date                      |
| `chage -E YYYY-MM-DD USER`   | Same as above                                    |
| `chage -l USER`              | List expiration and aging info                   |
| `/etc/default/usermod`       | Set default expiration for new users (`EXPIRE=`) |

---

💡 **Tip:**

* Expired accounts **cannot log in** until re-enabled:

```bash
sudo usermod -U USERNAME
```

* You can combine expiration with inactivity:

```bash
sudo chage -E 2025-12-31 -I 30 mahin
```

* Account expires on Dec 31, or 30 days after password expiry, whichever comes first.

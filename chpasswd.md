## 🧠 **What is `chpasswd`?**

The **`chpasswd`** command is used by Linux administrators to **update user passwords in bulk** from standard input (stdin) or a file.

It reads **`username:password`** pairs, encrypts the passwords, and updates them in `/etc/shadow`.

---

## ⚙️ **Basic Syntax**

```bash
sudo chpasswd [OPTIONS]
```

Passwords are provided in **`username:password`** format — one pair per line.

---

## 🧾 **Example: Setting a Single User’s Password**

```bash
echo "mahin:MyStrongPass123" | sudo chpasswd
```

✅ This:

* Updates user `mahin`’s password to `MyStrongPass123`
* Encrypts it automatically (using system’s default hashing method — usually SHA-512)
* Updates `/etc/shadow` safely

---

## 🧾 **Example: Setting Multiple Users’ Passwords (Bulk Update)**

Create a file `users.txt`:

```bash
sudo nano users.txt
```

Add:

```
john:Pass123
raza:R@za456
mohit:M0hit789
```

Now run:

```bash
sudo chpasswd < users.txt
```

✅ All listed users’ passwords will be updated in one go.

---

## 🔒 **Encryption & Hashing**

By default, `chpasswd` **encrypts** passwords before storing them.

You can control the **encryption algorithm** using `-e` or `-c` options.

---

## 🧩 **Options (Flags) and Their Meanings**

| Option               | Description                                                                                      |
| -------------------- | ------------------------------------------------------------------------------------------------ |
| `-e`                 | Read **already encrypted passwords** (do not encrypt again). Useful for pre-hashed passwords.    |
| `-c, --crypt-method` | Specify encryption method: `DES`, `MD5`, `SHA256`, `SHA512` (default is SHA512).                 |
| `-m`                 | Encrypt passwords using the system’s default **`crypt()`** method (similar to `--crypt-method`). |
| `-R, --root DIR`     | Apply changes inside a different root directory (used for chroot environments).                  |
| `--md5`              | Use MD5 encryption (deprecated — prefer SHA512).                                                 |
| `--help`             | Show help.                                                                                       |
| `--version`          | Show version.                                                                                    |

---

## 🧰 **Examples with Options**

### 1️⃣ **Using Pre-Encrypted Passwords**

If your password file already has encrypted passwords:

```bash
echo "user1:$6$xyz$encrypted_value_here" | sudo chpasswd -e
```

🔹 `-e` tells `chpasswd` **not** to encrypt again.

---

### 2️⃣ **Using a Specific Hashing Algorithm**

To force SHA-512 hashing:

```bash
echo "mahin:MyPass@123" | sudo chpasswd --crypt-method SHA512
```

To use SHA256:

```bash
echo "raza:R@za456" | sudo chpasswd --crypt-method SHA256
```

---

### 3️⃣ **For Chroot Environment**

When managing users inside a chroot or another mounted system:

```bash
sudo chpasswd -R /mnt/systemroot
```

---

### 4️⃣ **Dry Run (Preview only)**

`chpasswd` itself doesn’t have a dry-run mode, but you can preview your input file:

```bash
cat users.txt
```

and then feed it into `sudo chpasswd` only when verified.

---

## 🧾 **Practical Use Cases**

| Use Case                    | Example Command                       |                |
| --------------------------- | ------------------------------------- | -------------- |
| Reset password for one user | `echo "user1:NewPass"                 | sudo chpasswd` |
| Bulk update passwords       | `sudo chpasswd < users.txt`           |                |
| Use encrypted password      | `sudo chpasswd -e < encrypted.txt`    |                |
| Change encryption type      | `sudo chpasswd --crypt-method SHA512` |                |
| Reset passwords in chroot   | `sudo chpasswd -R /mnt/root`          |                |

---

## 🧠 **File Permissions and Security Notes**

⚠️ The `users.txt` file must be **owned by root** and **have 600 permissions**:

```bash
sudo chmod 600 users.txt
sudo chown root:root users.txt
```

⚠️ Avoid storing plaintext passwords permanently.
Delete the input file after use:

```bash
sudo shred -u users.txt
```

---

## 🧩 **`/etc/shadow` Update**

After running `chpasswd`, check the entry in `/etc/shadow`:

```bash
sudo grep mahin /etc/shadow
```

Output example:

```
mahin:$6$u3a9Tkjz$Kz3xOQk1KZ7p1tK...:19876:0:99999:7:::
```

The `$6$` prefix indicates **SHA-512** encryption.

---

## ✅ **Summary Table**

| Task                    | Command Example                              |                |
| ----------------------- | -------------------------------------------- | -------------- |
| Single user password    | `echo "user:pass"                            | sudo chpasswd` |
| Bulk user update        | `sudo chpasswd < users.txt`                  |                |
| Use encrypted passwords | `sudo chpasswd -e < file`                    |                |
| Use SHA-512 encryption  | `sudo chpasswd --crypt-method SHA512 < file` |                |
| Change root directory   | `sudo chpasswd -R /mnt/root < file`          |                |
| Show help               | `chpasswd --help`                            |                |

---

## 🔐 **Exit Status Codes**

| Code | Meaning                |
| ---- | ---------------------- |
| `0`  | Success                |
| `1`  | Syntax or input error  |
| `2`  | Password update failed |

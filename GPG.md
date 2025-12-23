# 🔐 **FULL GPG (GNU Privacy Guard) VERIFICATION TUTORIAL**

---

## ⭐ **WHAT GPG IS**

* **GPG = Open-source implementation of OpenPGP standard.**
* Provides:

  * **Integrity** → Detects file tampering
  * **Authentication** → Confirms the identity of the signer
  * **Encryption** → (Optional) for secure file sharing

For verification, we mainly use **signing** and **signature verification**.

---

# 📌 **1. GPG Installation**

```
# Debian/Ubuntu
sudo apt install gnupg

# RHEL/CentOS/Fedora
sudo dnf install gnupg

# Arch
sudo pacman -S gnupg
```

---

# 📌 **2. CHECK IF GPG IS INSTALLED**

```
gpg --version
```

---

# 📌 **3. BASIC GPG CONCEPTS (VERY IMPORTANT)**

* **Public key** → Distributed publicly; used for **verification**
* **Private key** → Kept secret; used for **signing**
* **Signature (.asc or .sig)** → File proving authenticity
* **Key Fingerprint** → Unique identifier of a key
* **Key Servers** → Where public keys are uploaded

---

# 📌 **4. Download Typical Files**

Usually developers give:

* `file.tar.gz` → Main file
* `file.tar.gz.asc` or `file.tar.gz.sig` → GPG signature
* `publickey.asc` → Their public key
* “Fingerprint” → For verification

Example:

```
curl -O https://example.com/app.tar.gz
curl -O https://example.com/app.tar.gz.asc
curl -O https://example.com/publickey.asc
```

---

# 📌 **5. Import the Public Key**

```
gpg --import publickey.asc
```

---

# 📌 **6. CHECK THE KEY YOU IMPORTED**

```
gpg --list-keys
```

---

# 📌 **7. VERIFY KEY FINGERPRINT (CRITICAL STEP)**

Developers publish their **fingerprint** like:

```
AB12 CD34 EF56 7890 AB12  CD34 EF56 7890 AB12 CD34
```

Check fingerprint:

```
gpg --fingerprint "Developer Name or KeyID"
```

**If fingerprint does NOT match → DO NOT TRUST the key or the file.**

---

# 📌 **8. VERIFY THE SIGNATURE**

Two possible signature types:

### ✔ If signature is `.asc`

```
gpg --verify file.tar.gz.asc file.tar.gz
```

### ✔ If signature is `.sig`

```
gpg --verify file.tar.gz.sig file.tar.gz
```

---

# 📌 **9. UNDERSTANDING THE OUTPUT**

### ✔ GOOD signature (this means integrity is OK)

```
gpg: Signature made Fri 01 Mar 2024 using RSA key ID ABC123
gpg: Good signature from "Developer Name <dev@site.com>"
```

### 🚨 Warning you MUST still verify fingerprint:

```
gpg: WARNING: This key is not certified with a trusted signature!
```

This is normal, unless you signed the key with your own key.

---

# 📌 **10. BAD SIGNATURE (FILE TAMPERED)**

```
gpg: BAD signature from "Developer Name"
```

This means:

* File is corrupted
* File has been tampered
* Wrong file version
* Wrong signature

**Do NOT use the file.**

---

# 📌 **11. VERIFY USING KEY SERVERS**

Sometimes you do not have a `.asc` public key file.

You can fetch via:

```
gpg --keyserver keyserver.ubuntu.com --recv-keys <KEY-ID>
```

Example:

```
gpg --keyserver keyserver.ubuntu.com --recv-keys EF567890AB12CD34
```

Other key servers:

* hkps://keys.openpgp.org
* hkps://keys.openpgp.net

---

# 📌 **12. TRUST LEVELS & OWNER TRUST**

### See trust status:

```
gpg --list-keys --with-colons
```

### Set trust (optional):

```
gpg --edit-key <KEY-ID>
trust
5   # ultimate trust (ONLY IF IT IS YOUR OWN KEY!)
quit
```

---

# 📌 **13. EXPORT YOUR PUBLIC KEY (IF YOU SIGN FILES)**

```
gpg --export -a "Your Name" > mypublickey.asc
```

---

# 📌 **14. CREATE YOUR OWN SIGNATURE (OPTIONAL)**

### Detached signature:

```
gpg --detach-sign file.tar.gz
```

Creates:

```
file.tar.gz.sig
```

### ASCII signature:

```
gpg --armor --detach-sign file.tar.gz
```

Creates:

```
file.tar.gz.asc
```

---

# 📌 **15. SIGN AND ENCRYPT A FILE (BONUS)**

```
gpg --armor --sign --encrypt --recipient user@example.com file.txt
```

---

# 📌 **16. DECRYPT FILE**

```
gpg --decrypt file.txt.gpg
```

---

# 📌 **17. Delete Imported Key**

```
gpg --delete-key <KEY-ID>
```

---

# 📌 **18. Remove private key (if you created one)**

```
gpg --delete-secret-key <KEY-ID>
```

---

# 📌 **19. ADVANCED — VERIFY SIGNED CHECKSUMS**

Common format:

```
SHA256 (file.tar.gz) = HASHVALUE
```

Signature file:

```
SHA256SUMS.asc
```

### Verify:

```
gpg --verify SHA256SUMS.asc
sha256sum -c SHA256SUMS
```

---

# 📌 **20. CHEAT SHEET (SUPER QUICK REFERENCE)**

```
gpg --import key.asc                     # Import key
gpg --verify sig.asc file                # Verify signature
gpg --fingerprint KEY                    # Check fingerprint
gpg --keyserver keyserver.ubuntu.com --recv-keys KEY-ID
gpg --delete-key KEY                     # Remove key
gpg --detach-sign file                   # Create .sig signature
gpg --armor --detach-sign file           # Create ASCII .asc signature
gpg --list-keys                          # List keys
gpg --list-secret-keys                   # List private keys
```



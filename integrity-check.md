**• Integrity checking means confirming that the file you downloaded is exactly what the publisher intended, with no corruption or tampering.**

**• Publishers provide a SHA-256 checksum (a 64-character hash).
Example: `b2c3df44e86f9e7c35d8902c50f1c4f1b25c9a0c443a3af949d35e2c1fe136aa`**

**• Your job is to compute the SHA-256 hash of the downloaded file and compare it with the official hash.
If both match → file is clean and intact.
If they differ → file is corrupted or tampered with.**

---

### **Linux / macOS Method: `sha256sum`**

**• Navigate to the folder containing the downloaded file**
`cd /path/to/file`

**• Compute the SHA-256 hash of the file**

```
sha256sum filename.iso
```

**• Output example:**
`b2c3df44e86f9e7c35d8902c50f1c4f1b25c9a0c443a3af949d35e2c1fe136aa  filename.iso`

**• Compare this value manually with the checksum given on the official website.**

---

### **Windows (PowerShell) Method: `Get-FileHash`**

**• Open PowerShell → Run:**

```
Get-FileHash .\filename.iso -Algorithm SHA256
```

**• Sample output:**

```
Algorithm : SHA256
Hash      : B2C3DF44E86F9E7C35D8902C50F1C4F1B25C9A0C443A3AF949D35E2C1FE136AA
Path      : C:\Users\User\Downloads\filename.iso
```

**• Compare the displayed Hash with the official one.**

---

### **How to Compare Automatically (Linux/macOS)**

**• Save the official checksum in a file named `file.sha256`**
Content example:
`b2c3df44e86f9e7c35d8902c50f1c4f1b25c9a0c443a3af949d35e2c1fe136aa  filename.iso`

**• Run:**

```
sha256sum -c file.sha256
```

**• Output:**
`filename.iso: OK`
or
`filename.iso: FAILED`

---

### **How to Compare Automatically (Windows)**

**• Save official hash in a file manually.
Then calculate file hash:**

```
$myhash = (Get-FileHash .\filename.iso -Algorithm SHA256).Hash
```

**• Compare with official hash:**

```
if ($myhash -eq "B2C3DF44E86F9E7C35D8902C50F1C4F1B25C9A0C443A3AF949D35E2C1FE136AA") {
    "MATCH — File is valid"
} else {
    "MISMATCH — File is corrupted"
}
```

---

### **Verify Against Multiple Algorithms**

**• Recommended only for critical files**

```
sha1sum filename.iso
sha512sum filename.iso
md5sum filename.iso
```

---

### **Common Mistakes**

**• Using wrong file name or wrong folder**
**• Comparing SHA-256 with MD5/SHA-1 values**
**• Copy-paste errors**
**• Hidden newline in downloaded checksum file (fix by manual compare)**

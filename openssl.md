# 🔑 How to Generate a CSR with OpenSSL

- A **Certificate Signing Request (CSR)** is a file you generate on your server before getting an SSL certificate.
- It contains your domain, organization details, and public key — which a Certificate Authority (CA) uses to issue your SSL certificate.

---
## 📝 Steps to Generate a CSR

### 1. Check OpenSSL version

```bash
openssl version -a
```
---

### 2. Create a private key and CSR

Run this in your terminal (replace `example.com` with your domain):

```bash
openssl req -new -newkey rsa:2048 -nodes -keyout example.com.key -out example.com.csr
```

This generates:

* `example.com.key` → your private key (keep safe, don’t share)
* `example.com.csr` → your CSR file (send to CA)

---

### 3. Fill in the CSR details

You’ll be prompted for info such as:

* **Country Name** → 2-letter code (e.g., `US`, `IN`)
* **State/Province** → full state name
* **Locality (City)**
* **Organization Name** → your company/legal entity
* **Organizational Unit** → department (optional)
* **Common Name** → your domain (e.g., `example.com` or `www.example.com`)
* **Email Address** → contact email

---

### 4. Verify your CSR

Check that everything looks correct:

```bash
openssl req -text -in example.com.csr -noout -verify
```

---

### 5. Submit CSR to CA

* Open the `.csr` file in a text editor:

  ```bash
  cat example.com.csr
  ```
* Copy everything (including `-----BEGIN CERTIFICATE REQUEST-----` and `-----END CERTIFICATE REQUEST-----`).
* Paste or upload it when requesting your SSL certificate from a Certificate Authority.

---

### Creating a self signed certificates
```
openssl req -newkey  rsa:4096 -nodes -sha256 -keyout private.key -x509 -days 365 -out domain.crt
```

---

## 📌 After You Get the SSL Certificate

* Keep the `.key` file on your server.
* Install the `.crt` (certificate) file you get from the CA.
* Verify your certificate with:

  ```bash
  openssl x509 -text -in example.com.crt -noout
  ```
---

## 1. 🔎 General Information

```bash
openssl version          # Show OpenSSL version
openssl version -a       # Show version + build options
openssl list -commands   # List all available commands
openssl list -cipher-commands   # List cipher commands
openssl list -digest-commands   # List digest/hash commands
openssl help             # General help
```

---

## 2. 🔑 Key Management

### Generate Private Keys

```bash
openssl genrsa -out key.pem 2048        # Generate 2048-bit RSA private key
openssl genpkey -algorithm RSA -out key.pem -pkeyopt rsa_keygen_bits:2048
openssl ecparam -genkey -name prime256v1 -out ec_key.pem   # Generate EC key
openssl genpkey -algorithm ED25519 -out ed25519_key.pem    # Ed25519 key
```

### View Keys

```bash
openssl rsa -in key.pem -check          # Check RSA private key
openssl rsa -in key.pem -pubout -out pubkey.pem   # Extract public key
openssl pkey -in key.pem -pubout        # Extract public key (generic)
```

---

## 3. 📜 Certificate Signing Requests (CSR)

### Generate CSR + Key

```bash
openssl req -new -newkey rsa:2048 -nodes -keyout domain.key -out domain.csr
```

### View CSR

```bash
openssl req -in domain.csr -noout -text
```

---

## 4. 📄 X.509 Certificates

### Self-Signed Certificate

```bash
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes
```

### View Certificate

```bash
openssl x509 -in cert.pem -noout -text       # Full details
openssl x509 -in cert.pem -noout -dates      # Validity dates
openssl x509 -in cert.pem -noout -issuer     # Issuer
openssl x509 -in cert.pem -noout -subject    # Subject
openssl x509 -in cert.pem -fingerprint       # 
openssl x509 -in certificate.crt -noout -enddate #Show expire date
openssl x509 -in certificate.crt -noout -serial #Show Serial number
openssl x509 -in certificate.crt -noout -fingerprint #Show fingerprint in SHA1
openssl x509 -in certificate.crt -noout -fingerprint -sha256 #Show fingerprint in SHA256
openssl x509 -in certificate.crt -noout -pubkey #Show public key info

#Check certificate and private key match
openssl x509 -in certificate.crt -noout -modulus | openssl md5
openssl rsa  -in private.key      -noout -modulus | openssl md5

openssl x509 -in certificate.crt -noout -ext subjectAltName #Check SANs (DNS/IP entries)

openssl x509 -in certificate.crt -noout -text | grep "Public Key Algorithm" #Check certificate type / algorithm

openssl x509 -in certificate.crt -noout -subject -issuer -dates
```

### Verify Certificate

```bash
openssl verify -CAfile ca.pem cert.pem
```

---

## 5. 🔒 Encrypt / Decrypt Data

### Symmetric Encryption

```bash
openssl enc -aes-256-cbc -salt -in file.txt -out file.enc
openssl enc -aes-256-cbc -d -in file.enc -out file.txt
```

### Base64 Encode/Decode

```bash
openssl base64 -in file.txt -out file.b64
openssl base64 -d -in file.b64 -out file.txt
```

---

## 6. 🧾 Hashing & Message Digests

```bash
openssl dgst -sha256 file.txt
openssl dgst -sha512 file.txt
openssl dgst -md5 file.txt
```

---

## 7. ✍️ Digital Signatures

```bash
openssl dgst -sha256 -sign privkey.pem -out file.sig file.txt
openssl dgst -sha256 -verify pubkey.pem -signature file.sig file.txt
```

---

## 8. 📦 PKCS#12 / Keystore Management

### Convert PEM to PKCS#12

```bash
openssl pkcs12 -export -out cert.p12 -inkey key.pem -in cert.pem -certfile ca.pem
```

### Extract from PKCS#12

```bash
openssl pkcs12 -in cert.p12 -clcerts -nokeys -out cert.pem    # Extract cert
openssl pkcs12 -in cert.p12 -nocerts -out key.pem             # Extract key
```

---

## 9. 🌐 SSL/TLS Utilities

### Check SSL/TLS of a Server

```bash
openssl s_client -connect example.com:443
openssl s_client -connect example.com:443 -servername example.com
```

### Show Available Ciphers

```bash
openssl ciphers -v | column -t
```

---

## 10. 🔄 Conversions

```bash
openssl x509 -in cert.der -inform DER -out cert.pem -outform PEM   # DER → PEM
openssl x509 -in cert.pem -out cert.der -outform DER               # PEM → DER
openssl rsa -in key.pem -outform DER -out key.der                  # Private key PEM → DER
```

---

## 11. 🔧 Random Numbers

```bash
openssl rand -base64 32   # Generate 32 random bytes (Base64)
openssl rand -hex 16      # Generate 16 random bytes (hex)
```

---

## 12. 🔑 Diffie-Hellman (DH) Params

```bash
openssl dhparam -out dhparam.pem 2048
```

### Reference
- https://phoenixnap.com/kb/generate-openssl-certificate-signing-request

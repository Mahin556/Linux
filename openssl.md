Got it 👍 You want a **simpler, clean version** of "How to Generate CSR with OpenSSL".
Here’s a **straightforward guide** without extra clutter:

---

# 🔑 How to Generate a CSR with OpenSSL

A **Certificate Signing Request (CSR)** is a file you generate on your server before getting an SSL certificate.
It contains your domain, organization details, and public key — which a Certificate Authority (CA) uses to issue your SSL certificate.

---

## ✅ Prerequisites

* Linux server (local or remote, via SSH)
* OpenSSL installed (`openssl version`)
* Root/sudo access

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

## 📌 After You Get the SSL Certificate

* Keep the `.key` file on your server.
* Install the `.crt` (certificate) file you get from the CA.
* Verify your certificate with:

  ```bash
  openssl x509 -text -in example.com.crt -noout
  ```

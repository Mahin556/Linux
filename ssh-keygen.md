* `ssh-keygen` is the Linux command used to:
    * Generate SSH key pairs
    * Convert keys
    * Change key passphrases
    * View fingerprints
    * Create certificates
    * Manage known_hosts

Key generated in `~/.ssh/`

| Key Type    | Recommended | Reason               |
| ----------- | ----------- | -------------------- |
| **Ed25519** | ⭐ BEST      | Fast, modern, small  |
| RSA 4096    | ✔ Very Good | Max compatibility    |
| ECDSA       | ⚠️ OK       | Not widely supported |
| DSA         | ❌ No        | Deprecated           |

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```
```bash
journalctl -u sshd
```

```bash
ssh-keygen #Default RSA key pair

ssh-keygen -t rsa -b 4096 #RSA 4096 bit key

ssh-keygen -t ed25519 #ED25519 key , modern, most secure

ssh-keygen -t ecdsa -b 521 #ECDSA 521 bit (less common)

ssh-keygen -t dsa #DSA (deprecated — DO NOT USE)

ssh-keygen -f ~/.ssh/myserver_key #Custom name

ssh-keygen -t ed25519 -C "my secure key" -f ~/.ssh/id_mykey #Ass key passphrase
Enter passphrase (empty for no passphrase):

ssh-keygen -t rsa -C "mahin@laptop" #Add commet to key (Comment stored inside .pub file.)

ssh-keygen -p -f ~/.ssh/id_rsa #change passphrase

ssh-keygen -p -f ~/.ssh/id_rsa -P oldpass -N "" #remove passphrase

ssh-keygen -l -f ~/.ssh/id_rsa.pub #Display fingerprint
ssh-keygen -l -E sha256 -f ~/.ssh/id_rsa.pub #SHA-256 fingerprint
ssh-keygen -l -E md5 -f ~/.ssh/id_rsa.pub #MD5 format

ssh-keygen -p -m PEM -f ~/.ssh/id_rsa #Convert OpenSSH → PEM
ssh-keygen -p -m RFC4716 -f ~/.ssh/id_rsa #Convert PEM → OpenSSH

ssh-keygen -R server.example.com #Remove host entry from know_hosts file
ssh-keygen -F server.example.com #Add host entry from know_hosts file

ssh-keygen -A #Generate a Host Key (server-side) --> Creates missing host keys in /etc/ssh/.

ssh-keygen -y -f ~/.ssh/id_rsa > id_rsa.pub #Extract a public key from private key

ssh-keygen -lf ~/.ssh/id_rsa #check ssh key weakness
#Weak keys:
#DSA
#RSA < 2048-bit
#ECDSA 256-bit


ssh-keygen -t ed25519 -C "github-key" #Create key for github

ssh-keygen -t rsa -b 4096 -C "aws-key" -f aws-ec2 #Generate key for aws ec2
ssh -i aws_ec2.pem ec2-user@public-ip


```

| Option          | Description                         |
| --------------- | ----------------------------------- |
| `-t type`       | Key type (rsa, ed25519, ecdsa)      |
| `-b bits`       | Key size                            |
| `-C comment`    | Add comment                         |
| `-f filename`   | Specify key file name               |
| `-N passphrase` | New passphrase                      |
| `-P passphrase` | Old passphrase                      |
| `-m format`     | Key format (PEM, RFC4716)           |
| `-p`            | Change passphrase                   |
| `-q`            | Quiet mode                          |
| `-y`            | Extract public key from private key |
| `-l`            | Show fingerprint                    |
| `-E hash`       | Hash algorithm (md5, sha256)        |
| `-R hostname`   | Remove from known_hosts             |
| `-F hostname`   | Search known_hosts                  |
| `-H`            | Hash known_hosts                    |
| `-A`            | Create missing host keys            |
| `-s key`        | CA signing key                      |
| `-I keyID`      | Certificate identity                |
| `-n principals` | Allowed login names                 |
| `-h`            | Host certificate                    |
| `-V validity`   | Cert validity period                |
| `-D pkcs11`     | PKCS#11 support                     |


---

✔ SSH Certificate Authority (CA)
✔ Creating a CA key
✔ Signing user certificates
✔ Signing host certificates
✔ How SSH certificates work internally
✔ How to configure servers to trust your CA
✔ How to configure clients to trust host CA
✔ Full workflow used in enterprises & DevOps

This is the **complete SSH CA chapter**.


# 🪪 **SSH CERTIFICATE AUTHORITY (CA) — FULL DETAILED GUIDE**

SSH Certificates allow you to use **one CA key** to authenticate:

* users
* hosts
* servers
* DevOps engineers
* administrators

Instead of managing **thousands of SSH keys**, you only manage *one* CA key.

Used by:

* Facebook
* Netflix
* Google
* Large enterprises
* Zero-trust systems
* OpenSSH advanced deployments



# 🔥 **Why Use SSH Certificates Instead of Regular SSH Keys?**

### 🧨 Problem With Traditional SSH Keys:

* Every server stores keys in `~/.ssh/authorized_keys`
* Users generate keys manually
* Keys expire *never*
* No central control
* Compromise = huge security issue
* Scaling to 1000+ servers is painful

### ✔ SSH Certificates Solve All These Problems:

* Keys expire automatically
* No need to distribute public keys
* Central authority (CA) issues signed keys
* One CA can sign thousands of users and hosts
* Servers trust the CA, not individuals
* Easy user revocation
* Access can be time-limited (e.g., 8 hours)


# 📌 **1. What is an SSH Certificate?**

An SSH certificate is a **public key + metadata**, signed by a **Certificate Authority (CA)** private key.

The certificate contains:

* valid user names
* expiry time
* allowed hosts
* allowed commands
* certificate ID
* optional restrictions
* principal names (usernames)

The server trusts the **CA**, not the user's standalone key.


# 📌 **2. Create the CA Key**

You need **one CA private key** used only for signing.

```
ssh-keygen -t rsa -b 4096 -f ca_key
```

This generates:

```
ca_key        → CA Private key  (KEEP SECRET)
ca_key.pub    → CA Public key   (distribute to servers)
```

⚠️ **The CA private key must remain extremely secure.**
Store in:

* secure vault
* HSM
* offline machine


# 📌 **3. Trust the CA on SSH Servers**

On every server, configure SSH to trust this CA:

Edit:

```
sudo nano /etc/ssh/sshd_config
```

Add:

```
TrustedUserCAKeys /etc/ssh/ca_key.pub
```

Copy the CA public key:

```
sudo cp ca_key.pub /etc/ssh/
sudo systemctl restart ssh
```

Now this server trusts **any user key signed by your CA**.


# 📌 **4. SIGNING USER KEYS (User Certificates)**

User has:

```
~/.ssh/id_rsa.pub
```

Admin signs it with CA:

```
ssh-keygen -s ca_key -I user_cert -n ubuntu ~/.ssh/id_rsa.pub
```

Explanation:

| Option         | Meaning                                   |
| -------------- | ----------------------------------------- |
| `-s ca_key`    | Signing key (CA private key)              |
| `-I user_cert` | Certificate ID                            |
| `-n ubuntu`    | Principal (username allowed to log in as) |
| `id_rsa.pub`   | User’s public key to be signed            |

### Output:

```
id_rsa-cert.pub
```

This file is the **SSH certificate**.

User logs in with:

```
ssh -i id_rsa -i id_rsa-cert.pub ubuntu@server
```


# 📌 **5. Adding Expiration Time to User Certificates**

Example: Expire in 8 hours

```
ssh-keygen -s ca_key -I mahin-dev -n ubuntu \
    -V +8h ~/.ssh/id_rsa.pub
```

Validities:

* `+2h` → 2 hours
* `+1d` → 1 day
* `+52w` → 1 year


# 📌 **6. Limit Which Servers User Can Access**

Allow user only on specific hosts:

```
ssh-keygen -s ca_key -I user-cert \
    -n ubuntu \
    -h \
    -O host=server1.example.com \
    ~/.ssh/id_rsa.pub
```


# 📌 **7. Restrict Commands (Force Command)**

User can only run a specific command:

```
ssh-keygen -s ca_key -I backup \
    -n ubuntu \
    -O force-command="/usr/local/bin/backup.sh" \
    ~/.ssh/id_rsa.pub
```

Good for:

* automation
* backup systems
* monitoring bots


# 📌 **8. Restrict from Agent/PTY**

Disable port forwarding, X11, agent forwarding:

```
-O no-port-forwarding
-O no-agent-forwarding
-O no-pty
```

Example:

```
ssh-keygen -s ca_key -I bot \
    -n ubuntu \
    -O no-pty \
    -O no-agent-forwarding \
    ~/.ssh/id_rsa.pub
```


# 📌 **9. SIGNING HOST KEYS (Host Certificates)**

Host certificates allow clients to verify the server identity.

```
ssh-keygen -s ca_key -I host_cert \
    -h \
    -n server1.example.com \
    /etc/ssh/ssh_host_rsa_key.pub
```

Explanation:

| Option                          | Meaning                                |
| ------------------------------- | -------------------------------------- |
| `-h`                            | Host certificate (for server identity) |
| `-n server1.example.com`        | Allowed DNS name                       |
| `/etc/ssh/ssh_host_rsa_key.pub` | Host public key                        |

Output:

```
ssh_host_rsa_key-cert.pub
```

Place it in `/etc/ssh/`.


# 📌 **10. Trust Host CA on Clients**

On client machines:

Edit:

```
nano ~/.ssh/config
```

Add:

```
Host *
    HostkeyAlgorithms ssh-rsa-cert-v01@openssh.com
    CertificateFile /etc/ssh/host_ca.pub
```

OR centralized:

```
sudo nano /etc/ssh/ssh_known_hosts
```

Add:

```
@cert-authority *.example.com ssh-rsa AAAAB3Nza...
```


# 📌 **11. Authentication Flow (Detailed)**

### **User Authentication Flow:**

1. User presents:

   * private key
   * public certificate (`id_rsa-cert.pub`)
2. Server checks:

   * certificate signature via CA public key
   * certificate expiration
   * principals
   * restrictions
3. If valid → access granted
4. If any field invalid → reject

### **Host Authentication Flow:**

1. Client connects to server
2. Server provides:

```
ssh_host_rsa_key-cert.pub
```

3. Client checks:

   * signed by trusted host CA?
   * DNS matches?
   * certificate valid?
4. If valid → no fingerprint warning
5. Client trusts server automatically


# 📌 **12. Real-world Enterprise Workflow**

### Step 1 — Administrator generates CA

### Step 2 — Distributes CA public key to all servers

### Step 3 — Users generate their own SSH keys

### Step 4 — Admin signs each user key

### Step 5 — Users authenticate using certificates

### Step 6 — Expired certificates stop working automatically

### Step 7 — Revocation is instant (just don’t reissue certificate)


# 📌 **13. Revoking SSH Certificates**

OpenSSH uses **`revoked_keys`** file.

Add certificate to revoked list:

```
echo "id_rsa-cert.pub" >> /etc/ssh/revoked_keys
```

Add in sshd_config:

```
RevokedKeys /etc/ssh/revoked_keys
```

Restart SSH:

```
sudo systemctl restart ssh
```


# 📌 **14. How Enterprises Use SSH CA**

Examples:

### Netflix

* Signs user keys for 8 hours
* No permanent authorized_keys
* Zero-trust access

### Facebook

* Host and user certificates
* CA stored in HSM
* Automated key rotation

### AWS SSM + EC2

* Uses certificate-based ephemeral access


# 📌 **15. Quick Command Summary**

| Purpose            | Command                                                                       |
| ------------------ | ----------------------------------------------------------------------------- |
| Create CA key      | `ssh-keygen -t rsa -b 4096 -f ca_key`                                         |
| Sign user key      | `ssh-keygen -s ca_key -I user -n ubuntu id_rsa.pub`                           |
| Sign host key      | `ssh-keygen -s ca_key -I host -h -n server1.example.com ssh_host_rsa_key.pub` |
| Valid for 1 day    | `-V +1d`                                                                      |
| Restrict commands  | `-O force-command=/path/script`                                               |
| Disable forwarding | `-O no-pty -O no-agent-forwarding`                                            |

---


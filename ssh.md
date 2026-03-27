* SSH --> Secure shell
* A cryptographic protocol used to:
    * Log in to remote servers
    * Execute commands remotely
    * Transfer files securely
    * Forward ports
    * Automate DevOps tasks
* Default Port --> 22

* **How SSH Works Internally**
* SSH uses three types of security:
    * Symmetric Encryption
        * Used during the connection for speed.
        * Examples:
          * AES
          * ChaCha20
    * Asymmetric Encryption
        * Used for authentication + key exchange.
        * Examples:
          * RSA
          * ECDSA
          * Ed25519
    * Hashing (Integrity)
        * Ensures data has not been modified.
        * Examples:
          * SHA-256
          * SHA-1

* **Authentication Methods**
  * Password Authentication
  * Public Key Authentication (MOST SECURE)
  * Host-based Authentication
  * Keyboard-interactive

* **SSH Directory Structure**
    ```bash
    ~/.ssh/
    ```
    | File            | Purpose                                  |
    | --------------- | ---------------------------------------- |
    | id_rsa          | Private key                              |
    | id_rsa.pub      | Public key                               |
    | authorized_keys | Server stores client public keys         |
    | known_hosts     | Stores fingerprints of connected servers |
    | config          | Client-side configuration                |

    ```bash
    /etc/ssh
    ```

    ```bash
    ls /etc/ssh/

    moduli      ssh_config.d        ssh_host_ecdsa_key.pub  ssh_host_ed25519_key.pub  ssh_host_rsa_key.pub  sshd_config    sshd_config.ucf-dist
    ssh_config  ssh_host_ecdsa_key  ssh_host_ed25519_key    ssh_host_rsa_key          ssh_import_id         sshd_config.d
    ```

```bash
ssh user@server-ip #To connect to the remote server

ssh -p 2222 user@server-ip #Connect to the specific port

ssh user@server-ip "ls -l /var/www" #Execute command

ssh -i ~/.ssh/mykey.pem user@server-ip #Use specific private key

ssh -vvv user@server-ip #increased verbosity used for debugging

ssh user@server "sed -i '/YOUR_PUBLIC_KEY_CONTENT/d' ~/.ssh/authorized_keys" #Remove Your Key from Remote Server

cat ~/.ssh/id_rsa.pub | ssh user@server-ip "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

journalctl -u ssh

nc -zv host 22

ssh -J user@bastion user@private-server #Proxy Jump
ssh -J user@b1,user@b2 user@target #Multi-Hop Jump

ssh -o ProxyCommand="ssh -W %h:%p user@bastion" user@private-server #Using ProxyCommand (Old Method)
```

---

```bash
vim ~/.ssh/config
```
```bash
Host myserver
    HostName 192.168.1.10
    User ubuntu
    Port 22
    IdentityFile ~/.ssh/id_rsa
```
```bash
ssh myserver
```
---

#### Use ProxyJump in SSH Config

* `~/.ssh/config`
  ```bash
  Host bastion
      HostName bastion-ip
      User ubuntu

  Host private1
      HostName 10.0.1.10
      User ubuntu
      ProxyJump bastion
  ```
  ```bash
  ssh private1
  ```

---

### Private server in private subnet 
```bash
PasswordAuthentication no
PermitRootLogin no
AllowUsers ubuntu
```
* Only allow limited user.
* Set Firewall rules that only allow bastion host to SSH.

---

#### Errors
* Permission denied (publickey,password)
    * Ensure password auth is allowed in /etc/ssh/sshd_config:
        ```bash
        PasswordAuthentication yes
        ```

* Remote user has no home directory
    ```bash
    sudo mkdir -p /home/user/.ssh
    sudo chown user:user /home/user/.ssh
    ```

* Wrong permissions on remote server
    ```bash
    ssh user@server "chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys"
    ```

* SSH key already exists
    ```bash
    ssh-copy-id -n user@server
    ```

* `sshd_config`

```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
X11Forwarding no
AllowTcpForwarding no
MaxAuthTries 3
LoginGraceTime 20
```

---
---

# 🚀 **SSH INTERNAL WORKING — COMPLETE TECHNICAL GUIDE**

SSH uses **encryption, hashing, MAC, digital signatures, key exchange, and authentication** to create a secure, encrypted channel.

The SSH connection process has **6 stages**:

```
1. TCP connection
2. SSH protocol negotiation
3. Key exchange (Diffie-Hellman or Curve25519)
4. Session encryption setup
5. User authentication (password / key / keyboard-interactive)
6. Secure data transfer
```

Let’s break each stage in detail.


# 🔹 **1. TCP CONNECTION (Port 22)**

Client → opens TCP connection:

```
client: random_port → server:22
```

Server accepts, then both exchange **banner messages**, example:

```
SSH-2.0-OpenSSH_9.2
```

This announces:

* SSH version
* Software used (OpenSSH, Dropbear, etc.)


# 🔹 **2. ALGORITHM NEGOTIATION**

Client and server now negotiate:

✔ Key exchange algorithms
✔ Host key algorithms
✔ Encryption ciphers
✔ MAC algorithms
✔ Compression

Client proposes:

```
curve25519-sha256, diffie-hellman-group14-sha256
aes256-gcm@openssh.com, chacha20-poly1305
hmac-sha2-256
```

Server selects strongest supported options.


# 🔹 **3. KEY EXCHANGE (Diffie-Hellman or Curve25519)**

The **heart** of SSH security.

Goal: **Both sides derive the same symmetric session key WITHOUT sending it over the network.**

### SSH uses:

* **Diffie-Hellman (DH)**
  OR
* **Curve25519 (modern & recommended)**
  OR
* **ECDH (Elliptic Curve Diffie-Hellman)**

### Key exchange steps:

```
1. Client generates random private number 'a'
2. Server generates random private number 'b'

3. Client sends A = g^a mod p
4. Server sends B = g^b mod p

5. Client computes     K = B^a mod p
6. Server computes     K = A^b mod p

Both get SAME shared secret K
```

This secret K will be used to create **symmetric keys**.

🛡 **Man-in-the-middle protection**
Server signs the exchange with its **host private key**, proving identity.

Client verifies using known_hosts.


# 🔹 **4. SESSION ENCRYPTION SETUP**

From shared secret **K**, SSH derives:

* encryption key (AES or ChaCha20)
* MAC key
* IV (initialization vector)

SSH now switches to **secure, encrypted mode**.

Encryption choices:

| Cipher                | Notes                  |
| --------------------- | ---------------------- |
| **chacha20-poly1305** | Fastest + secure       |
| aes256-gcm            | Strong & authenticated |
| aes128-ctr            | Common                 |
| aes256-ctr            | Strong but older       |

MAC (message authentication):

* hmac-sha2-256
* hmac-sha2-512

SSH compresses (optional):

* `none` (default)
* `zlib`


# 🔹 **5. USER AUTHENTICATION**

Now communication is encrypted. User must authenticate.

SSH supports **three major authentication methods**:


## **A. Password Authentication**

```
ssh user@server
(password transmitted inside encrypted SSH tunnel)
```

Very secure because password is encrypted.


## **B. Public Key Authentication (Most Secure)**

Flow:

1. Client sends request with **public key**
2. Server checks if public key exists in

   ```
   ~/.ssh/authorized_keys
   ```
3. Server sends a **challenge** (random message)
4. Client signs challenge with its **private key**
5. Server verifies signature using **public key**

If signature is correct → login allowed.

### Private key NEVER leaves your PC.

### Public key is stored on server.


## **C. Keyboard-Interactive Authentication (OTP/MFA)**

Can include:

* One-time passwords
* Google Authenticator
* Duo MFA
* Custom prompts

Example:

```
Password:
OTP Code:
Security Question:
```


# 🔹 **6. SECURE DATA TRANSFER (SSH CHANNELS)**

SSH supports multiple logical channels inside one connection:

* shell
* exec commands
* port forwarding
* sftp
* scp
* agent forwarding

All encrypted under same session key.



# 🛡 **SSH SECURITY LAYERS SUMMARY**

| Layer                    | Purpose                     |
| ------------------------ | --------------------------- |
| **Key Exchange**         | Build secret key securely   |
| **Host Key**             | Identify server, avoid MITM |
| **Symmetric Encryption** | Encrypt all packets         |
| **MAC**                  | Detect tampering            |
| **Authentication**       | Verify user                 |
| **Channels**             | Multiplex features          |



# 🧬 **DEEP DIVE: WHAT HAPPENS WHEN YOU RUN `ssh user@server`**

Full step-by-step:

```
1. TCP handshake
2. Exchange SSH banners
3. Exchange supported algorithms
4. Server picks best matching algorithms
5. Run Diffie-Hellman key exchange
6. Generate shared secret (K)
7. Derive symmetric session keys (AES/ChaCha20)
8. Verify server identity via host key
9. Switch to encrypted mode
10. Authenticate user (password or pubkey)
11. Open SSH session channel
12. Run commands / start shell
```

# 🔥 **DIFFIE-HELLMAN VS CURVE25519 (Which is Best?)**

| Algorithm      | Security        | Speed         | Status |
| -------------- | --------------- | ------------- | ------ |
| DH group14     | Medium          | Slow          | Legacy |
| DH group16     | Strong          | Slow          | OK     |
| **Curve25519** | **Very strong** | **Very fast** | ⭐ BEST |
| ECDH           | Strong          | Fast          | Good   |

Modern OpenSSH systems default to **Curve25519**.


# 🔐 **SSH HASHING (MAC / Integrity)**

SSH uses:

* SHA-256
* SHA-512
* Poly1305

Purpose:

✔ Prevent packet modification
✔ Detect tampering
✔ Ensure authenticity

SSH does **not use MD5** anymore.


# 🧰 **SSH PROTOCOLS**

SSH uses three protocols:

| Protocol                       | Purpose                   |
| ------------------------------ | ------------------------- |
| **SSH-2 Transport Layer**      | Encryption + key exchange |
| **SSH-2 Authentication Layer** | Password / public key     |
| **SSH-2 Connection Layer**     | Channels, shell, sftp     |

SSH-1 is **obsolete**.


# 🧱 **SSH HOST KEY TYPES**

SSH servers have **host keys** used for identity:

* RSA (classic)
* Ed25519 (recommended)
* ECDSA

Stored in:

```
/etc/ssh/ssh_host_ed25519_key
/etc/ssh/ssh_host_rsa_key
```

Client stores fingerprints:

```
~/.ssh/known_hosts
```

This prevents MITM (man-in-the-middle).


# ⚡ **SSH PACKET ENCRYPTION LIFE CYCLE**

### 1. Handshake (unencrypted)

### 2. Key exchange → derive symmetric keys

### 3. Switch to encrypted mode

### 4. All future packets encrypted

Keys rotate periodically to prevent compromise.


# 🧪 **Check SSH Algorithms on Your System**

```
ssh -Q kex       # key exchange
ssh -Q cipher    # encryption algorithms
ssh -Q mac       # integrity
```


# 🔧 **Real-World SSH Handshake Example (`ssh -vvv`)**

When running:

```
ssh -vvv user@server
```

Look for:

```
kex: algorithm: curve25519-sha256
Host key: ssh-ed25519
sending SSH2_MSG_KEX_ECDH_INIT
expecting SSH2_MSG_KEX_ECDH_REPLY
Authentication succeeded (publickey).
```

This shows:

* Key exchange
* Host verification
* Successful authentication


# 🧡 **Why SSH Is Considered Very Secure**

SSH ensures:

✔ Perfect Forward Secrecy (via DH/C25519)
✔ Strong symmetric encryption (AES/ChaCha20)
✔ Digital signing for identity
✔ Integrity via MAC
✔ Secure authentication
✔ Optional MFA
✔ Actively maintained (OpenSSH)

SSH is one of the **most battle-tested secure protocols ever built**.


# 🏁 **SUMMARY OF INTERNAL SSH PROCESS**

```
1. TCP handshake
2. Exchange SSH banners
3. Negotiate algorithms
4. Diffie-Hellman / Curve25519 key exchange
5. Server proves identity (host key)
6. Build symmetric encryption (AES/ChaCha20)
7. Authenticate user
8. Encrypted SSH session established
9. Data exchange via encrypted channels
10. Connection closes securely
```

---

### SSH SERVER HARDENING

* Disable Password Authentication
```bash
PasswordAuthentication no #Disables password login, Only SSH keys allowed.
PubkeyAuthentication yes #Enable login using SSH public/private keys.
```

* PermitEmptyPasswords
```bash
PermitEmptyPasswords no
```
  * Prevents users with no password from logging in.

* Disable Root Login
```bash
PermitRootLogin no
```
```bash
PermitRootLogin yes        # NOT recommended
PermitRootLogin no         # BEST
PermitRootLogin prohibit-password  # only key login
```

* Use Ed25519 Host and User Keys
```bash
ssh-keygen -t ed25519
```

* Limit SSH Users/group
```bash
AllowUsers ubuntu deploy admin #Only these users can SSH, other denied
AllowGroups ssh-users #Only members of these groups can SSH.
```

* Reduce Login Grace Time (It defines how long the SSH server waits for a user to authenticate (enter password or provide key) after the connection is opened.)
```bash
LoginGraceTime 20
```
  * If the user does not finish authentication → connection closes.
  * Reduces open/idle SSH connections
  * Lowers risk of resource exhaustion
  * Forces quick authentication attempts

* Limit Maximum Auth Attempts
```bash
MaxAuthTries 3
```
  * This defines how many failed authentication attempts are allowed per SSH connection before the server disconnects.
  * Reduces brute force attempts

* Disable Unused Features
```bash
X11Forwarding no
AllowTcpForwarding no
PermitEmptyPasswords no
```

* Use Fail2ban
```bash
sudo apt install fail2ban -y
```
  * Protects from SSH brute-force.

* Use SSH CA (Certificate Authority)
  * Enterprise-level security.
```bash
TrustedUserCAKeys /etc/ssh/ca.pub
```
  * Use signed certificates instead of keys.

* ClientAliveInterval
```bash
ClientAliveInterval 60 #SSH server sends a keep-alive message every 60 seconds to client.
#If client does not respond, SSH checks again.
```

* ClientAliveCountMax
```bash
ClientAliveCountMax 3 #SSH server will try 3 times to reach the client.
#If still no response: connection is terminated
```

```bash
# Authentication
PasswordAuthentication no
PubkeyAuthentication yes
PermitRootLogin no
PermitEmptyPasswords no
MaxAuthTries 3

# Idle timeout
ClientAliveInterval 60
ClientAliveCountMax 3

# Login limits
AllowUsers ubuntu admin devops
# Or: AllowGroups sshusers

# Security settings
LoginGraceTime 20
X11Forwarding no
AllowTcpForwarding no
```

---

### ssh config file

```bash
cat > ~/.ssh/config <<'EOF'
# Configuration for Server 1 (e.g., a home server)
Host homeserver
    HostName 192.168.1.10
    User johndoe
    Port 22
    IdentityFile ~/.ssh/id_rsa_home
    IdentitiesOnly yes

# Configuration for Server 2 (e.g., a work server)
Host workserver
    HostName work.example.com
    User janedoe
    IdentityFile ~/.ssh/id_rsa_work
    IdentitiesOnly yes #Tells SSH to only use the identity file specified in the config, which prevents SSH from trying all other keys in your ssh-agent and avoids potential authentication failures if the server has an authentication attempt limit.

# Optional: Global settings for all hosts (place at the top or bottom)
Host *
    HashKnownHosts yes # Improves security by storing hashed representations of hostnames in the ~/.ssh/known_hosts file, preventing others from easily seeing the servers you connect to.
    ForwardAgent yes
EOF
```
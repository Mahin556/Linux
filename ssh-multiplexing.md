# 🚀 **SSH MULTIPLEXING — COMPLETE GUIDE (ControlMaster, ControlPath, ControlPersist)**

SSH Multiplexing allows **multiple SSH sessions to reuse a single TCP connection**, drastically speeding up:

* Git operations
* Ansible playbooks
* SCP/SFTP transfers
* Remote commands
* DevOps automation

Instead of opening a new connection each time (which takes 1–2 seconds), SSH multiplexing makes subsequent connections **instant**.

---

# 🧠 **1. What is SSH Multiplexing? (Simple Explanation)**

### ❌ Without multiplexing:

Every SSH command → new TCP connection
Every Git fetch → new TCP handshake
Every Ansible task → new SSH login

**Slow, repeated overhead.**

---

### ✔ With multiplexing:

SSH opens *one* connection and keeps it alive.

Other SSH sessions **reuse** that connection.

This makes connections almost instant:

```
0.05s instead of 1.5s
```

---

# 🧩 **2. How SSH Multiplexing Works Internally**

1. First SSH command opens a **master connection**
2. SSH creates a UNIX socket (ControlPath)
3. SSH keeps connection open in background
4. Next commands (same host):

   * Connect to socket
   * Reuse existing authenticated connection
5. No need to re-authenticate

This bypasses:

* TCP handshake
* SSH handshake
* Key exchange
* Authentication

Huge performance boost.

---

# ⚙️ **3. Enabling SSH Multiplexing (Recommended Method)**

Edit:

```
nano ~/.ssh/config
```

Add:

```ini
Host *
    ControlMaster auto
    ControlPath ~/.ssh/cm-%r@%h:%p
    ControlPersist 10m
```

### Explanation:

| Option                 | Meaning                                     |
| ---------------------- | ------------------------------------------- |
| **ControlMaster auto** | Enables multiplexing                        |
| **ControlPath**        | Path to the UNIX socket file                |
| **ControlPersist 10m** | Keep master connection alive for 10 minutes |

---

# ⚡ **4. Test SSH Multiplexing Speed**

### First connection (creates master):

```
time ssh user@server exit
```

### Second connection (reuses master):

```
time ssh user@server exit
```

You will notice:

* First: ~1–2 seconds
* Second: ~0.05 seconds

---

# 🧪 **5. How to See If Multiplexing Is Working**

```
ssh -vvv user@server
```

Look for:

```
Control socket connecting
Control socket connected
```

That means multiplexing is working.

---

# 🧱 **6. ControlPath Location**

The UNIX socket file will appear in:

```
~/.ssh/cm-user@server:22
```

This file allows other SSH sessions to reuse the connection.

---

# 🌐 **7. ControlPersist Options**

### Keep connection alive forever:

```
ControlPersist yes
```

### Keep alive for 30 minutes:

```
ControlPersist 30m
```

### Close connection immediately after last use:

```
ControlPersist no
```

---

# 🔐 **8. SSH Multiplexing + ssh-agent (Best Combo)**

Use:

```
eval $(ssh-agent)
ssh-add ~/.ssh/id_ed25519
```

Then multiplexing will:

* reuse connection
* use keys from agent
* require no passphrase

Perfect for automation.

---

# 🛠 **9. Use Cases in DevOps & Cloud**

### ✔ Ansible

Every task requires SSH → multiplexing increases speed by **80%**.

### ✔ Git over SSH

Cloning large repos over multiple connections becomes much faster.

### ✔ Kubernetes clusters

Frequent SSH into master/worker nodes becomes instant.

### ✔ SFTP / SCP

File transfers reuse connections.

### ✔ Automated scripts

Multiple SSH commands become nearly instant.

---

# 📁 **10. Manual Multiplexing Commands (`-M`, `-S`, `-O`)**

### **Create master session**

```
ssh -M -S /tmp/ssh-socket user@server
```

### **Use master session**

```
ssh -S /tmp/ssh-socket user@server "ls"
```

### **Stop master session**

```
ssh -S /tmp/ssh-socket -O exit user@server
```

---

# 🧨 **11. Troubleshooting**

---

### ❌ **Control socket path too long**

Error:

```
ControlPath too long
```

Fix:
Use shorter path:

```
ControlPath ~/.ssh/%h-%p-%r
```

---

### ❌ **Multiplexing not working across different users**

ControlPath must include `%r` (remote user):

```
ControlPath ~/.ssh/cm-%r@%h:%p
```

---

### ❌ **Multiplexing not working after reboot**

Because master connection was closed.

Solution:

* Reconnect once
* Multiplexing starts again

---

### ❌ **Permission denied on ControlPath socket**

Fix:

```
chmod 700 ~/.ssh
```

---

# 🛡 **12. Security Considerations**

* Multiplexing stores master connection in a UNIX socket
* Only your user can access it (same permissions as `.ssh`)
* Safe for local systems
* DO NOT use multiplexing across shared accounts

---

# 🧠 **13. Full Example ~/.ssh/config (Professional)**

```ini
Host *
    ServerAliveInterval 60
    ControlMaster auto
    ControlPath ~/.ssh/cm-%r@%h:%p
    ControlPersist 15m
```

For a specific server:

```ini
Host prod
    HostName 10.1.1.5
    User ubuntu
    IdentityFile ~/.ssh/prod_key
    ControlMaster auto
    ControlPersist yes
```

---

# 🏁 **14. Quick Summary CheatSheet**

```
Enable multiplexing:
  ControlMaster auto
  ControlPath ~/.ssh/cm-%r@%h:%p
  ControlPersist 10m

Test:
  ssh -vvv user@server

Close master:
  ssh -O exit user@server

Start agent:
  eval $(ssh-agent)
  ssh-add ~/.ssh/id_ed25519
```

---

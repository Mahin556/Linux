```bash
======================== NTP (NETWORK TIME PROTOCOL) – COMPLETE DETAILED GUIDE ========================

------------------------ BASIC OVERVIEW ------------------------
NTP (Network Time Protocol) is an Application Layer protocol.
Port used: 123 / UDP

Purpose:
- Synchronize system clocks over a network
- Maintain accurate and consistent time across systems

NTP can sync time from:
- Internet time servers
- GPS receivers
- Radio clocks
- Local NTP servers

NTP works in Client / Server model:
- NTP Server → provides time
- NTP Client → consumes time

Time synchronization is CRITICAL for:
- Logs and auditing
- Security (Kerberos, SSL, certificates)
- Distributed systems
- Databases
- Cluster environments

------------------------ NTP IN RHEL 8 ------------------------
- Traditional `ntpd` package is deprecated
- Replaced by `chrony`
- Chrony runs as a user-space daemon: `chronyd`
- Package name: chrony

Chrony advantages:
- Faster sync than ntpd
- Works well with intermittent networks
- Accurate even on virtual machines
- Can act as BOTH server and client

------------------------ IMPORTANT FILES ------------------------
/etc/chrony.conf        → main configuration file
/var/lib/chrony/        → drift and state data
chronyc                → command-line control tool

------------------------ SERVER SIDE CONFIGURATION (RHEL 8) ------------------------

systemctl status systemd-timesyncd.service #It is default systemd service in ubuntu to sync time --> connflicting with chronyd ---> stop it

systemctl stop systemd-timesyncd.service
systemctl disable systemd-timesyncd.service

1) Verify repository configuration
dnf repolist

2) Install chrony package
dnf install chrony* -y

3) Start chrony service
systemctl start chronyd

4) Enable chrony at boot
systemctl enable chronyd

5) Verify service status
systemctl status chronyd

6) Configure server to allow client networks
vi /etc/chrony.conf

Add:
allow 192.168.1.0/24

Meaning:
- Allows NTP requests from the specified subnet

7) Restart chrony service
systemctl restart chronyd

8) Open firewall for NTP
firewall-cmd --permanent --add-service=ntp

9) Reload firewall
firewall-cmd --reload

10) Verify connected clients
chronyc clients

------------------------ CLIENT SIDE CONFIGURATION (RHEL 7 / RHEL 8) ------------------------

1) Verify repository
yum repolist

2) Install chrony
yum install chrony* -y

OR (if repo not available)
rpm -ivh chrony

3) Start chrony service
systemctl start chronyd

4) Enable chrony at boot
systemctl enable chronyd

5) Check service status
systemctl status chronyd

6) Configure NTP server entry
vi /etc/chrony.conf

Add:
server 192.168.1.107

Add:
server 192.168.1.107 iburst

Meaning:
- Client syncs time from this server
- iburst speeds up initial sync

Meaning:
- Client will sync time from this NTP server

7) Restart chrony service
systemctl restart chronyd

8) Verify NTP sources
chronyc sources

------------------------ WINDOWS CLIENT CONFIGURATION ------------------------
1) Press Win + R
2) Control Panel → Date & Time
3) Internet Time tab
4) Change settings
5) Enter NTP Server IP
6) Update now

------------------------ VERIFICATION PROCESS ------------------------
On NTP Server:
chronyc clients

You should see:
- Client IP
- Last sync time
- Connection status

On Client:
chronyc sources
chronyc tracking

Change time manually on client:
date -s "10:00:00"

Wait or force resync, then check:
date

Time should match NTP server.

------------------------ IMPORTANT CHRONY COMMANDS ------------------------
chronyc sources        → list time sources
chronyc clients        → list connected clients
chronyc tracking       → detailed sync status
chronyc sourcestats    → source statistics

------------------------ HOW TIME SYNC WORKS ------------------------
- Client sends request to server
- Server replies with timestamp
- Client calculates offset & delay
- System clock is gradually adjusted (slew)
- No sudden jumps (unless forced)

------------------------ SECURITY NOTES ------------------------
- NTP uses UDP (stateless)
- Restrict allowed networks using `allow`
- Firewall should allow only trusted subnets
- Do not expose NTP publicly unless required

------------------------ COMMON ISSUES ------------------------
- Firewall blocking UDP 123
- Wrong server IP
- chronyd service not running
- Incorrect subnet in allow directive

------------------------ BEST PRACTICES ------------------------
- Use internal NTP server for enterprise
- Sync internal server with Internet time
- Do NOT manually change time on servers
- Keep all systems synchronized

------------------------ QUICK COMMAND SUMMARY ------------------------
dnf install chrony* -y
systemctl start chronyd
systemctl enable chronyd
firewall-cmd --permanent --add-service=ntp
firewall-cmd --reload
chronyc sources
chronyc clients

======================== END OF NTP (CHRONY) GUIDE ========================
````

# NTP (Network Time Protocol) — Complete Command Reference

> **NTP** = Network Time Protocol | Port: **123/UDP** | Package: `ntp` (Ubuntu) or `chrony` (RHEL/CentOS/AlmaLinux)

---

## What is NTP?

NTP is a cross-platform protocol used to synchronize the clocks of computers across a network.
It is essential for databases, clusters, logs, satellite communication, GPS systems, e-commerce, and any distributed systems.

- **Stratum 1** — directly connected to atomic clock / GPS receiver
- **Stratum 2** — syncs from a Stratum 1 server
- **Stratum 10** — local fallback (used when no external server is available)
- **`iburst`** — sends a burst of 8 packets for faster initial synchronization
- **`*` in sources** — the server your machine is actively syncing from
- **`+` in sources** — candidate servers (used if the primary fails)

---

## VIDEO 1 — Ubuntu Linux (ntpd)

### 1. Check status of default time daemon

```bash
# Ubuntu uses systemd-timesyncd by default
# Must be stopped before installing ntpd to avoid conflicts
systemctl status systemd-timesyncd
```

### 2. Stop and disable systemd-timesyncd

```bash
# Stop the service (temporary — restarts on reboot)
systemctl stop systemd-timesyncd

# Disable so it does not start on reboot
systemctl disable systemd-timesyncd
```

### 3. Install NTP

```bash
# Install ntpd from Ubuntu repositories
apt install ntp
```

### 4. Open firewall port for NTP

```bash
# Allow UDP port 123 (NTP standard port)
ufw allow 123/udp

# Verify firewall rules
ufw status
```

### 5. Edit NTP configuration file

```bash
# Open the NTP config file in nano editor
nano /etc/ntp.conf

# Inside the file — comment out default pool lines and add your servers:
# server ntp1.tecnico.ulisboa.pt iburst
# server ora.roa.es iburst
```

### 6. Restart NTP service and verify

```bash
# Restart to apply configuration changes
systemctl restart ntp

# Check if service is running correctly
systemctl status ntp
```

### 7. Test connectivity to NTP servers

```bash
# Ping to verify network route to the server
ping ntp1.tecnico.ulisboa.pt
ping ora.roa.es

# Check latency — lower latency = better time source
```

### 8. Monitor live NTP network traffic

```bash
# Capture NTP packets on a network interface
# -n = show IP addresses instead of hostnames
# Replace eth0 with your actual interface name
tcpdump -n -i eth0 port 123
```

### 9. Check NTP peer synchronization status

```bash
# Shows all configured servers and sync status
# * = currently syncing from this server
# + = candidate server
# Columns: offset, jitter, stratum
ntpq -p
```

### 10. Set NTP server manually on macOS (client)

```bash
# Manually point macOS to sync from your Ubuntu NTP server
sudo sntp -sS <ubuntu-server-ip>
```

### 11. Verify NTP sync on macOS

```bash
# Check if macOS is syncing from the specified server
sntp <ubuntu-server-ip>
```

---

## VIDEO 2 — AlmaLinux (chronyd)

### NTP SERVER Configuration

#### 1. Install Chrony

```bash
# Chrony is the modern replacement for ntpd on RHEL-based systems
dnf install chrony
```

#### 2. Edit Chrony configuration

```bash
# Open chrony config file
nano /etc/chrony.conf

# Add inside the file:
allow 192.168.1.0/24    # Allow this subnet to use this server as NTP source
local stratum 10        # Act as time source even if not synced to internet
```

#### 3. Enable and start Chrony service

```bash
# Enable service to start on boot
systemctl enable chronyd

# Start the service now
systemctl start chronyd
```

#### 4. Check Chrony service status

```bash
systemctl status chronyd
```

#### 5. Verify Chrony tracking details

```bash
# Shows reference server, offset, stratum, and sync quality
chronyc tracking
```

#### 6. Configure firewall to allow NTP traffic

```bash
# Add NTP service to firewall permanently
firewall-cmd --add-service=ntp --permanent

# Reload firewall to apply changes
firewall-cmd --reload

# Confirm NTP is listed in allowed services
firewall-cmd --list-services
```

### NTP CLIENT Configuration

#### 7. Install Chrony on client

```bash
dnf install chrony
```

#### 8. Edit Chrony config on client

```bash
nano /etc/chrony.conf

# Comment out the default pool line, then add:
server <NTP-SERVER-IP> iburst
# iburst = faster initial sync via burst of 8 packets
# Replace <NTP-SERVER-IP> with actual IP or FQDN of your server
```

#### 9. Restart Chrony on client

```bash
systemctl restart chronyd
```

#### 10. Check sync sources

```bash
# -v = verbose output
# * in front of a server = client is actively syncing from it (confirmation of success)
chronyc sources -v
```

#### 11. Verify sync details

```bash
# Look at "Reference ID" — should match your NTP server's IP
chronyc tracking
```

---

## VIDEO 3 — RHEL/CentOS 9 (chronyd) — Hindi Tutorial

### NTP SERVER Configuration

#### 1. Check existing repositories

```bash
# Verify configured repos before installing
dnf repolist
```

#### 2. Verify Chrony is installed

```bash
# Check if chrony package is already present
rpm -qa | grep chrony
```

#### 3. Install Chrony (if not installed)

```bash
dnf install chrony -y
```

#### 4. Start and enable Chrony in one command

```bash
# --now = starts immediately AND enables on boot
systemctl enable chronyd --now
```

#### 5. Check Chrony status

```bash
systemctl status chronyd
```

#### 6. Edit Chrony config

```bash
vi /etc/chrony.conf

# Add/uncomment the allow line:
allow 192.168.20.0/24    # Allow entire subnet to use this NTP server
```

#### 7. Restart Chrony to apply changes

```bash
systemctl restart chronyd
```

#### 8. Open firewall for NTP with zone

```bash
# Add NTP service to public zone permanently
firewall-cmd --add-service=ntp --permanent --zone=public

# Reload firewall
firewall-cmd --reload
```

#### 9. Verify firewall rules

```bash
firewall-cmd --list-services
```

#### 10. View connected NTP clients

```bash
# Shows all client machines currently syncing from this NTP server
# Useful to confirm clients have connected successfully
chronyc clients
```

### NTP CLIENT Configuration (Linux)

#### 11. Install Chrony

```bash
dnf install chrony -y
```

#### 12. Edit client config

```bash
vi /etc/chrony.conf

# Comment out default pool line, add your server:
server <NTP-SERVER-IP> iburst
```

#### 13. Restart Chrony

```bash
systemctl restart chronyd
```

#### 14. Check sync sources

```bash
# Confirm * appears next to your server = sync is working
chronyc sources
```

### NTP CLIENT Configuration (Windows)

#### 15. Check current date/time

```cmd
date
```

#### 16. Open Date & Time settings via Run dialog

```cmd
:: Open Date & Time control panel
timedate.cpl
```

#### 17. Disable NTP sync via command line (PowerShell)

```powershell
# Disable automatic time synchronization
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" -Name "NtpEnabled" -Value 0
```

#### 18. Set time manually (after disabling NTP)

```cmd
:: Set system date and time manually
date 10/12/2012
time 10:20:15
```

#### 19. Re-enable NTP sync

```powershell
# Re-enable automatic time synchronization
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" -Name "NtpEnabled" -Value 1
```

#### 20. Force immediate time sync (Windows)

```cmd
:: Trigger an immediate NTP sync
w32tm /resync
```

#### 21. Configure NTP server on Windows

```cmd
:: Point Windows to a specific NTP server
w32tm /config /manualpeerlist:"<NTP-SERVER-IP>" /syncfromflags:manual /reliable:yes /update
```

#### 22. Verify Windows IP address

```cmd
ipconfig
```

---

## Quick Reference Summary

| Command | Purpose |
|---|---|
| `systemctl status chronyd` | Check if chrony is running |
| `chronyc tracking` | Show sync details and reference server |
| `chronyc sources -v` | List all NTP sources (`*` = active) |
| `chronyc clients` | Show clients syncing from this server |
| `ntpq -p` | Show NTP peer list (ntpd) |
| `firewall-cmd --add-service=ntp --permanent` | Open NTP in firewall |
| `tcpdump -n -i eth0 port 123` | Monitor live NTP traffic |

---

## Key Configuration Values

| Parameter | Value |
|---|---|
| NTP Port | 123/UDP |
| Ubuntu package | `ntp` (service: `ntp`) |
| RHEL/CentOS/AlmaLinux package | `chrony` (service: `chronyd`) |
| Config file | `/etc/ntp.conf` or `/etc/chrony.conf` |
| `iburst` | Faster sync via burst of 8 packets |
| `local stratum 10` | Serve time even without internet NTP |
| `allow <subnet>` | Permit subnet to use this as NTP server |
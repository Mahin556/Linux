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
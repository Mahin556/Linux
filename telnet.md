```
======================== TELNET – COMPLETE DETAILED GUIDE ========================

------------------------ WHAT IS TELNET ------------------------
Telnet is an Application Layer protocol.
It provides bidirectional, interactive, text-based communication.

Telnet works in Client / Server model:
- Telnet Server runs on the main system
- Telnet Client connects from remote systems

Port used:
23 / TCP

Telnet sends data in PLAIN TEXT:
- Username
- Password
- Commands
This makes it INSECURE and NOT recommended for production use.

------------------------ WHEN TELNET IS USED ------------------------
- Learning client/server concepts
- Network troubleshooting
- Legacy systems
- Lab environments ONLY

------------------------ TELNET VS SSH ------------------------
Telnet:
- No encryption
- Plain text
- Port 23
- Insecure

SSH:
- Encrypted
- Secure
- Port 22
- Recommended

------------------------ INSTALL TELNET SERVER (RHEL / CENTOS) ------------------------
yum install telnet-server

Telnet server runs as a socket-based service (xinetd/systemd).

Start Telnet socket:
systemctl start telnet.socket

Check status:
systemctl status telnet.socket

Enable on boot:
systemctl enable telnet.socket

------------------------ INSTALL TELNET CLIENT (RHEL / CENTOS) ------------------------
yum install telnet
yum install telnet-<version>

------------------------ TELNET CLIENT ON WINDOWS ------------------------
Telnet client is INCLUDED but DISABLED by default.

Enable Telnet Client:
Control Panel
→ Programs
→ Turn Windows features on or off
→ Check "Telnet Client"
→ OK

After enabling:
Open Command Prompt
telnet <server-ip>

------------------------ CONNECTING TO TELNET SERVER ------------------------
From client:
telnet <server-ip>

Example:
telnet 192.168.1.10

------------------------ COMMON ISSUE: CONNECTION REFUSED ------------------------
Reason:
Firewall blocking Telnet traffic.

Even if:
- Package installed
- Service running

Firewall must allow port 23.

------------------------ CHECK FIREWALL STATUS ------------------------
systemctl status firewalld

------------------------ ALLOW TELNET THROUGH FIREWALL ------------------------
Simple method:
firewall-cmd --add-service=telnet --permanent
firewall-cmd --reload

------------------------ RICH RULE (LIMIT ACCESS BY IP) ------------------------
firewall-cmd --add-rich-rule \
'rule family="ipv4" source address="192.168.1.100/32" service name="telnet" log prefix="Telnet Access Allowed" level="info" accept' \
--permanent

Reload firewall:
firewall-cmd --reload

Verify rules:
firewall-cmd --list-rich-rules
firewall-cmd --list-all

------------------------ TELNET LOGIN BEHAVIOR ------------------------
- Root login is DISABLED by default
- This is a SECURITY FEATURE
- Login using normal user
- Then switch to root if needed

------------------------ WHY ROOT LOGIN IS BLOCKED ------------------------
Telnet is unencrypted.
Allowing root login would expose:
- Root password
- Full system access

------------------------ TELNET LOG FILE LOCATION ------------------------
/var/log/messages
/var/log/secure
journalctl -u telnet.socket

------------------------ DISABLING TELNET (RECOMMENDED) ------------------------
Stop service:
systemctl stop telnet.socket

Disable on boot:
systemctl disable telnet.socket

Remove package:
yum remove telnet-server telnet

------------------------ RESTRICTING TELNET ACCESS ------------------------
Edit:
 /etc/securetty

Only terminals listed here can allow root login.
Telnet terminals are NOT included by default.

------------------------ PAM CONFIGURATION ------------------------
PAM controls authentication rules.
Telnet authentication is governed by:
 /etc/pam.d/login

------------------------ SECURITY CONSIDERATIONS ------------------------
- Telnet sends credentials in clear text
- Can be sniffed using packet capture tools
- Vulnerable to MITM attacks

------------------------ BEST PRACTICE ------------------------
- NEVER use Telnet in production
- Use SSH instead
- Disable Telnet after testing
- Restrict firewall access if enabled temporarily

------------------------ QUICK COMMAND SUMMARY ------------------------
yum install telnet-server
systemctl start telnet.socket
systemctl enable telnet.socket
firewall-cmd --add-service=telnet --permanent
firewall-cmd --reload
telnet <server-ip>

======================== END OF TELNET GUIDE ========================
```
```bash
# ========================= SELINUX COMPLETE DETAILED GUIDE =========================
# Everything explained step-by-step in ONE PLACE (concept → commands → behavior)

# SELinux = Security-Enhanced Linux
# Mandatory Access Control (MAC) security system built into Linux kernel
# Implemented as a Linux Security Module (LSM)
# Developed by NSA, maintained by Red Hat
# Enabled by default on RHEL, CentOS, Rocky, Alma, Fedora
# Purpose: limit damage even if a service/process is compromised

# ------------------------- WHY SELINUX EXISTS -------------------------
# Traditional Linux security uses DAC (Discretionary Access Control)
# DAC uses:
#   - user/group/other permissions (rwx)
#   - ACLs
# Problems with DAC:
#   - users can give excessive permissions
#   - compromised service can access everything user owns
#   - root can do anything
# SELinux adds MAC:
#   - rules are enforced by kernel
#   - even root is restricted
#   - least-privilege principle

# ------------------------- DAC vs MAC -------------------------
# DAC:
#   - controlled by file owner
#   - permissions can be changed freely
#   - vulnerable to privilege escalation
# MAC (SELinux):
#   - controlled by system policies
#   - users cannot override rules
#   - access allowed ONLY if policy says so

# ------------------------- CORE SELINUX IDEA -------------------------
# Every object in system has a SECURITY CONTEXT (LABEL):
#   - files
#   - directories
#   - processes
#   - network ports
#   - sockets
# SELinux policy decides:
#   "Can process TYPE A perform ACTION X on object TYPE B?"
# If no explicit rule exists → ACCESS DENIED

# ------------------------- SELINUX CONTEXT (LABEL) -------------------------
# Format:
#   user:role:type:level
# Example:
#   system_u:object_r:httpd_sys_content_t:s0

# user  → SELinux user (NOT Linux user)
# role  → bridge between user and domain
# type  → MOST IMPORTANT (decides access)
# level → MLS/MCS security level (usually s0)

# ------------------------- TYPE ENFORCEMENT (HEART OF SELINUX) -------------------------
# Processes run in DOMAINS (process types)
# Files have FILE TYPES
# Rules allow domain ↔ type interaction

# Examples:
#   httpd_t               → Apache process domain
#   httpd_sys_content_t   → Apache readable files
#   sshd_t                → SSH daemon domain
# Apache (httpd_t):
#   ✔ can read httpd_sys_content_t
#   ✘ cannot read default_t or etc_t

# ------------------------- CHECK SELINUX STATUS -------------------------
sestatus            # full status
getenforce          # Enforcing | Permissive | Disabled

# ------------------------- SELINUX MODES -------------------------
# Enforcing:
#   - policy enforced
#   - unauthorized access blocked
#   - production mode
# Permissive:
#   - access allowed
#   - violations logged
#   - troubleshooting mode
# Disabled:
#   - SELinux off
#   - no MAC protection
#   - NOT recommended

# ------------------------- CHANGE MODE TEMPORARILY -------------------------
setenforce 0        # switch to permissive (until reboot)
setenforce 1        # switch to enforcing

# ------------------------- CHANGE MODE PERMANENTLY -------------------------
vi /etc/selinux/config
# SELINUX=enforcing | permissive | disabled
reboot

# ALWAYS take snapshot/backup before permanent change

# ------------------------- SELINUX POLICIES -------------------------
# Policy = predefined rule set
# Types:
#   targeted  → protects network services (default)
#   minimum  → minimal protection
#   mls       → multi-level security
# Targeted policy is used on most servers

# ------------------------- FILE & DIRECTORY CONTEXT -------------------------
ls -lZ /path            # view file context

# Copy vs Move behavior:
# copy  → destination keeps its own context
# move  → source context moves with file

# ------------------------- PROCESS CONTEXT -------------------------
ps -eZ                  # list process contexts
ps -eZ | grep httpd

# ------------------------- PORT CONTEXT -------------------------
semanage port -l        # list all port mappings
semanage port -l | grep ssh

# SELinux maps ports to PORT TYPES
# Service can bind ONLY to allowed port types

# ------------------------- COMMON PORT ISSUE (SSH EXAMPLE) -------------------------
# SSH default port allowed: 22
# Custom port blocked unless labeled

semanage port -a -t ssh_port_t -p tcp 9998
systemctl restart sshd

# ------------------------- TEMPORARY CONTEXT CHANGE -------------------------
# Lost after restorecon or relabel
chcon -t httpd_sys_content_t file

# ------------------------- RESTORE DEFAULT CONTEXT -------------------------
restorecon -Rv /path

# ------------------------- PERMANENT CONTEXT CHANGE -------------------------
semanage fcontext -a -t httpd_sys_content_t "/websites(/.*)?"
restorecon -Rv /websites

# ------------------------- WHERE CONTEXT RULES ARE STORED -------------------------
/etc/selinux/targeted/contexts/files/file_contexts

# ------------------------- SELINUX BOOLEANS -------------------------
# Booleans = ON/OFF switches inside SELinux policy
# Used to allow common behavior without writing rules

getsebool -a                            # list all booleans
getsebool httpd_can_network_connect     # check specific boolean

# Enable boolean temporarily
setsebool httpd_can_network_connect on

# Enable boolean permanently
setsebool -P httpd_can_network_connect on

# ------------------------- COMMON HTTPD BOOLEANS -------------------------
httpd_can_network_connect
httpd_enable_homedirs
httpd_read_user_content

# ------------------------- AUDIT LOGS -------------------------
# All denials logged here
/var/log/audit/audit.log

# View recent denial
cat /var/log/audit/audit.log | grep AVC | tail -1

# ------------------------- ANALYSIS TOOLS -------------------------
audit2why      # explain why access was denied
audit2allow    # generate custom policy (advanced)

# ------------------------- TROUBLESHOOTING FLOW -------------------------
# 1. Issue occurs
# 2. Switch to permissive mode
# 3. Reproduce issue
# 4. Check audit logs
# 5. Fix using:
#    - correct context
#    - boolean
#    - port mapping
# 6. Return to enforcing mode

# ------------------------- REAL WORLD EXAMPLE (APACHE CUSTOM DIR) -------------------------
# Problem: Apache cannot read /websites
# Cause: files labeled default_t
# Fix:
semanage fcontext -a -t httpd_sys_content_t "/websites(/.*)?"
restorecon -Rv /websites
systemctl restart httpd

# ------------------------- BEHAVIOR SUMMARY -------------------------
# Files not present on destination → copied
# Modified files → only changed parts allowed
# Identical files → no access needed
# SELinux denies → FIX POLICY, DO NOT DISABLE

# ------------------------- GOLDEN RULES -------------------------
# SELinux does NOT break systems
# Misconfigured systems break SELinux
# Fix labels, booleans, ports — never disable blindly
# SELinux protects even if root is compromised

# ========================= END OF SELINUX GUIDE =========================
```
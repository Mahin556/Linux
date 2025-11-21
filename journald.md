Systemd-journal (official name: **systemd-journald**) is **the logging service of systemd**.
It collects and manages logs from:
* Kernel messages
* System services (systemd units)
* User sessions
* initrd
* Applications using `stdout/stderr`
* Applications writing logs via `syslog`
* Audit framework

### **Core Concepts**

* systemd-journal replaces **rsyslog/syslog** (can work together also).
* It writes logs to **binary log files** (not plain text).
* These log files live in:

  * `/run/log/journal/` → **volatile** (lost on reboot)
  * `/var/log/journal/` → **persistent** (kept across reboots)
* Log files are stored in `.journal` format (binary).
* You can read logs only using `journalctl`.

---

## **How journald stores logs internally**

* Journald stores logs as **binary key-value objects**.
* Every log entry contains fields like:

  * `_PID=`
  * `_UID=`
  * `_COMM=` (command name)
  * `_SYSTEMD_UNIT=`
  * `MESSAGE=`
  * `_BOOT_ID=`
* Journald automatically:

  * Compresses logs
  * Rotates logs
  * Limits logs based on disk usage

---

## Persistent log storage (VERY IMPORTANT)

By default, many distros (Ubuntu, CentOS minimal) store logs in **RAM only**.

Check if persistent directory exists:

```
ls /var/log/journal
```

If NOT present → enable persistent logs:

```
sudo mkdir -p /var/log/journal
sudo systemd-tmpfiles --create --prefix /var/log/journal
sudo systemctl restart systemd-journald
```

Now logs survive reboot.

---

* `journalctl` Command used to view logs from systemd’s journal.
* Replaces old logging tools like /var/log/messages, /var/log/syslog.
* Can read:
  * System logs
  * Service logs
  * Kernel logs
  * Boot logs
  * Hardware logs
* Logs filtered by time, uid, pid, unit, priority, etc.

```bash
journalctl #Shows all logs (from oldest to latest).

journalctl -e #Jump to end of logs (latest logs).

journalctl -f #Follow logs in real time (like tail -f).

journalctl -u sshd #Logs for sshd.service.

journalctl -u nginx #Logs for nginx.service.

journalctl -u <service> -f #Follow specific service logs live.

journalctl -u myapp.service --since "1 hour ago" #Service logs within last 1 hour.

journalctl -u docker.service

journalctl -u crond.service

journalctl -u NetworkManager.service

journalctl -u kubelet

journalctl -u slurmctld

journalctl -b #Logs from current boot.

journalctl -b -1 #Logs from previous boot.

journalctl -b -2 #Logs from boot before that.

journalctl -u sshd -b

journalctl --list-boots #Shows all boot sessions with IDs.
IDX BOOT ID                          FIRST ENTRY                 LAST ENTRY                 
 -4 a662c9995fee4f099ab6e6874c84e50d Mon 2025-02-10 22:04:48 UTC Mon 2025-02-10 22:06:44 UTC
 -3 b9063218568643598cc86aa1f6e149c2 Mon 2025-11-17 18:56:08 UTC Mon 2025-11-17 19:00:07 UTC
 -2 42a502e167894351bd5e63b849ccef1d Mon 2025-11-17 19:07:30 UTC Mon 2025-11-17 19:26:27 UTC
 -1 f40a16c706a04e7cb994dea2a90e6e9b Mon 2025-11-17 19:38:21 UTC Mon 2025-11-17 19:40:50 UTC
  0 7e1dd93f73434cffb4792289f159cf8e Fri 2025-11-21 05:36:11 UTC Fri 2025-11-21 06:15:01 UTC

journalctl --since "2024-01-01"

journalctl --since "1 hour ago"

journalctl --since "10 min ago" --until "now"

journalctl --since "2025-01-25 10:00:00" --until "2025-01-25 12:00:00"

#Filter Logs by Priority (Severity Levels)
#Linux log priorities (0 = highest severity):
#0 = emergency
#1 = alert
#2 = critical
#3 = error
#4 = warning
#5 = notice
#6 = info
#7 = debug
journalctl -p err #(errors + above)
journalctl -p 3 #same as above
journalctl -p warning
journalctl -p debug
journalctl -p 0..3 #(emergency to error)

#Filter Logs by Process or User
journalctl _PID=1234
journalctl _UID=0 (root’s logs)
journalctl _UID=1000 (normal user)
journalctl _GID=1000
journalctl -u nginx _PID=5678


#Filter Logs by Executable
journalctl _EXE=/usr/bin/python3
journalctl _EXE=/usr/sbin/sshd
# Logs for a specific executable
journalctl _COMM=sshd
# Logs for a specific systemd unit (alternative)
journalctl _SYSTEMD_UNIT=nginx.service

#Filter Logs by Kernel
journalctl -k #(only kernel logs)
journalctl -k -f #(follow kernel logs)
journalctl -k -p warning #(kernel warnings)

#Display Logs in Reverse Order
journalctl -r
#Shows latest logs first.

#Limit Output
journalctl -n 20
#Last 20 log lines.

journalctl -n 100 -f
#Follow but also show last 100 lines initially.

#Output Formatting
journalctl -o short #(default)
journalctl -o verbose
journalctl -o json
journalctl -o json-pretty
journalctl -o cat #(only message text)


#Shows journal size.
journalctl --disk-usage

#Keep only 500MB.
journalctl --vacuum-size=500M

#Keep last 7 days.
journalctl --vacuum-time=7d

#Export Logs
journalctl > logs.txt
journalctl -u nginx > nginx.log
journalctl -b -1 > previous-boot.log
journalctl --output=export > logs.journal #Export raw binary


#Debugging System Problems with journalctl
#System boot problems
journalctl -b -1 -p err

#Service down → 
journalctl -u <service> -p err

#Network issues → 
journalctl -u NetworkManager

#SSH failures → 
journalctl -u sshd

#Kernel crash → 
journalctl -k -p crit

journalctl -u nginx -p err --since "2 hours ago"

journalctl _PID=1234 -p debug

journalctl -k -p warning --since yesterday
```
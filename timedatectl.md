* Linux systems using systemd manage their time, timezone, and NTP sync through a powerful tool called `timedatectl`.
* Setting the correct timezone & system time is extremely important, because:
    * system logs (journalctl) depend on accurate timestamps
    * NTP synchronization helps avoid drift
    * debugging & auditing become easier
    * distributed systems remain consistent

```bash
#Check Current System Time
# Shows local time, UTC time, RTC time, timezone, NTP status
timedatectl
# or
timedatectl status

#List All Available Timezones
# Displays every timezone supported by your system
timedatectl list-timezones

#Set Timezone
# Syntax:
# sudo timedatectl set-timezone <Region/City>

sudo timedatectl set-timezone Asia/Kolkata
sudo timedatectl set-timezone America/New_York
sudo timedatectl set-timezone Europe/London

controlplane:~$ sudo timedatectl set-timezone Asia/Kolkata 
controlplane:~$ timedatectl status
               Local time: Fri 2025-11-21 12:02:52 IST
           Universal time: Fri 2025-11-21 06:32:52 UTC
                 RTC time: Fri 2025-11-21 06:32:52
                Time zone: Asia/Kolkata (IST, +0530)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
controlplane:~$ sudo timedatectl set-timezone Europe/London
controlplane:~$ timedatectl status
               Local time: Fri 2025-11-21 06:33:06 GMT
           Universal time: Fri 2025-11-21 06:33:06 UTC
                 RTC time: Fri 2025-11-21 06:33:06
                Time zone: Europe/London (GMT, +0000)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
controlplane:~$ date
Fri Nov 21 06:33:15 GMT 2025

# Shows if the system clock is synced with NTP servers
timedatectl show-timesync --all

#Enable NTP Time Synchronization
# Automatically sync clock with internet time servers
sudo timedatectl set-ntp true
sudo timedatectl set-ntp false

#Set System Clock Manually (If Needed)
# Format: YYYY-MM-DD HH:MM:SS
sudo timedatectl set-time "2025-11-21 14:30:00"

# Set RTC to UTC (recommended)
sudo timedatectl set-local-rtc 0

# Set RTC to Local time (not recommended)
sudo timedatectl set-local-rtc 1

```
```
======================== TIMEDATECTL COMMAND – COMPLETE DETAILED GUIDE ========================

------------------------ WHAT IS timedatectl ------------------------
timedatectl is a systemd utility used to:
- View and control system date and time
- Manage time zones
- Enable or disable NTP-based time synchronization

It is part of:
systemd-timesyncd / chronyd / ntpd integration

Works on:
- RHEL
- CentOS
- Rocky
- Alma
- Ubuntu
- Debian
(systemd-based systems)

------------------------ BASIC COMMAND ------------------------
timedatectl

Displays:
- Local time
- Universal time (UTC)
- RTC time (hardware clock)
- Time zone
- NTP status
- Synchronization state

------------------------ SAMPLE OUTPUT EXPLAINED ------------------------
Local time:           Tue 2025-04-30 22:34:10 IST
Universal time:       Tue 2025-04-30 17:04:10 UTC
RTC time:             Tue 2025-04-30 17:04:08
Time zone:            Asia/Kolkata (IST, +0530)
System clock synced:  yes
NTP service:          active
RTC in local TZ:      no

Meaning:
- Local time → system time shown to users
- UTC → coordinated universal time
- RTC → hardware clock on motherboard
- Time zone → configured zone
- System clock synced → synced with NTP
- RTC in local TZ → usually "no" (recommended)

------------------------ CHECK CURRENT TIME ZONE ------------------------
timedatectl status

------------------------ LIST AVAILABLE TIME ZONES ------------------------
timedatectl list-timezones

Filter:
timedatectl list-timezones | grep Asia

------------------------ SET TIME ZONE ------------------------
timedatectl set-timezone Asia/Kolkata

------------------------ CHECK CURRENT DATE ------------------------
timedatectl show

------------------------ SET DATE & TIME MANUALLY ------------------------
timedatectl set-time "2025-04-30 22:40:00"

NOTE:
- Automatically disables NTP when time is set manually

------------------------ ENABLE NTP SYNCHRONIZATION ------------------------
timedatectl set-ntp true

------------------------ DISABLE NTP SYNCHRONIZATION ------------------------
timedatectl set-ntp false

------------------------ CHECK NTP STATUS ------------------------
timedatectl timesync-status
timedatectl show-timesync

------------------------ HARDWARE CLOCK (RTC) ------------------------
RTC = Real Time Clock (BIOS clock)

Check RTC status:
timedatectl

Set RTC to UTC (recommended):
timedatectl set-local-rtc 0

Set RTC to local time (NOT recommended):
timedatectl set-local-rtc 1

------------------------ WHY RTC SHOULD BE UTC ------------------------
- Avoids DST issues
- Works better with dual-boot systems
- Industry best practice

------------------------ FORCE TIME SYNC ------------------------
chronyc makestep
# or
systemctl restart chronyd

------------------------ COMMON USE CASES ------------------------
- Verify time sync status
- Change timezone after server relocation
- Troubleshoot time drift
- Enable/disable NTP quickly
- Validate chrony/ntp configuration

------------------------ TROUBLESHOOTING ------------------------
Problem: Time not syncing
Check:
timedatectl
systemctl status chronyd
chronyc sources
firewall-cmd --list-all

------------------------ IMPORTANT NOTES ------------------------
- timedatectl is a frontend tool
- Actual syncing handled by:
  chronyd / ntpd / systemd-timesyncd
- Requires root privileges for changes

------------------------ QUICK COMMAND SUMMARY ------------------------
timedatectl
timedatectl status
timedatectl list-timezones
timedatectl set-timezone Asia/Kolkata
timedatectl set-time "YYYY-MM-DD HH:MM:SS"
timedatectl set-ntp true
timedatectl set-ntp false
timedatectl set-local-rtc 0

======================== END OF TIMEDATECTL GUIDE ========================
```

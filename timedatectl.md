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

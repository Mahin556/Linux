```bash
who  #Shows currently logged-in users (username, terminal, login time, etc.).

who -H  #Show column headers

who -u  #Adds idle time and PID of the user’s login process, means activity within the last minute, old means idle for more than 24h.

who -a  #Shows everything: users, processes, runlevel, boot time, dead processes, etc.

who -p  #Display all processes started by init

who -b  #Display last system boot time

who -r  #Display current runlevel

who -i  #Display current init id

who -d  #Display dead processes

who -T  #Show users’ message status (writable terminal or not)

who /var/log/wtmp  #Use specific file instead of default utmp(Shows historical login records instead of just active sessions).

who -u -H  #Show who is logged in and their IP

who -r -b  #Show runlevel and last boot time
```

### References:
- https://phoenixnap.com/kb/user-management-linux
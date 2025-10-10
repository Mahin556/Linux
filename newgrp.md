- The newgrp command is used to change the current group ID (GID) of your session. This is useful if you need to access files or execute commands restricted to a particular group.
```bash
newgrp developers  #Change to a Specific Group, Session’s GID changes to developers, Newly created files will belong to this group.
newgrp - developers  #Reinitialize Environment & Change Group, Switches to developers group and reloads login environment (like a fresh login).
newgrp  #Change Back to Default Group, returns session’s group to the default one in /etc/passwd.
```

- Switch to a Password-Protected Group
```bash
newgrp accounting
```
If not a member, you’ll be asked for the group’s password (from /etc/gshadow). Correct password → switch succeeds. Wrong password → stay in current group.

- Denied Access (No Password & Not a Member)
```bash
newgrp restricted
```
If group has no password and you’re not listed as a member, access is denied.

### References:
- https://www.tutorialspoint.com/unix_commands/newgrp.htm


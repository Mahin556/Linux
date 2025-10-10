- The userdel command is used to delete an existing user account from a Linux system. It can also remove associated files like home directories and mail spools. Requires: Root or sudo privileges. Files affected: /etc/passwd – User account info /etc/shadow – Secure account info /etc/group – Group memberships /etc/gshadow – Secure group info

```bash
sudo userdel username  #Delete a user
sudo userdel -f username  #Force delete a user
sudo userdel -r username  #Delete a user and their home directory
sudo userdel -R /mnt/chroot username  #Delete a user in a chroot environment
sudo userdel -Z username  #Remove SELinux mapping, Ensures SELinux mappings for the user are removed.
```

### References:
- https://www.geeksforgeeks.org/linux-unix/userdel-command-in-linux-with-examples/
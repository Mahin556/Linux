- The groupdel command is used to delete an existing group from a Linux system. It removes the group entry from /etc/group and /etc/gshadow. Only the root / superuser can use this command.
```bash
sudo groupdel example_group  #Delete a simple group

sudo groupdel -f example_group  #Forcefully delete a group (even if users still belong to it)

sudo groupdel -r example_group  #Delete a group and remove associated files

sudo groupdel -R /mnt/chroot example_group  #Delete a group inside a chroot environment

sudo groupdel -f -r oldgroup  #Force delete + remove associated files

sudo groupdel -R /mnt/chroot -f staging_group  #Delete group inside chroot + force
```

- Verify Group Deletion
```bash
getent group example_group
```

- https://www.geeksforgeeks.org/linux-unix/groupdel-command-in-linux-with-examples/
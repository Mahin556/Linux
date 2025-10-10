```bash
#Rename a group
sudo groupmod -n newgroup oldgroup
sudo groupmod --new-name newgroup oldgroup

#Change GID (Group ID)
sudo groupmod -g 1500 developers
sudo groupmod --gid 1500 developers

#Change GID to a non-unique value
sudo groupmod -o -g 1000 sharedgroup
sudo groupmod --non-unique --gid 1000 sharedgroup

#Change group password (encrypted)
sudo groupmod -p $(openssl passwd -crypt mypass) finance
sudo groupmod --password $(openssl passwd -crypt mypass) finance

#Modify group inside a chroot directory
sudo groupmod -R /mnt/chroot -n staginggroup oldgroup
sudo groupmod --root /mnt/chroot --new-name staginggroup oldgroup

sudo groupmod -n devteam -g 2000 developers  #Rename + change GID

sudo groupmod -o -g 1000 -n sharedgroup developers  #Non-unique GID + rename

sudo groupmod -R /mnt/chroot -g 1501 admins  #Chroot + GID change

sudo groupmod -g 1800 -p $(openssl passwd -crypt mypass) finance  #GID + password
```

- https://www.geeksforgeeks.org/linux-unix/groupmod-command-in-linux-with-examples/

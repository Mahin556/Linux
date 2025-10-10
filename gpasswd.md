- The gpasswd command is used to administer groups by editing /etc/group and /etc/gshadow. It allows setting group passwords, adding/removing members, and assigning group administrators.
```bash
sudo gpasswd -a alice developers  #Add a user to a group

sudo gpasswd -d bob developers  #Remove a user from a group

sudo gpasswd developers  #Set a password for a group

sudo gpasswd -r developers  #Remove group password

sudo gpasswd -R developers  #Restrict access to a group

sudo gpasswd -A alice,bob developers  #Assign group administrators, Makes alice and bob administrators of developers.

sudo gpasswd -M charlie,david developers  #Define group members (overwrites existing members)

sudo gpasswd -A alice -M bob,charlie developers  #Combine -A (administrators) and -M (members)

gpasswd -M Person1, Person2, Person3 Group1  #To add multiple user to a group
```

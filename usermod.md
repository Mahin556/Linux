- The usermod (user modify) command is used to change or update properties of an existing user in Linux. It directly edits system account files such as: /etc/passwd → User account details /etc/group → Group information /etc/shadow → Secure password details /etc/gshadow → Secure group info /etc/login.defs → Default login configuration ⚠️ Note: usermod must be executed as root (or with sudo).

```bash
sudo usermod -c "This is test user" test_user  #Add a comment for a user

sudo usermod -d /home/manav test_user  #Change the home directory

sudo usermod -e 2025-12-31 test_user  #Change the account expiry date

sudo usermod -g developers test_user  #Change the primary group

sudo usermod -aG sudo,docker test_user  #Add user to supplementary groups

sudo usermod -l new_user test_user  #Change the login name

sudo usermod -L test_user  #Lock a user account, Adds a ! before password hash in /etc/shadow.

sudo usermod -U test_user  #Unlock a user account

sudo usermod -p test_password test_user  #Set an (unencrypted) password

sudo usermod -s /bin/bash test_user  #Change the login shell

sudo usermod -u 1234 test_user  #Change the user ID (UID)

sudo usermod -d /home/new_home -m test_user  #Change home directory & move files

usermod -e "" john  # Remove expiry

usermod -G sudo,docker john  # Replaces old groups
usermod -a -G sudo,docker john  # Append to old groups

usermod -o -u 1000 john  # Allow duplicate UID

usermod -d /var/www/html -m -s /bin/bash -e 2025-12-31 -c "John Admin" -u 555 -aG wheel john

usermod -u 666 -g 777 john

# Set account expiry date
usermod --expiredate YYYY-MM-DD username

# Add user to supplementary groups
usermod --append --groups group1,group2 username

# Change default home directory
usermod --home /new/home/path username

# Change default shell
usermod --shell /bin/sh username

# Combine multiple options
usermod --expiredate 2014-10-30 --append --groups root,users --home /tmp --shell /bin/sh tecmint

# Lock account
usermod --lock username

# Unlock account
usermod --unlock username
```

### References:
- https://www.geeksforgeeks.org/linux-unix/usermod-command-in-linux-with-examples/
- https://linuxize.com/post/usermod-command-in-linux/
- https://www.tecmint.com/usermod-command-examples/


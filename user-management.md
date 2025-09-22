### useradd -D (/etc/default/useradd)
```bash
useradd -D #Display default user creation settings

useradd -D | grep CREATE_HOME
# Example output: CREATE_HOME yes

# Set default to create home directory
sudo useradd -D -m

# Set default to NOT create home directory
sudo useradd -D -M

# Display default values(from /etc/default/useradd)
useradd -D  ---> CREATE_HOME, HOME, SHELL, EXPIRE, INACTIVE, GROUP, USERGROUPS_ENAB

# Update default shell for new users
useradd -D | grep SHELL
useradd -D | grep -i shell
useradd -D -s /bin/bash

# Update default base dir for new users
useradd -D | grep HOME
useradd -D -b /home/users

# Update default expire for new users
useradd -D | grep EXPIRE
useradd -D -e 2025-12-31

# Update default inactive perion for new users
useradd -D | grep INACTIVE
useradd -D -f 7  #-f, --inactive INACTIVE  Days after password expiration to disable account

# Update default primary group for new users.
useradd -D | grep GROUP
sudo useradd -D -g developers

useradd -D | grep USERGROUPS_ENAB
# Example: USERGROUPS_ENAB yes

# Disable automatic user group creation
sudo useradd -D -N

# Enable automatic user group creation
sudo useradd -D -U
```
- https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/

### useradd
```
useradd john #Create a raguler user with default settings

useradd -m -s /bin/bash john #create user with home dir and shell

useradd -m -c "John Doe" -e 2025-12-31 john #Create a user with a comment and expiry date

useradd -m -G sudo,docker,developers john #Add a user to multiple groups

useradd -r -M -s /sbin/nologin sysuser #Create a system user with no home and no shell
  System users have UID in SYS_UID_MIN-SYS_UID_MAX range.
  Default: Regular users have UID in UID_MIN-UID_MAX (typically 1000+).
  System users usually no home directory unless -m is specified.

useradd -m -p $(openssl passwd -1 MyPass123) john #Set an initial password (encrypted)

useradd -m -k /etc/skel_custom john #Use a custom skeleton directory

useradd -o -u 1001 john2 #Duplicate UID (for special cases)

useradd -u 1234 test_user # add user with specific userid

useradd -g 1000 test_user # add group with specific groupid

useradd -p test_password test_user #set a unencrypted password

useradd -e 2025-12-31 john #Set account expiry date  -e, --expiredate EXPIRE_DATE

useradd -d /home/johndoe john #Specify home directory -d, --home-dir HOME_DIR

useradd -b /mnt/users john → home: /mnt/users/john #Default base directory for home directories if -d not specified  -b, --base-dir BASE_DIR

useradd -M john  # Do NOT create home directory -M, --no-create-home

useradd -m john  # Create home directory -m, --create-home

useradd -K UID_MIN=2000 john # Override /etc/login.defs defaults -K, --key KEY=VALUE

useradd -m -k /etc/skel2 john # Use a skeleton directory for home files -k, --skel SKEL_DIR

useradd -g developers john # Primary group (name or GID) -g, --gid GROUP

useradd -G sudo,docker john # Additional groups -G, --groups GROUP1,GROUP2

useradd -m -k /etc/skel2 john # Use a skeleton directory for home files -k, --skel SKEL_DIR

useradd -N -g staff john # Do not create a group with same name -N, --no-user-group

useradd -R /mnt/chroot john # Use configuration in CHROOT_DIR -R, --root CHROOT_DIR

useradd -U john # Create a group with same name -U, --user-group

useradd -Z user_u john # SELinux user -Z, --selinux-user SEUSER

useradd -Z user_u --selinux-range s0:c0.c1023 john # SELinux MLS range --selinux-range SERANGE

usermod -a -G admins,webadmin,developers tecmint

useradd -e 2014-04-27 -f 45 mansi

cat /etc/passwd | grep navin
navin:x:1002:1002::/home/navin:/bin/bash

tail -1 /etc/passwd

useradd -m -d /var/www/ravi -s /bin/bash -c "TecMint Owner" -U ravi

useradd -m -d /var/www/tarunika -s /bin/zsh -c "TecMint Technical Writer" -u 1000 -g 100 tarunika

useradd -m -d /var/www/avishek -s /usr/sbin/nologin -c "TecMint Sr. Technical Writer" -u 1019 avishek

useradd -m -d /var/www/navin -k /etc/custom.skell -s /bin/tcsh -c "No Active Member of TecMint" -u 1027 navin

useradd -M -N -r -s /bin/false -c "Disabled TecMint Member" clayton

useradd -m -d /opt/jane jane

useradd -g users -G wheel,docker john

```
- https://www.man7.org/linux/man-pages/man8/useradd.8.html
- https://www.geeksforgeeks.org/linux-unix/useradd-command-in-linux-with-examples/
- https://www.tecmint.com/add-users-in-linux/
- https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/

### adduser 
```
apt-get install adduser
yum install adduser
dnf install adduser

adduser --version
adduser -h

adduser username
adduser username --shell /bin/sh
adduser username --conf custom_config.conf
adduser username --home /home/manav/

```
- https://www.geeksforgeeks.org/linux-unix/adduser-command-in-linux-with-examples/

### id
```
id jane
uid=1005(jane) gid=1005(jane) groups=1005(jane)

id -u jane
1500

id -un jane
jane

id -g jane
1500

id -gn jane
users

```
- https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/

### passwd
```
passwd jane
  Changing password for user jane.
  New password:
  Retype new password:
  passwd: all authentication tokens updated successfully.

```
- https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/

### chage
```
chage -l john
```
- https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/

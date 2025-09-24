## User-and-group-management
- Linux ---> multi-user environment
- User ---> correct previliges, access.
- Secures the system from unauthorized access.
- Type of uses:-
  - Root (Superuser):- Full system control. Can install software, change config files, and delete anything. Powerful but risky.
  - Regular User:- Limited access. Can create files, run applications, but not modify system-level settings.
  - Sudo User:- Regular user with temporary admin rights via the sudo command. Common in modern systems.
  - System/Service Account:- Non-human accounts used by services (e.g., mysql, nginx). Limited privileges.

- Groups:- collection of users, to give collective permissions.
  - Types:
    - Primary Group (Default for files):- each user have it, creates with user account with same name as user name, only one primary group assign to user.
    - Secondary/Supplementary Group(Additional Permissions): user to give access to other files and system level resorces, user can be part of many secondary groups.

---
---

### 🔹 Linux User Management Files

These files are critical for **managing users, groups, and permissions** in Linux. They help ensure security, access control, and proper administration.
```
/etc/passwd #database files
/etc/shadow
/etc/groups
/etc/gshadow
/etc/login.defs
/etc/skel/
/etc/sudoers
/etc/sudoers.d/
```

---

#### 👤 User Information

##### **/etc/passwd**

* Stores **basic user account details**.
* Each line represents a user, with fields separated by `:`.
* Use `vipw` to access the file or directly vim into it.
* Format:

  ```
  username:password:UID:GID:full_name:home_directory:shell
  ```

  * **username** → login name
  * **password** → placeholder (`x`) if password stored in `/etc/shadow`
  * **UID** → User ID
  * **GID** → Primary Group ID
  * **full\_name** → User info (GECOS field)
  * **home\_directory** → User’s home path
  * **shell** → Default shell (`/bin/bash`, `/bin/sh`, etc.)

🔎 Example:

```
john:x:1001:1001:John Doe:/home/john:/bin/bash
```

---

##### **/etc/shadow**

* Stores **encrypted passwords** and **password policies**.
* Only accessible by root for security.
* Fields:

  ```
  username:encrypted_password:last_change:min:max:warn:inactive:expire:
  ```

  * **last\_change** → days since epoch when password was last changed
  * **min/max** → password aging (min/max days before change)
  * **warn** → days before expiry to warn
  * **inactive** → days after expiry before account disabled
  * **expire** → account expiration date

---

#### 👥 Group Management

##### **/etc/group**

* Defines **groups** and memberships.
* Format:
* Use `vigr` to access the file or directly vim into it.

  ```
  group_name:password:GID:user_list
  ```

  * **group\_name** → name of group
  * **password** → rarely used, usually `x`
  * **GID** → Group ID
  * **user\_list** → comma-separated users

🔎 Example:

```
developers:x:1002:alice,bob
```

---

##### **/etc/gshadow**

* Secure counterpart of `/etc/group`.
* Stores **group passwords and admin roles**.
* Format:

  ```
  group_name:encrypted_password:administrators:members
  ```

🔎 Example:

```
developers:!:carol:alice,bob
```

---

#### 🔐 Privilege Control

##### **/etc/login.defs**
* Used to control the password policy and other user default settings.
* -> [Visit My Project Page](https://github.com/Mahin556/Linux/blob/main/login.defs.md)
  ```
  ```

##### **/etc/sudoers**

* Defines **sudo access policies**.
* Edited safely with:

  ```bash
  visudo
  ```
* Controls:

  * **Who** can run sudo
  * **What commands** they can run
  * **From where** they can run them

🔎 Example:

```
alice  ALL=(ALL:ALL) ALL
%admins ALL=(ALL) NOPASSWD: ALL
```

---

#### 🏠 User Home Directory Setup

##### **/etc/skel/**

* Skeleton directory for **default home setup**.
* Contents copied when a new user is created.
* Common files:

  * `.bashrc`
  * `.profile`
  * `.bash_logout`

---

#### 📜 Logs and Auditing

##### **/var/log/auth.log**  *(Debian/Ubuntu)*

* Records **authentication and authorization events**:

  * Login attempts (success/failure)
  * `sudo` usage
  * Account lock/unlock events
  * PAM messages

*(On RHEL/CentOS, equivalent is `/var/log/secure`.)*

![alt text](/images/1_yjmsXWG-mm6PoAKhYvApPQ.gif)

---
- https://www.geeksforgeeks.org/linux-unix/user-management-in-linux/


---
---

### su
```
su       # Use current directory
su -     # Start in root home directory
```
- https://www.tecmint.com/manage-users-and-groups-in-linux/

### visudo(/etc/sudoers)
```
visudo

# User with full access
root ALL=(ALL) ALL

# User can run specific command
tecmint ALL=/bin/yum update

# User can run specific command without password
gacanepa ALL=NOPASSWD:/bin/updatedb

# Group can run all commands
%admin ALL=(ALL) ALL
```
- https://www.tecmint.com/manage-users-and-groups-in-linux/

### who
```
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
- https://phoenixnap.com/kb/user-management-linux

      
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
```bash
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
```bash
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
```bash
id jane
uid=1005(jane) gid=1005(jane) groups=1005(jane)

id -u #current user id

id -un  #current user name

id -u jane
1500

id -un jane
jane

id -g  #give primary group of current user

id -g jane  #give primary group id
1500

id -gn jane  #give primary group name
users

id -Gn #give group membership of current user

id -Gn root #give group membership of specific user

echo "The current username is '$USER'."
printf "The current username is '%s'.\n" "$USER"
id
whoami

```
- https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/
- https://www.cyberciti.biz/faq/unix-linux-groups-command-examples-syntax-usage/

### awk
```
awk -F':' '{ print $1}' /etc/passwd #to get list of all users
```

### group
```
groups --help
groups --version
groups  ## group membership of surrent user
groups [username]  #to view user group membership
groups | wc -w  #Count Number of Groups

#Bash Script – Group Memberships for All Users
for u in $(compgen -u)
do   
  echo "*** Group memembership for $u:"
  groups "$u"
  echo
done

```
- https://www.geeksforgeeks.org/linux-unix/groups-command-in-linux-with-examples/
- https://man7.org/linux/man-pages/man1/groups.1.html
- https://www.cyberciti.biz/faq/unix-linux-groups-command-examples-syntax-usage/

### passwd
```bash
passwd jane
  Changing password for user jane.
  New password:
  Retype new password:
  passwd: all authentication tokens updated successfully.

passwd --> # change password for current user

sudo passwd user1 ---> # Change Another User’s Password (as root or with sudo)

sudo passwd -d user1 ---> # Delete a User Password (-d)

sudo passwd -e user1 ---> # Expire Password Immediately (-e)

sudo passwd -i 7 user1 ---> # Set Inactive Period (-i)

sudo passwd -k user1 # Keep Tokens (-k) Changes password only if it is expired, otherwise ignores request.

sudo passwd -l user1 # Lock Account (-l), Locks user1’s password (they can’t log in with password). SSH keys may still work.

sudo passwd -n 5 user1 # Prevents user1 from changing password again for 5 days.

Quiet Mode (-q) # Suppresses messages like “Changing password for user1”.

sudo passwd -r files user1 #Selects repository (useful in NIS/LDAP setups).

sudo passwd -R /mnt/chroot user1 #Change Root Directory (-R), Applies password change inside /mnt/chroot environment (useful in recovery).

passwd -S user1 #Password Status (-S), Shows password status. Example output:
  user1 P 09/23/2025 0 99999 7 -1
  P → password set
  L → locked
  fields = min, max, warn, inactive days

sudo passwd -a -S #Lists password status of all accounts.

sudo passwd -u user1 #Unlocks password → login allowed again.

sudo passwd -w 7 user1 #Warns user1 7 days before password expiry.

sudo passwd -x 30 user1 #Forces password change after 30 days.
```
- https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/
- https://www.geeksforgeeks.org/linux-unix/passwd-command-in-linux-with-examples/


### getent
```
getent group

getent group | awk -F: '$4 != "" {print $1 ": " $4}'

getent group test_group
```
- https://phoenixnap.com/kb/user-management-linux

  
### chage
The chage command (short for change age) is used to manage user password expiry and account aging information. It allows system administrators to enforce password policies, set expiration dates, and manage account inactivity.

Requires: Root or sudo privileges to modify other users.

Files affected: /etc/shadow (where password aging info is stored).
```bash
chage username  #open a interactive mode


# View Account Aging Information
chage -l john #List Account Aging Information
Output shows:
  Last password change
  Password expires
  Password inactive
  Account expires
  Minimum / maximum days between password changes
  Warning period

sudo chage -d 2024-09-01 user1 #Set Last Password Change Date
sudo chage -l user1   # Verify

chage -d 0 rheluser #Force password change at next login

sudo chage -E 2025-12-31 user1 #Set Account Expiry Date
sudo chage -l user1   # Verify

sudo chage -M 90 user1   # Max 90 days between password changes
sudo chage -m 7 user1    # Min 7 days between changes
sudo chage -l user1      # Verify

sudo chage -I 5 user1 # Set Inactivity Period After Password Expiry
sudo chage -l user1   # Verify inactivity period

chage -I -1 rheluser #Reset to default

sudo chage -W 10 user1 # Set Password Expiry Warning
sudo chage -l user1   # Verify warning period

sudo chage -M 90 -m 7 -W 10 -E 2025-12-31 user1 
```
- Password Aging Policy Explained
  ```
  Last password change date → Used as reference for expiry calculation.
  Password expiry date → Last change + Max days.
  Password inactive date → Expiry + Inactivity days. Locks account if password not changed.
  Account expiry date → Absolute date when account is disabled.
  Minimum days → Minimum days before password can be changed again.
  Maximum days → Maximum days password is valid.
  Warning days → Days before expiry to notify user.
  ```
- Example Policy
  ```
  User changes password on 1 Jan with policy:
    Min days: 2
    Max days: 20
    Warning: 5
    Inactive: 3
  Result:
    Can’t change again till 3 Jan
    Expires on 20 Jan
    Warning starts 16 Jan
    Account locks 23 Jan if password not updated
  ```
- https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/
- https://www.geeksforgeeks.org/linux-unix/chage-command-in-linux-with-examples/
- https://www.computernetworkingnotes.com/linux-tutorials/the-chage-command-examples-and-usages.html
- https://www.computernetworkingnotes.com/linux-tutorials/password-aging-policy-explained-with-chage-command.html
- https://man7.org/linux/man-pages/man1/chage.1.html
- https://www.geeksforgeeks.org/linux-unix/chage-command-in-linux-with-examples/

### groupadd
```bash
sudo groupadd developers  #Create a simple group

sudo groupadd -f developers  #Force creation (ignore if already exists)

sudo groupadd -g 1050 developers  #Create with specific GID

sudo groupadd -f -g 1050 developers  #Force + GID (ignores duplicate GID if exists)

sudo groupadd -o -g 1000 sharedgroup  #Allow non-unique GID

sudo groupadd -r sysadmins  #Create system group

sudo groupadd -K GID_MIN=500 -K GID_MAX=700 testers  #Override defaults (/etc/login.defs)

sudo groupadd -R /mnt/chroot developers  #Use chroot environment

sudo groupadd -r -g 800 syslogs  #System group + custom GID

sudo groupadd -f -o -g 1000 -p $(openssl passwd -crypt mypass) devops  #Force, non-unique, and password

sudo groupadd -r -K GID_MIN=200 -K GID_MAX=300 servicegroup  #Override defaults + system group

sudo groupadd -R /mnt/chroot -g 1200 staging_group  #Chroot + GID
```
- Create group with encrypted password
  Must use openssl or crypt to generate encrypted password.
```bash
# Generate encrypted password:
openssl passwd -crypt mypass
# Example output: abcd1234

# Use it in groupadd:
sudo groupadd -p abcd1234 finance
```
- Verify Group Creation
```bash
getent group developers
tail -n 5 /etc/group
```
- https://www.geeksforgeeks.org/linux-unix/groupadd-command-in-linux-with-examples/

### groupmod
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

### groupdel
The groupdel command is used to delete an existing group from a Linux system.
It removes the group entry from /etc/group and /etc/gshadow.
Only the root / superuser can use this command.
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

### gpasswd
The gpasswd command is used to administer groups by editing /etc/group and /etc/gshadow.
It allows setting group passwords, adding/removing members, and assigning group administrators.
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
Verification
```bash
getent group developers
```
```bash
sudo cat /etc/gshadow | grep developers
```
- https://www.geeksforgeeks.org/linux-unix/gpasswd-command-in-linux-with-examples/
- https://www.geeksforgeeks.org/linux-unix/group-management-in-linux/

### newgrp
The newgrp command is used to change the current group ID (GID) of your session.
This is useful if you need to access files or execute commands restricted to a particular group.
```bash
newgrp developers  #Change to a Specific Group, Session’s GID changes to developers, Newly created files will belong to this group.
newgrp - developers  #Reinitialize Environment & Change Group, Switches to developers group and reloads login environment (like a fresh login).
newgrp  #Change Back to Default Group, returns session’s group to the default one in /etc/passwd.
```
- Switch to a Password-Protected Group
  ```bash
  newgrp accounting
  ```
  If not a member, you’ll be asked for the group’s password (from /etc/gshadow).
  Correct password → switch succeeds.
  Wrong password → stay in current group.
  
- Denied Access (No Password & Not a Member)
  ```bash
  newgrp restricted
  ```
  If group has no password and you’re not listed as a member, access is denied.

- https://www.tutorialspoint.com/unix_commands/newgrp.htm

### usermod
The usermod (user modify) command is used to change or update properties of an existing user in Linux.
  It directly edits system account files such as:
  /etc/passwd → User account details
  /etc/group → Group information
  /etc/shadow → Secure password details
  /etc/gshadow → Secure group info
  /etc/login.defs → Default login configuration
⚠️ Note: usermod must be executed as root (or with sudo).

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
- https://www.geeksforgeeks.org/linux-unix/usermod-command-in-linux-with-examples/
- https://linuxize.com/post/usermod-command-in-linux/
- https://www.tecmint.com/usermod-command-examples/

### userdel
The userdel command is used to delete an existing user account from a Linux system. It can also remove associated files like home directories and mail spools.
Requires: Root or sudo privileges.
  Files affected:
    /etc/passwd – User account info
    /etc/shadow – Secure account info
    /etc/group – Group memberships
    /etc/gshadow – Secure group info

```bash
sudo userdel username  #Delete a user
sudo userdel -f username  #Force delete a user
sudo userdel -r username  #Delete a user and their home directory
sudo userdel -R /mnt/chroot username  #Delete a user in a chroot environment
sudo userdel -Z username  #Remove SELinux mapping, Ensures SELinux mappings for the user are removed.
```
- https://www.geeksforgeeks.org/linux-unix/userdel-command-in-linux-with-examples/
  

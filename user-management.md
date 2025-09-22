### useradd -D (/etc/default/useradd)
```
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
useradd -D -s /bin/bash

# Update default base dir for new users
useradd -D | grep HOME
useradd -D -b /home/users

# Update default expire for new users
useradd -D | grep EXPIRE
useradd -D -e 2025-12-31

# Update default inactive perion for new users
useradd -D | grep INACTIVE
useradd -D -f 7

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

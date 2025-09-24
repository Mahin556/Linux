### chattr
```
# Make a file immutable
chattr +i file1

# Make a file append-only
chattr +a file2

# View attributes
lsattr filename
```
- https://www.tecmint.com/manage-users-and-groups-in-linux/


### Managing Shared Directories
```
# Create directory
mkdir /shared-directory

# Assign directory to group
chown :group_name /shared-directory

# Set permissions
chmod 770 /shared-directory
```
- https://blog.devops.dev/unlocking-the-secrets-of-user-and-group-management-in-linux-ab49e3acaf3c
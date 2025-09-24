### User and Group Quotas
```
# Enable quotas on filesystem
mount -o remount,usrquota,grpquota /dev/sda1

# Check quota
quotacheck -cu /home
quotacheck -cg /home

# Edit quota for user
edquota -u username

# Edit quota for group
edquota -g group_name
```


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

echo "newpassword" | passwd --stdin username #--stdin option reads a password from standard input. This is commonly used in scripts or automation.
echo "MySecurePass123" | sudo passwd --stdin mahin

echo "mahin:MySecurePass123" | sudo chpasswd #on ubuntu/debian --stdin not available so we can use the chpasswd
```
```bash
#!/bin/bash
# Change passwords for multiple users

while IFS=: read -r user pass; do
    echo "$user:$pass" | sudo chpasswd
done <<EOF
mahin:Pass1234
john:Secure@567
alice:MyPass!890
EOF
```
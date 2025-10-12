The chown command (short for change owner) is used in Linux/Unix to change the ownership of a file, directory, or symbolic link.
```bash
chown [user_name] [file_name/directory]

chown -R user:group /var/www/html

chown user:group file.txt

chown username file.txt #only user

chown username: file.txt #user group same

chown username:groupname file.txt

chown -R NewUser:NewGroup DirNameOrPath #change recursive permission

chown -R :developers project #only group

chown -R www-data:www-data /var/www/html

chown 1000 example.txt #change owner with uid

chown root sample2 sample3 #change owner of multiple files/dir
chown root sample3 Dir1

chown :1003 example.txt

chown --reference=tutorial.md index.html #Transfer Ownership and Group Settings from One File to Another

chown --from=CurrentUser:CurrentGroup NewUser:NewGroup FILE #check before applying

chown --from=CurrentUser NewUser FILE #check owner only

chown --from=:CurrentGroup :NewGroup FILE #check group only

sudo chown -Rv mahin:dev /opt/app

sudo chown --reference=oldfile.txt newfile.txt

sudo chown -h root link #Modifies symlink itself, not target

chown -v user file #Verbose mode (show all actions)

chown -c user file #Show only changed files

chown -f user file #Suppress most error messages

chown --preserve-root -R user / #Prevent recursive change to /

chown --no-preserve-root -R root / #Allow changing / (dangerous!)

find /path/to/dir -type f -size +10M -exec chown user:group {} \;

find /var/log -name "*.log" -exec chown root:adm {} \;


```

* By default, chown changes the target file the symlink points to.
To change the symlink itself, use -h:
```bash
sudo chown -h root:root mylink
```

* Use the -f (force) option to suppress most error messages:
```bash
sudo chown -f invaliduser file.txt
```

### References:
- https://phoenixnap.com/kb/linux-file-permissions
- https://phoenixnap.com/kb/linux-chown-command-with-examples
- https://man7.org/linux/man-pages/man1/chown.1.html
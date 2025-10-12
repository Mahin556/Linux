- Find always to hierarchical search
```bash
find <path>

find <path> -type f

find <path> -type d

find <path> -type d,f,l,s,b,c

find /etc/ -type d -maxdepth 2

find /etc/ -type d -mindepth 2

find /path -printf "%p\n"

find /path -exec stat {} \;

find <path> -type f -name "*.log"

find <path> -type d -name "docs"

find ~ -name "example.txt"

find ~ -name "*example*.txt" #approx name

find ~ -iname "example.txt" #case-insensitive search

find <path> -name sample.txt -exec rm -i {} \;

find <path> -perm 664

find <path> -perm 664 > file.names

find . -type f -perm 0777 -print #Exact permission

find . -type f -perm -0666 -print #at least these permission

find . -type f -perm /0644 -print #at most these permission

find / -type f ! -perm 0644

find / -type f ! -perm 0644 | less

find <dir> -ls #recursive search like ls -R

find <path> -type d -maxdepth 1 #0--> no search, 1--> search in specified dir 2--> search in only the sub dir etc...

find <path> -type f -empty

find <path> -type d -name "*.img"  -ipath "*path/example.com*" 2> /tmp/file.names   # search absolute path

find <path> -type f -name "*.txt" -exec grep 'Geek' {} \;

find <path> -type f -mtime -7

find . -type f -name "*.txt" -and -size +1M

find . -name "example.com" -or -mtime -2

find /var/logs/ -type f -name "*.log" -size +50M -mtime +30

find <path> -user demo

find <path> -group developer

find <path> -type f -name "*.log" -mtime +7 -exec rm {} \;

find <path> -user demo -iname "*.txt"

find <path> -type f -name "*.mp3" -size +10M -exec rm {} \;

find <path> -type f -name "*.log" -size +100M -exec gzip {} \;

find <path> -type f -name "*.log" -exec mv {} /backup/logs \;

find <path> -type f -name "*.sh" -exec chmod +x {} \;

find <path> -type f -name "*.txt" -exec mv {} {}.bak \;

find <path> -type f -name "*.log" -ok rm {} \; #work similar as -exec but provide interactive prompt for confirmation.

find <path> -type f -name "*.log" -ok mv {} /backup/logs \;

find . -type f | find  -name "*.log"

find . -perm 2644

find / -perm 1644

find / -perm /u=s #SUID

find / -perm /g=s #SGID

find / -perm /u=r #readonly file

find / -perm /a=x #executable file

find / -mtime +50 -mtime -100

find / -cmin -60 #changed in last 60 min

find / -mmin -60 #modified in last 60 min

find / -amin -60 #accessed in last 60 min

find / -size 1k

find / -size +50M -size -100M

find / -not -name "demo" == find / \! -name "demo" #\ for escape , give files that not have this keyword

find / -newer file1

find <path> -type f -size +1M #b=512bytes, c=bytes, k, M , G, + , -

find <path> -type f -exec grep -l "example" {} + #+ allow find to pass more then 1 file to grep

find /path ! -user $(whoami) #current user

find /path -type f -name "*.tmp" -delete #Delete matching files (dangerous ⚠️)

find /path -type f -name "*.log" -exec rm {} \; #Run a command on each file

find /path -type f -name "*.tmp" -ok rm {} \; #Safer delete with confirmation

find /path -type f -empty -exec rm {} \; #remove empty files

find /path -type d -empty -exec rmdir {} \; #remove empty directory

find /path -type f -name "*.sh" -exec ls -l {} \;

find /path -type f -exec file {} \;

find /path -type f -exec readlink -f {} \;

find /path -type f -name "*.sh" -exec chmod +x {} \;

find /path -type f -name "*.log" -exec chown john {} \;

find /path -type f -exec chmod o-w {} \;

find /path -type f -name "*.log" -exec gzip {} \;

find /path -type f -name "*.txt" -exec tar -rvf backup.tar {} \;

find /path -type f -name "*.conf" -exec grep -H "password" {} \;

find /path -type f -name "*.py" -exec wc -l {} \;

find /path -type f -name "*.log" -exec rm {} + #much faster

find /path -type f -name "*.jpg" -exec mv {} /images/ \;

find /path -xtype l -exec rm {} \;

find /path -type f -size +100M -exec ls -lh {} \;

find /path -type f -name "*.txt" -exec sed -i 's/foo/bar/g' {} \;

find /var/log -iname "*~" -o -iname "*log*" -mtime +30

find /var/log -iname "*~" -o -iname "*log*" -mtime -7

find /var/log -iname "*~" -o -iname "*log*" -mtime -7 -ls

find / -type d -name 'img' -ipath "*public_html/example.com*" 2>/dev/null

find -perm -111 -exec chmod -R 777 {} \;

find / -user root -2000 -exec ls -ldb {} \; > /tmp/ckprm

find directory -user root -perm -4000 -exec ls -ldb {} \; >/tmp/filename

find /var/www/html -type d -exec chmod u=rwx,go=rx {} \;

# delete empty directories under /path (safe)
find /path -type d -empty -delete

# delete directories named "tmp" anywhere under /path
find /path -type d -name tmp -exec rm -r {} +

# delete files older than 30 days and then empty dirs
find /path -type f -mtime +30 -exec rm -f {} +
find /path -type d -empty -delete

# avoid crossing mount points (xdev)
find /path -xdev -type d -name cache -exec rm -r {} +



```

References:-

- https://phoenixnap.com/kb/guide-linux-find-command
- https://www.redhat.com/en/blog/linux-find-command
- https://www.geeksforgeeks.org/linux-unix/find-command-in-linux-with-examples/
- https://man7.org/linux/man-pages/man1/find.1.html
- https://www.redhat.com/en/blog/audit-permissions-find
- https://www.geeksforgeeks.org/linux-unix/finding-files-with-suid-and-sgid-permissions-in-linux/
- https://www.warp.dev/terminus/how-to-run-chmod-recursively
- https://phoenixnap.com/kb/chmod-recursive#:~:text=chmod%20Recursive%20Syntax,want%20to%20apply%20the%20changes.
- https://ioflood.com/blog/chmod-recursive/#:~:text=Recursive%20User%20Guide-,Basics%20of%20chmod%20Recursive,read%20for%20group%20and%20others).&text=In%20this%20example%2C%20we've,applying%20them%20to%20large%20directories.
- https://www.unixmen.com/introduction-to-chmod-recursive/
- https://linuxize.com/post/chmod-recursive/#:~:text=files%20and%20directories.-,Chmod%20Recursive,exec%20chmod%20644%20%7B%7D%20%5C


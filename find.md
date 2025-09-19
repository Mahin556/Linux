- Find always to hierarchical search
```
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





```

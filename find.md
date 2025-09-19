- Find always to hierarchical search
```
find <path>

find <path> -type f

find <path> -type d

find <path> -type d,f

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


```

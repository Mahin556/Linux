- List only directories
  `ls -ld */`
  `find <path> -type d`
  
- List only files
  `find <path> -type f`

- Change permission only for files
  `find <path> -type f -exec chmod 750 {} \;`
    

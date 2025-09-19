- List only directories
  `ls -ld */`
  `find <path> -type d`
  
- List only files
  `find <path> -type f`

- Change permission only for files
  `find <path> -type f -exec chmod 750 {} \;`

- Recursive listing
  - `find <path>`
  - `ls -Ra`
  - `find <path> -type f`
  - `find <path> -type d`
  - `tree <path>`
  - `tree -d <path>` #only directory
  - `du -a /path` #Primarily for disk usage, but shows recursive directory structure.
  - `du --max-depth=1 /path`
  - `find /etc/ -type d -maxdepth 2`
  - `find /etc/ -type d -mindepth 2`
  - `ls -R /path | grep pattern`
  - `find /path -printf "%p\n"`
  - `rsync -av --list-only /path/`
  - `tar -cvf - /path | less`
  - `find /path -exec stat {} \;`
  
    

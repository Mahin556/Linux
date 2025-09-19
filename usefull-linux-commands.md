- List only directories
  `ls -ld */`
  `find <path> -type d`
  
- List only files
  `find <path> -type f`

- Change permission only for files
  `find <path> -type f -exec chmod 750 {} \;`

- Recursive listing
  - `ls -Ra`
  - `tree <path>`
  - `tree -d <path>` #only directory
  - `du -a /path` #Primarily for disk usage, but shows recursive directory structure.
  - `du --max-depth=1 /path`
  - `ls -R /path | grep pattern`
  - `rsync -av --list-only /path/`
  - `tar -cvf - /path | less`

  
    

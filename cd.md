```bash
cd
cd /home/mahin/Documents
cd or cd ~ #Goes to your home directory (/home/username).
cd / #Goes to the root directory.
cd .. #Moves up one directory (parent directory).
cd ../.. #Moves up two directories.
cd - #Switches to previous directory.
cd . #Refers to current directory (rarely used).

#Absolute path: starts from root /
cd /var/log 

#Relative path: relative to current directory
cd ../logs     # go to "logs" folder in parent directory
cd ./scripts   # go to "scripts" inside current directory
```

* Store current directory for later use:
```bash
current_dir=$(pwd)
cd /tmp
# do something
cd "$current_dir"
```

* Notes
- cd is a shell built-in command (like in bash or zsh).
- No output is shown if it succeeds; errors appear if the directory doesn’t exist:
```bash
cd /nonexistent
bash: cd: /nonexistent: No such file or directory
```

* Directory names with spaces:
```bash
cd "My songs"   # double quotes
cd 'My songs'   # single quotes
cd My\ songs    # escape spaces
```

### References:
- https://www.geeksforgeeks.org/linux-unix/cd-command-in-linux-with-examples/
- https://www.w3schools.com/bash/bash_cd.php
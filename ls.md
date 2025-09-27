* List file and directory in current working directory
    ```bash
    ls
    ```

* List file and directory in the specified directory
    ```bash
    ls <dir>
    ls -l /etc
    ```

* To see detaile about directory itself
    ```bash
    ls -ld /etc
    ```

* Long listing
    ```
    ls -l
    ```
    Shows details like permissions, owner, group, size, and modification date.
    Example:
    ```
    -rw-r--r-- 1 user user 1024 Sep 27 10:00 file.txt
    ```

* Include Hidden Files
    - Shows hidden files (those starting with .)
        ```bash
        ls -a
        ```
    - To exclude (.) and (..)
        ```bash
        ls -A
        ```

* Long Format with Hidden Files
    ```bash
    ls -al
    ```

* Sorting Options
    ```bash
    ls -t      # Sort by modification time (newest first)
    ls -r      # Reverse order
    ls -S      # Sort by file size
    ls -X      # Sort by file extension
    ls -v      # Sort by version number
    ```
    - Long format, reverse, sorted by modification time (oldest first)
        ```bash
        ls -lrt
        ```

* Display Options
    ```bash
    ls -1      # List one file per line
    ls -C      # List in columns (default)
    ls -m      # Comma-separated list
    ls -x      # List horizontally by rows
    ls -p      # Adds `/` after directories
    ls -F      # Adds `/` for directories, `*` for executables, `@` for symlinks
    ls --color=auto  # Color-coded output
    ```
    ```bash
    ls --color=no
    Valid arguments are:
    - ‘always’, ‘yes’, ‘force’
    - ‘never’, ‘no’, ‘none’
    - ‘auto’, ‘tty’, ‘if-tty’
    ```

* Size & Human Readable Format
    ```bash
    ls -lh     # Long format with human-readable sizes (KB, MB, GB)
    ls -lS     # Sort by size
    ls -lhS    # Long format + human-readable + sorted by size
    ```

* Recursive Listing
    Lists directories recursively, showing all subdirectories.
    ```bash
    ls -R
    ```

* File Type & Permissions
    ```bash
    ls -l      # Show file types, permissions, links, owner, size, date
    ls -ld dir # Show info about a directory itself, not its contents
    ```
    ```bash
    Permission symbols:
        - = regular file
        d = directory
        l = symbolic link
        rwx = read, write, execute
    ```

* Indicators and Extra Info
    ```bash
    ls -i      # Show inode number
    ls -n      # Numeric UID and GID instead of names
     ls -n ~/kv
    ls -g      # Long format without owner
    ls -o      # Long format without group
    ls -s      # Show file size in blocks
    ls -h      # Human-readable file size
    ls --full-time  # Full timestamp with seconds
    ```

* Filtering by Patterns
    ```bash
    ls *.txt          # Only .txt files
    ls file?          # Matches file1, file2, etc.
    ls [A-Z]*         # Files starting with capital letters
    ```

* Combined Examples
    ```bash
    ls -lahtr       # Long, all files, human-readable, oldest first
    ls -lp          # Shows directories with / at the end
    ls -lR          # Recursive long listing
    ls -lhS         # Sort by size with human-readable sizes
    ```

* Aliases (Optional)
    ```bash
    alias ll='ls -l'
    alias la='ls -a'
    alias l='ls -CF'
    ```

* Open Last Edited File Using `ls -t `
    ```bash
    ls -t | head -1

* Hide Control Characters Using `ls -q` 
    Sometimes, files or folders may have irregular or non-printable characters which is called control characters in their names basically they can mess up your terminal display or be confusing to read.
    Use ls -q command is a safe way to list files while hiding those confusing characters.
    ```bash
    ls -q 
    ```

* Change the way time information is displayed using --time-style flag.
    When you list files using the ls -l command in Linux, it shows the last modified time of each file. This flag lets you customize the format of the time/date shown next to each file or folder.
    ```bash
    ls -l --time-style=long-iso
    ```
    This command will display the time in YYYY-MM-DD HH:MM format. There are other options like
    - locale
    - full-iso
    - iso

* To list directory only
    ```bash
    ls -d */
    ```

* Ignoring a file
    ```bash
    ls --ignore=PATTERN
    ```
    ```bash
    ls --ignore="*.txt"
    ls --ignore="secret.txt"
    ls --ignore="*.log,*.tmp"
    ls -l --ignore="*.bak"
    ls -l --ignore="lost+found"
    ```


### References:
- https://www.geeksforgeeks.org/linux-unix/ls-command-in-linux/
- https://www.w3schools.com/bash/bash_ls.php

* Print current working directory
    ```bash
    pwd
    ```

* Options
    | Option | Description                                                                   |
    | ------ | ----------------------------------------------------------------------------- |
    | `-L`   | Prints the **logical path** (respects symbolic links). This is the default.   |
    | `-P`   | Prints the **physical path** (resolves symbolic links to actual directories). |


* Example: Logical vs Physical Path
    Suppose you have a symbolic link:
    ```bash
    /home/mahin/link -> /var/www/html
    cd /home/mahin/link
    pwd       # prints /home/mahin/link (logical)
    pwd -P    # prints /var/www/html (physical)
    ```
    - Logical (-L) → Shows the path you navigated through.
    - Physical (-P) → Shows the actual directory on the filesystem.

* `pwd` is often used in shell scripts to store the current directory:
    ```bash
    current_dir=$(pwd)
    echo "You are in $current_dir"
    ```
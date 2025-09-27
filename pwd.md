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

* ENV `PWD`
- The $PWD environment variable is a dynamic variable that stores the path of the current working directory. It holds the same value as 'pwd -L' – representing the symbolic path.
```bash
echo $PWD
```

* See Previous Working Directory
```bash
echo $OLDPWD
```

```bash
pwd --help
pwd --version
```

```bash
#!/bin/bash
echo "I need to see:"
echo "1 - My current physical directory path."
echo "2 - My current directory path, including symlinks."
echo "3 - My previous directory"
read directory
case $directory in
1) echo "Your current physical location is: $(pwd -P)";;
2) echo "Your current directory, including symlinks, is: $(pwd -L)";;
3) echo "You were previously in: $OLDPWD";;
esac
```

* Set up an Alias for pwd
```bash
alias pwd='pwd -P'; echo "alias pwd='pwd -P'" >> ~/.bashrc
```

### References:
- https://www.geeksforgeeks.org/linux-unix/pwd-command-in-linux-with-examples/
- https://phoenixnap.com/kb/pwd-linux
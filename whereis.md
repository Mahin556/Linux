The whereis command locates the binary, source code, and manual (man) page files for a given command.
Unlike which, which only searches your `$PATH`, whereis searches predefined system directories such as `/bin`, `/sbin`, `/usr/bin`, `/usr/share/man`, etc.

* Find where a command’s binary executable is located.
* Find the source code (if available).
* Find the man page documentation file.
* Useful for package troubleshooting or verifying installations.

| Option        | Description                                                                       | Example                           |
| ------------- | --------------------------------------------------------------------------------- | --------------------------------- |
| *(no option)* | Display locations of binary, source, and man page                                 | `whereis ls`                      |
| `-b`          | Search **only for binaries**                                                      | `whereis -b python`               |
| `-m`          | Search **only for man pages**                                                     | `whereis -m systemctl`            |
| `-s`          | Search **only for source files**                                                  | `whereis -s bash`                 |
| `-u`          | Search for commands **without** one or more types of entries (useful for cleanup) | `whereis -u -m -s`                |
| `-B`          | Limit or specify **binary search path**                                           | `whereis -B /usr/bin -f python`   |
| `-M`          | Limit or specify **man page search path**                                         | `whereis -M /usr/share/man -f ls` |
| `-S`          | Limit or specify **source file search path**                                      | `whereis -S /usr/src -f bash`     |
| `-f`          | Must be used with `-B`, `-M`, or `-S` to separate paths from command names        | `whereis -B /usr/bin -f python`   |

```bash
sudo apt install util-linux
sudo yum install util-linux
sudo pacman -S util-linux
```

```bash
whereis ls
ls: /bin/ls /usr/share/man/man1/ls.1.gz

whereis -b bash
bash: /usr/bin/bash /bin/bash

whereis -m passwd
passwd: /usr/share/man/man1/passwd.1.gz

whereis -s grep
grep: /usr/src/grep

whereis -u -m
whereis -B /usr/bin -f python
whereis bash python gcc
bash: /bin/bash /usr/share/man/man1/bash.1.gz
python: /usr/bin/python /usr/share/man/man1/python.1.gz
gcc: /usr/bin/gcc /usr/share/man/man1/gcc.1.gz

$ whereis systemctl
systemctl: /bin/systemctl /usr/share/man/man1/systemctl.1.gz

$ whereis -b vim
vim: /usr/bin/vim /usr/local/bin/vim

$ whereis -m chown
chown: /usr/share/man/man1/chown.1.gz

```


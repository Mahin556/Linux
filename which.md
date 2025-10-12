The which command in Linux is used to find the location (absolute path) of executables that would run when you type a command in the terminal.

It searches for the command in the directories listed in your $PATH environment variable and displays the first match it finds.

```bash
sudo apt install debianutils #Debian/Ubuntu
sudo yum install which #RHEL/CentOS/Fedora
sudo pacman -S which #Arch Linux
```

```bash
echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
```
```bash
ubuntu:~$ type echo
echo is a shell builtin
ubuntu:~$ which echo
/usr/bin/echo

which ls
which bash
which sudo
which vim
which python3

which -a python
/usr/bin/python
/usr/local/bin/python


alias ls
which ls
alias ls='ls --color=auto'
/bin/ls

```

To find the full path of a command or executable file.

To verify which version of a command will execute when multiple versions exist.

To troubleshoot PATH issues (e.g., when a command isn’t found).


| Option             | Description                                               | Example                      |
| ------------------ | --------------------------------------------------------- | ---------------------------- |
| *(no option)*      | Display the path of the first matching executable         | `which python`               |
| `-a`               | Show **all** matching executables found in `$PATH`        | `which -a python`            |
| `--skip-alias`     | Skip alias definitions when searching                     | `which --skip-alias ls`      |
| `--skip-functions` | Skip shell functions                                      | `which --skip-functions cd`  |
| `--show-dot`       | Show if the current directory (`.`) is in the search path | `which --show-dot script.sh` |
| `--show-tilde`     | Show paths with `~` for the home directory                | `which --show-tilde python`  |
| `--version`        | Display version information                               | `which --version`            |
| `--help`           | Display help menu                                         | `which --help`               |


| Command   | Description                                                           | Example          |
| --------- | --------------------------------------------------------------------- | ---------------- |
| `which`   | Shows **path of executables** found in `$PATH`                        | `which python`   |
| `whereis` | Shows locations of **binary, source, and man page**                   | `whereis python` |
| `type`    | Tells whether a command is an alias, keyword, function, internal, external, or executable | `type python`    |

```bash
which ls
# /bin/ls

whereis ls
# ls: /bin/ls /usr/share/man/man1/ls.1.gz

type ls
# ls is aliased to `ls --color=auto`

type cd
# cd is a shell builtin
```

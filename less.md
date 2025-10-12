* `less` is a powerful terminal pager utility that allows you to view (not edit) the contents of a text file, one screen (page) at a time.

* It’s an improved version of the more command — with more features, backward navigation, search, scrolling, viewing compressed files, and even syntax-like highlighting.

* `less` doesn’t load the whole file at once (efficient for large files).

* You can scroll forward and backward through the file.

* It supports pattern searching, navigation, jumping to line numbers, and viewing multiple files.

* Exiting doesn’t change the file.

| Key                | Action                      |
| ------------------ | --------------------------- |
| **Space** or **f** | Move forward one screen     |
| **b**              | Move backward one screen    |
| **Enter**          | Move forward one line       |
| **y**              | Move backward one line      |
| **d**              | Move forward half a screen  |
| **u**              | Move backward half a screen |
| **g**              | Jump to start of file       |
| **G**              | Jump to end of file         |
| **10g**            | Jump to line 10             |
| **Arrow Keys**     | Move line by line           |
| **q**              | Quit `less`                 |


* Searching

| Command    | Description                            |
| ---------- | -------------------------------------- |
| `/pattern` | Search **forward** for “pattern”       |
| `?pattern` | Search **backward** for “pattern”      |
| `n`        | Repeat last search (same direction)    |
| `N`        | Repeat last search (reverse direction) |
| `&pattern` | Show only matching lines (filter)      |


| Option       | Description                                |
| ------------ | ------------------------------------------ |
| `-N`         | Show line numbers                          |
| `-S`         | Chop (don’t wrap) long lines               |
| `-X`         | Keeps content on screen after exit         |
| `-F`         | Quit if content fits on one screen         |
| `-R`         | Show raw control characters and colors     |
| `-i`         | Case-insensitive search                    |
| `-p pattern` | Start displaying from pattern              |
| `+F`         | Follow file output like `tail -f`          |
| `+<n>`       | Start from line number `n`                 |
| `-m`         | Show percentage and file position          |
| `-#n`        | Set number of columns to scroll right/left |
| `--help`     | Display help for less command              |

| Use Case              | Command                               | Description                          |                              |
| --------------------- | ------------------------------------- | ------------------------------------ | ---------------------------- |
| View large logs       | `less /var/log/messages`              | Scroll through system logs           |                              |
| Search in logs        | `/error`                              | Find error entries quickly           |                              |
| View colored output   | `less -R colored.txt`                 | Preserve ANSI colors                 |                              |
| Debug processes       | `ps aux                               | less`                                | Examine process list         |
| Inspect users         | `cat /etc/passwd                      | less -N`                             | View users with line numbers |
| Review configs        | `less /etc/httpd/conf/httpd.conf`     | Read configuration files             |                              |
| Read compressed logs  | `less /var/log/syslog.1.gz`           | Automatically decompress             |                              |
| Follow live updates   | `less +F /var/log/apache2/access.log` | Like `tail -f` but scrollable        |                              |
| Search multiple files | `less file1 file2`                    | Navigate across multiple files       |                              |
| Filter lines          | `&keyword`                            | Show only lines containing “keyword” |                              |

```bash
less -N /etc/passwd
less +100 /var/log/messages
less -p "error" /var/log/syslog
less -X /etc/fstab #Preserve screen after exit
less -R colored_output.txt #Display colors and ANSI sequences
less +F /var/log/syslog
grep "error" /var/log/syslog | less
ps aux | less
ls -lR /etc | less
less file.log.gz #less automatically handles compressed files (gzip, bz2, xz) on most systems
```

```bash
less file1 file2 file3

Navigation between files:

:n → Next file

:p → Previous file

:e filename → Open another file

:q → Quit
```


| Variable    | Purpose                                                      |
| ----------- | ------------------------------------------------------------ |
| `LESS`      | Set default options (e.g. `export LESS='-R -N'`   `export LESS='-i -N -S -R'`
`)             |
| `LESSOPEN`  | Preprocess files before opening (e.g., for compressed files) |
| `LESSCLOSE` | Cleanup command after file close                             |

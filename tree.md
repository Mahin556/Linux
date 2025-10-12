* The tree command in Linux is used to display the directory structure of a path in a tree-like format.
* It recursively lists files and directories in a hierarchical view, making it easier to understand directory layouts than ls -R.

```bash
sudo yum install tree
sudo dnf install tree
sudo pacman -S tree
```

| Concept               | Description                                                          |
| --------------------- | -------------------------------------------------------------------- |
| **Recursive Display** | Shows all files and subdirectories inside the directory recursively. |
| **Depth Level**       | Limits the levels of recursion displayed.                            |
| **File Information**  | Can show file sizes, permissions, modification dates.                |
| **Colorization**      | Highlights directories and file types in color.                      |
| **Export**            | Can save tree output to a file.                                      |


| Option       | Description                         | Example                 |
| ------------ | ----------------------------------- | ----------------------- |
| `-a`         | Include hidden files (`.`-prefixed) | `tree -a`               |
| `-d`         | List directories only               | `tree -d`               |
| `-L level`   | Limit depth of recursion            | `tree -L 2`             |
| `-f`         | Show full path for each file        | `tree -f`               |
| `-i`         | No indentation lines                | `tree -i`               |
| `-C`         | Colorize output                     | `tree -C`               |
| `-p`         | Show file permissions               | `tree -p`               |
| `-s`         | Show file sizes in bytes            | `tree -s`               |
| `-h`         | Human-readable file sizes           | `tree -h`               |
| `-D`         | Show last modification date/time    | `tree -D`               |
| `--noreport` | Hide summary at the bottom          | `tree --noreport`       |
| `-o file`    | Output to a file                    | `tree -o structure.txt` |
| `-P pattern` | List only files matching a pattern  | `tree -P '*.txt'`       |
| `-I pattern` | Exclude files matching a pattern    | `tree -I '*.log'`       |
| `-J`         | Output in JSON format               | `tree -J`               |
| `-X`         | Output in XML format                | `tree -X`               |


```bash
tree -C -p -h  #Colored Tree with Permissions and Sizes

tree -a -d -L 1  #Show Hidden Files in Directory Only

tree -J /home/user/projects > projects.json

```

```bash
tree -p -h

drwxr-xr-x 4.0K user group .
├── -rw-r--r-- 1.2K file1.txt
├── drwxr-xr-x 4.0K dir1
│   ├── -rw-r--r-- 2.3K file2.log
│   └── -rw-r--r-- 3.4K file3.txt
└── -rw-r--r-- 1.0K file4.sh
```


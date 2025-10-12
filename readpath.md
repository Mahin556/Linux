The **`realpath`** command is used to **resolve all symbolic links, relative paths, and references like `.` or `..` in a file or directory path** and print the **absolute canonical path**.

It is useful when you want to know the **full absolute path** of a file or directory, regardless of symbolic links or relative references.

---

#### **Syntax**

```bash
realpath [OPTION]... FILE...
```

* **`FILE`** → The file or directory for which you want the absolute path.

---

#### **Common Options**

| Option                          | Description                                           |
| ------------------------------- | ----------------------------------------------------- |
| `-s`, `--strip`                 | Do not resolve symbolic links; just clean up path     |
| `-m`, `--canonicalize-missing`  | Canonicalize even if some path components don’t exist |
| `--relative-to=DIR`             | Print relative path to the given directory            |
| `-e`, `--canonicalize-existing` | Canonicalize only existing files (default behavior)   |
| `-z`, `--zero`                  | End output with null byte instead of newline          |

---

#### **Examples**

##### Resolve the absolute path of a file

```bash
realpath myfile.txt
```

* Output: `/home/user/projects/myfile.txt`
* Converts relative path to absolute path.

---

##### Resolve a directory path

```bash
realpath ../Documents
```

* Output: `/home/user/Documents`
* Handles `..` and `.` in the path.

---

##### Resolve a symbolic link

```bash
realpath symlink_to_file
```

* Output: `/home/user/projects/target_file.txt`
* Follows the symlink to the actual target file.

---

##### Get relative path to another directory

```bash
realpath --relative-to=/home/user /home/user/projects/file.txt
```

* Output: `projects/file.txt`
* Prints relative path from `/home/user` to the target.

---

##### Canonicalize missing paths

```bash
realpath -m ./nonexistent/path/file.txt
```

* Output: `/home/user/nonexistent/path/file.txt`
* Resolves the full path even if some components don’t exist.

---

#### **Key Points**

* `realpath` is useful in **scripts** to resolve paths reliably.
* Can handle **symlinks, relative paths, `.` and `..`** references.
* Different from `pwd`, which only prints the current directory.
* Alternative for older systems: `readlink -f` achieves a similar result.

---

##### Quick Recap

| Task                         | Command Example                                                  |
| ---------------------------- | ---------------------------------------------------------------- |
| Absolute path of a file      | `realpath file.txt`                                              |
| Absolute path of a directory | `realpath ../Documents`                                          |
| Resolve symbolic links       | `realpath symlink`                                               |
| Relative path to a directory | `realpath --relative-to=/home/user /home/user/projects/file.txt` |
| Canonicalize missing path    | `realpath -m ./nonexistent/file`                                 |


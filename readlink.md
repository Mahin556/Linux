The **`readlink`** command is used to **display the target of a symbolic link**. It can also resolve paths to their absolute form, similar to `realpath`.

Essentially, it tells you **what a symbolic link points to**.

---

#### **Syntax**

```bash
readlink [OPTION]... FILE...
```

* **`FILE`** → The symbolic link or path to examine.

---

##### **Common Options**

| Option                          | Description                                     |
| ------------------------------- | ----------------------------------------------- |
| `-f`, `--canonicalize`          | Follow all symlinks and print the absolute path |
| `-e`, `--canonicalize-existing` | Canonicalize only existing paths                |
| `-m`, `--canonicalize-missing`  | Canonicalize even if components do not exist    |
| `-n`, `--no-newline`            | Do not print the trailing newline               |
| `-q`, `--quiet`                 | Suppress error messages                         |
| `-v`, `--verbose`               | Verbose output                                  |
| `--help`                        | Show help and exit                              |
| `--version`                     | Show version and exit                           |

---

#### **Examples**

##### Display the target of a symbolic link

```bash
readlink symlink_file
```

* Output: `target_file.txt`
* Shows the file that the symlink points to.

---

##### Get the absolute path of a symbolic link

```bash
readlink -f symlink_file
```

* Output: `/home/user/projects/target_file.txt`
* Resolves all intermediate symlinks and prints the canonical path.

---

##### Canonicalize even missing paths

```bash
readlink -m ./nonexistent/path/file.txt
```

* Output: `/home/user/nonexistent/path/file.txt`
* Prints full path even if some components do not exist.

---

##### Multiple symlinks

```bash
readlink -f link1 link2
```

* Output: Absolute paths of `link1` and `link2`
* Resolves multiple symlinks in one command.

---

##### Suppress newline

```bash
readlink -n symlink_file
```

* Prints the target path **without a newline**, useful in scripts.

---

#### **Key Points**

* **`readlink`** focuses on **symlinks**, while `realpath` works on any path.
* `readlink -f` behaves similarly to `realpath`, following symlinks to produce an absolute path.
* Useful in **scripts** to dynamically resolve symbolic links and paths.

---

##### Quick Recap

| Task                      | Command Example                  |
| ------------------------- | -------------------------------- |
| Show target of symlink    | `readlink symlink_file`          |
| Absolute path of symlink  | `readlink -f symlink_file`       |
| Canonicalize missing path | `readlink -m ./nonexistent/file` |
| Multiple symlinks         | `readlink -f link1 link2`        |
| No newline output         | `readlink -n symlink_file`       |

- **Linux** **Security Feature** use to control **access** on **files and directory**.

* Determine File and Directories permissions
```bash
stat file.txt
Access: (0644/-rw-r--r--)  Uid: (1000/user)  Gid: (1000/group)

$ ls -ld /home/user
drwxr-xr-x  5 user user 4096 Oct 11 16:00 /home/user

```
Info:- Type,Premissions(Owner,Group,Other),No of Hard Links, owner, Group, Size, Last Modification Time, Name

| Field          | Value                  | Meaning                              |
| -------------- | ---------------------- | ------------------------------------ |
| `d`            | Directory type         | `d`=directory, `-`=file, `l`=symlink |
| `rwxr-xr-x`    | Permissions            | Owner rwx, Group r-x, Others r-x     |
| `5`            | Number of links        | Subdirectories + self reference      |
| `user`         | Owner                  | User who owns the directory          |
| `user`         | Group                  | Group associated with the directory  |
| `4096`         | Size (bytes)           | Typically 4096 for directories       |
| `Oct 11 16:00` | Last modification date | Timestamp of last modification       |
| `/home/user`   | Directory name         | The directory being listed           |

### Default permissions
Directory ---> 755
File ---> 644

### Best Practices
- Least-privilege principle
- Use groups for easier collaboration
- Always double-check recursive commands
- Avoid using chmod 777
- Don’t forget to set execute permission on scripts


```bash
$ ls -ld /home/user
drwxr-xr-x  5 user user 4096 Oct 11 16:00 /home/user
```

### Permissions are represented either symbolically (letters) or numerically (octal).
* Symbolic Mode
    Permissions are expressed as a 9-character string
    ```bash
    -rw-r--r--
    ```
    `u` = user/owner
    `g` = group
    `o` = other
    `r` = read
    `w` = write
    `x` = execute
    `a` = all
    `-` = permission not granted
    `s` = If found in the user triplet, it sets the setuid bit. 
        If found in the group triplet, it sets the setgid bit. It also means that x flag is set.
        When the setuid or setgid flags are set on an executable file, the file is executed with the file’s owner and/or group privileges.
    `S` = Same as s, but the x flag is not set. This flag is rarely used on files.

    `t` = If found in the others triplet, it sets the sticky bit.
It also means that x flag is set. This flag is useless on files.

    `T` = Same as, t but the x flag is not set. This flag is useless on files.


    ```bash
    chmod u+rwx file.txt   # Add rwx for owner
    chmod g+rw file.txt    # Add rw for group
    chmod o+r file.txt     # Add read for others
    chmod a+x script.sh    # Add execute for all
    ```

    Owner ---> Creator or changed with `chown`

* Numeric (Octal) Mode
    Permissions can also be represented as a three-digit number, each digit is the sum of:
    | Permission  | Value |
    | ----------- | ----- |
    | r (read)    | 4     |
    | w (write)   | 2     |
    | x (execute) | 1     |

    ```bash
    chmod 744 file.txt     # Owner: rwx, Group: r, Others: r
    chmod 755 script.sh    # Owner: rwx, Group: r-x, Others: r-x
    ```

* Operators
    `+` --> Add permission
    `-` --> Remove Permission
    `=` --> Exec permissions

#### What Each Permission Does
| Permission  | Files                   | Directories                       |
| ----------- | ----------------------- | --------------------------------- |
| Read `r`    | View file contents      | List files in the directory       |
| Write `w`   | Modify file contents    | Add, remove, rename files         |
| Execute `x` | Run a program or script | Access/enter the directory (`cd`) |

- Note: Without x on a directory, r and w alone aren’t very useful. You can’t traverse or modify files in the directory properly.

#### Special Permissions

* **SUID (s/4)**
    File executes with owner’s permissions, not the executor.
    Example: `chmod u+s file / chmod 4755 file`
    
* **SGID (s/2)**
    File executes with group’s permissions.
    For directories: new files inherit directory group.
    Example: `chmod g+s directory / chmod 2755 directory`

* **Sticky bit (t/1)**
    Only file owner can delete files in a directory.
    Common on /tmp
    Example: `chmod +t /shared / chmod 1755 file`

### File types
| Symbol | Type                             |
| ------ | -------------------------------- |
| `-`    | Regular file                     |
| `d`    | Directory                        |
| `l`    | Symbolic link                    |
| `b`    | Block device (e.g. disk)         |
| `c`    | Character device (e.g. terminal) |
| `p`    | Named pipe                       |
| `s`    | Socket                           |


### References:
- https://www.redhat.com/en/blog/linux-file-permissions-explained
- https://www.digitalocean.com/community/tutorials/how-to-set-permissions-linux
- https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-permissions
- https://linuxize.com/post/understanding-linux-file-permissions/
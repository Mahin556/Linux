The getfacl command is used to view Access Control Lists (ACLs) on files and directories. It is essentially the counterpart to setfacl, which sets ACLs.

| Option      | Description                                          |
| ----------- | ---------------------------------------------------- |
| `-a`        | Show **all entries**, including default ACLs         |
| `-d`        | Show **default ACLs** for directories                |
| `-R`        | Recursively show ACLs for directory and its contents |
| `--version` | Show command version                                 |
| `--help`    | Display help information                             |

```bash
$ getfacl file.txt
# file: file.txt
# owner: bob
# group: bobgroup
user::rw-
user:alice:rw-
group::r--
mask::rw-
other::r--
```
| Field            | Meaning                                                       |
| ---------------- | ------------------------------------------------------------- |
| `user::rw-`      | Owner permissions                                             |
| `user:alice:rw-` | ACL for user `alice`                                          |
| `group::r--`     | Group permissions                                             |
| `mask::rw-`      | Maximum effective permissions for users/groups (except owner) |
| `other::r--`     | Permissions for others                                        |
| `# owner`        | File owner                                                    |
| `# group`        | File group                                                    |

<br>

```bash
$ getfacl -d /mydir
# file: mydir
# owner: bob
# group: bobgroup
user::rwx
group::r-x
other::r--
default:user::rwx
default:group::r-x
default:other::r--
```
* `default`: entries indicate permissions automatically applied to new files created in the directory.

<br>

* Recursive ACL Display
    ```bash
    getfacl -R /mydir
    ```
    * Displays ACLs for the directory and all files/subdirectories inside it.

* If no ACL is set, the output shows standard Linux permissions only.
* ACLs are optional, and the filesystem must support them (most modern Linux filesystems do, e.g., ext4, XFS).
* Use getfacl in combination with setfacl for full ACL management.

```bash
# Set ACL for a user
setfacl -m u:alice:rw file.txt

# View ACL
getfacl file.txt
# Output:
# user::rw-
# user:alice:rw-
# group::r--
# mask::rw-
# other::r--

# Set default ACL on a directory
setfacl -m d:u:alice:rw /shared

# Verify default ACL
getfacl -d /shared
```



Linux is a multi-user operating system, meaning multiple users can operate simultaneously, each with distinct permissions and ownerships.

| Type                 | Description                                                                        | Example                                |
| -------------------- | ---------------------------------------------------------------------------------- | -------------------------------------- |
| **System Users**     | Created automatically during installation to run background processes or services. | `sshd`, `www-data`, `systemd-timesync` |
| **Regular Users**    | Created manually to log in interactively and perform personal tasks.               | `mahin`, `raza`, `sammy`               |
| **Superuser (root)** | Has unrestricted privileges and can override all ownership and permissions.        | `root`                                 |

View all users:
```bash
cat /etc/passwd

sammy:x:1001:1002::/home/sammy:/bin/bash
```
| Field | Description                                              | Example     |
| ----- | -------------------------------------------------------- | ----------- |
| 1     | Username                                                 | sammy       |
| 2     | Password placeholder (`x` means stored in `/etc/shadow`) | x           |
| 3     | User ID (UID)                                            | 1001        |
| 4     | Group ID (GID)                                           | 1002        |
| 5     | Comment (User Info)                                      | (empty)     |
| 6     | Home Directory                                           | /home/sammy |
| 7     | Default Shell                                            | /bin/bash   |

* Groups in Linux
A group is a collection of users that share permissions.
Each user:
    Belongs to one primary group.
    Can belong to multiple secondary groups.

View all groups:
```bash
cat /etc/group
developers:x:1003:mahin,raza
```
| Field | Description          | Example     |
| ----- | -------------------- | ----------- |
| 1     | Group name           | developers  |
| 2     | Password placeholder | x           |
| 3     | Group ID (GID)       | 1003        |
| 4     | Members              | mahin, raza |


### References
- https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-permissions
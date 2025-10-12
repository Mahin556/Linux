* The umask command in Linux sets the default file permission mask for newly created files and directories.

* Determine which permissions should be removed from the system default when a file or directory is created.

* Shell builtin (most shells, e.g., `bash`, `ksh`, `zsh`)

* Can be set in shell configuration files like `~/.bashrc`, `/etc/profile`, or `/etc/login.defs`.

* Every file/directory in Linux has permissions: r (read), w (write), x (execute).

* When you create a file or directory, the default permissions are:

    | Type      | Default Permissions |
    | --------- | ------------------- |
    | File      | `666` (rw-rw-rw-)   |
    | Directory | `777` (rwxrwxrwx)   |

    * `umask` subtracts permissions from these defaults.

* Formula: `Actual Permission = Default Permission - Umask`

* Octal Notation (Most Common)

    | Octal | Binary | Meaning                |
    | ----- | ------ | ---------------------- |
    | 0     | 000    | no permission masked   |
    | 1     | 001    | execute masked         |
    | 2     | 010    | write masked           |
    | 3     | 011    | write + execute masked |
    | 4     | 100    | read masked            |
    | 5     | 101    | read + execute masked  |
    | 6     | 110    | read + write masked    |
    | 7     | 111    | all permissions masked |

* Symbolic Notation
    Syntax: `u=rwx,g=rx,o=`
    `umask -S`shows symbolic representation
    Example:
    ```bash
    umask u=rwx,g=rx,o=
    ```
    Same effect as umask 027

```bash
drwxr-xr-x 12 linuxize users 4.0K Apr 8 20:51 dirname
^    ^      ^      ^          ^
|    |      |      |          +-- File size / date
|    |      |      +------------- Group
|    |      +------------------- Owner
|    +-------------------------- Permissions for owner/group/others
+------------------------------- File type (d=directory, -=file)
```

```bash
umask #Current umask(octal)

umask -S #Current umask(symbolic)
# Output example: u=rwx,g=rx,o=rx
# Shows user, group, others permissions after applying mask

umask u-r
umask u+r

umask 027
# Masks:
#     User: 0 → no permissions masked
#     Group: 2 → write removed
#     Others: 7 → all permissions removed
# New directory default: rwxr-x---
# New file default: rw-r-----

umask 022 #Removes write permission for group & others
# Directory default: rwxr-xr-x
# File default: rw-r--r--

umask 077 #Removes all permissions for group & others
# Directory default: rwx------
# File default: rw-------
```

* Temporary vs Permanent umask
```bash
umask 002 #Temporary

/etc/profile
/etc/bashrc
/etc/profile.d/set-umask-for-all-users.sh
```

| Umask | Meaning                | File      | Directory |
| ----- | ---------------------- | --------- | --------- |
| 000   | No restriction         | rw-rw-rw- | rwxrwxrwx |
| 022   | Default for most Linux | rw-r--r-- | rwxr-xr-x |
| 027   | Restrictive            | rw-r----- | rwxr-x--- |
| 077   | Very restrictive       | rw------- | rwx------ |
| 002   | Allows group write     | rw-rw-r-- | rwxrwxr-x |


* Checking system-wide default
```bash
grep UMASK /etc/login.defs

UMASK 022
```

```bash
File base: 666
Umask: 022
Final file permission: 666 - 022 = 644 → rw-r--r--
```

```bash
Directory base: 777
Umask: 022
Final dir permission: 777 - 022 = 755 → rwxr-xr-x

File permissions = 666 - umask
Directory permissions = 777 - umask

Files: 666 - 022 = 644 → rw-r--r--
Directories: 777 - 022 = 755 → rwxr-xr-x

Files: 666 - 027 = 640 → rw-r-----
Directories: 777 - 027 = 750 → rwxr-x---

umask 077
touch private_file
mkdir private_dir
ls -l
# private_file: rw-------
# private_dir: drwx------

umask 002
touch shared_file
mkdir shared_dir
ls -l
# shared_file: rw-rw-r--
# shared_dir: rwxrwxr-x

```
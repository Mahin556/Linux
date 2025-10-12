The setfacl command is used to set Access Control Lists (ACLs) on files and directories. ACLs provide fine-grained permissions, allowing you to grant or restrict access beyond the traditional owner/group/others model.

Traditional Linux permissions are limited to owner, group, and others (rwx for each).

ACLs allow:
    * Giving specific permissions to specific user, multiple users or groups.
    * Setting default permissions for new files in a directory.

Useful in shared environments where multiple users need different levels of access.

* Syntax
```bash
setfacl [options] acl_spec file_or_directory
```
* `acl_spec` – The permission rule (user, group, or default).
* `file_or_directory` – Target file or folder.

<br>

* **ACL Format**
```bash
u:username:permissions #User ACL
u:alice:rw
setfacl -m u:alice:rw file.txt


g:groupname:permissions #Group ACL
g:devs:r
setfacl -m g:devs:r file.txt

d:u:username:permissions #Default ACL (for directories)
d:u:alice:rw
setfacl -m d:u:alice:rw /mydir
```
<br>

* **Permissions**
| Letter | Meaning       |
| ------ | ------------- |
| r      | Read          |
| w      | Write         |
| x      | Execute       |
| -      | No permission |

<br>

* **Common Options**

| Option   | Description                                        |
| -------- | -------------------------------------------------- |
| `-m`     | Modify or add ACL entries                          |
| `-x`     | Remove ACL entries                                 |
| `-b`     | Remove all ACL entries (except owner/group/other)  |
| `-k`     | Remove default ACL (for directories)               |
| `-R`     | Apply recursively                                  |
| `-d`     | Set default ACL for directories                    |
| `--mask` | Set maximum effective permissions for users/groups |


```bash
setfacl -m u:alice:rw file.txt #Add ACL for a user

setfacl -m g:devs:r file.txt #Add ACL for a group

setfacl -x u:alice file.txt #Remove ACL entry

setfacl -m d:u:alice:rw /mydir #Set default ACL on a directory

setfacl -R -m u:alice:rw /mydir #Recursive ACL

setfacl -b file.txt #Remove all ACLs

setfacl -d -m u:dummy:rw test

setfacl -d -m u:alice:rwx,d:g:marketing:rx shared_folder

# Set the mask explicitly:
setfacl -m m::rwx file   # give full mask to allow r,w,x for named entries

setfacl -m u:user1:rw file.txt
setfacl -m g:demo1:rwx file.txt
setfacl -m o:r file.txt
setfacl -m m:rwx file.txt     # Set mask manually

setfacl -m u:user1:rw,g:demo1:rwx,o:r file.txt

setfacl -x u:user1 file.txt
setfacl -b file.txt       # Remove all ACLs

setfacl -m d:u:user2:rwx /sharedir

setfacl -m d:o:rx /share
```

```bash
$ getfacl file.txt #Viewing ACLs
# file: file.txt
# owner: bob
# group: bobgroup
user::rw-
user:alice:rw-
group::r--
mask::rw-
other::r--
```

---

**Enabling ACL Support**
* Temporarily (mount command):
    ```bash 
    mount -t ext3 -o acl /dev/VolGroup00/LogVol02 /work
    ```
* Permanently (/etc/fstab)
    ```bash
    LABEL=/work   /work    ext3   defaults,acl   1 2
    ```
Samba shares compiled with --with-acl-support automatically respect ACLs.
NFS shares also use ACLs by default unless disabled with no_acl.


---

##### Mask

* The **mask** is an ACL entry that defines the **maximum effective permissions** for:
  * All **users (except owner)** who have explicit ACL entries
  * All **groups** with ACL entries
* Think of it as a **cap or limit**: even if a user or group has been granted more permissions in ACL, the **mask restricts what is actually allowed**.

```bash
# Set ACL for a file
setfacl -m u:alice:rwx,g:devs:rw file.txt
getfacl file.txt
```
Output might look like:
```bash
# file: file.txt
# owner: bob
# group: bobgroup
user::rw-
user:alice:rwx
group::devs:rw-
mask::rw-
other::r--
```
* `user:alice:rwx` → Alice is granted `rwx`.
* `mask::rw-` → Maximum effective permissions are `rw-`.
* **Effective permissions for Alice:** `rw-` (execute `x` is blocked by mask).
* `mask` **does not affect owner (`user::`) or others (`other::`)**.
* Whenever you **add ACL entries for users or groups**, Linux **automatically updates the mask**.
* If you set an ACL without specifying a mask, the mask is **set to the union of all ACL permissions for users/groups**.

---

**Modifying the Mask**
* You can manually modify the mask with:
```bash
setfacl -m m:permissions file.txt
```
```bash
setfacl -m m:r file.txt
getfacl file.txt
```
* Now, all users/groups with ACLs are limited to **read-only**, regardless of their explicit ACL entries.

**Why the Mask is Important**
1. **Controls maximum permissions:** Prevents accidental over-permission.
2. **Ensures security:** You can grant `rwx` to a user but limit effective rights with mask.
3. **Essential for groups:** Without mask, group ACLs may unintentionally grant more rights.
4. **Part of effective permission calculation:** Always check `getfacl` output; what is granted may not equal what is **effectively usable**.

---

**Quick Reference**

| ACL Entry Type    | Controlled By Mask? | Effective Permissions                        |
| ----------------- | ------------------- | -------------------------------------------- |
| `user::` (owner)  | No                  | Permissions as set                           |
| `user:username`   | Yes                 | Min(granted, mask)                           |
| `group::`         | Yes                 | Min(granted, mask)                           |
| `group:groupname` | Yes                 | Min(granted, mask)                           |
| `other::`         | No                  | Permissions as set                           |
| `mask::`          | N/A                 | Defines max for all above except owner/other |

Example Scenario:
```bash
# Set ACL
setfacl -m u:alice:rwx,g:devs:rw file.txt
# Modify mask
setfacl -m m:rw file.txt
getfacl file.txt
```
* **Result:** Alice loses execute permission (`x`) because the mask is now `rw-`.
* **Without mask limit:** Alice would have `rwx`.


#### **Using Default ACLs in Linux**

##### **What is a Default ACL?**

* **Default ACL** applies **only to directories**.
* It **does not change the permissions of the directory itself**.
* Instead, it specifies **permissions that will automatically be applied to new files or subdirectories created inside this directory**.
* Useful in **shared directories**, where you want all new files to inherit certain permissions automatically.

---

##### **Command Example**

```bash
mkdir test
setfacl -d -m u:dummy:rw test
```

##### **Explanation:**

1. `mkdir test` → Creates a directory named `test`.
2. `setfacl -d -m u:dummy:rw test` → Sets a **default ACL** for the directory:

   * `-d` → indicates this is a **default ACL**.
   * `-m` → modifies/sets the ACL entry.
   * `u:dummy:rw` → Grants **user `dummy` read and write permissions** on **new files and directories** created inside `test`.

---

##### **Verify Default ACL**

```bash
getfacl test
```

Output will look like:

```
# file: test
# owner: user
# group: user
user::rwx
group::r-x
other::r-x
default:user::rwx
default:user:dummy:rw
default:group::r-x
default:other::r-x
```

* `default:user:dummy:rw` → Any **new file or directory** created inside `test` will inherit these ACLs automatically.

---

##### **Demonstration**

```bash
# Create a new file inside test
touch test/file1

# Check ACL of new file
getfacl test/file1
```

Output:

```
# file: test/file1
# owner: user
# group: user
user::rw-
user:dummy:rw-
group::r--
mask::rw-
other::r--
```

* Notice how **`dummy` automatically gets `rw` permissions** on the new file due to the **default ACL**.
* The directory itself (`test`) permissions remain unchanged.

---

##### **Key Points About Default ACLs**

1. Only **directories** can have default ACLs.
2. They **propagate automatically** to all new files/subdirectories created within that directory.
3. Existing files are **not affected**—only files created **after** setting the default ACL inherit the permissions.
4. Can be combined with **regular ACLs** and **mask** for fine-grained control.

<br>

#### **Exercise: Setting ACLs for a Shared Directory**

##### **Scenario**

* Users: `user1`, `user2`, `user3`
* Groups: `demo1` (user1, user2), `demo2` (user2, user3)
* Directory: `sample`
* Desired permissions:

| User/Group | Permission             |
| ---------- | ---------------------- |
| user1      | read + write           |
| user2      | read                   |
| user3      | read + write + execute |
| demo1      | read + write           |
| demo2      | read + write + execute |
| other      | read                   |

---

##### **Command to Set ACLs**

```bash
setfacl -m u:user1:rw \
-m u:user2:r \
-m u:user3:rwx \
-m g:demo1:rw \
-m g:demo2:rwx \
-m o:r sample
```

##### **Explanation:**

* `-m` → modify or add ACL entry
* `u:user1:rw` → set user1 permissions to **read/write**
* `u:user2:r` → set user2 permissions to **read only**
* `u:user3:rwx` → set user3 permissions to **read/write/execute**
* `g:demo1:rw` → set group demo1 permissions to **read/write**
* `g:demo2:rwx` → set group demo2 permissions to **read/write/execute**
* `o:r` → set permissions for **others** to **read only**
* `sample` → the target directory

---

##### **Verify ACLs**

```bash
getfacl sample
```

Expected output (simplified):

```
# file: sample
# owner: <owner>
# group: <group>
user::rwx
user:user1:rw
user:user2:r
user:user3:rwx
group::r-x
group:demo1:rw
group:demo2:rwx
mask::rwx
other::r
```

**Notes:**

* `mask::rwx` represents the **maximum effective permissions** for users/groups other than the owner.
* The **effective permissions** may differ if the mask is more restrictive.

---

##### **Understanding How Permissions Apply**

1. **User-specific ACL entries** override base owner/group permissions.
2. **Group-specific ACL entries** allow multiple users in the group to share permissions.
3. **Others** (`o`) only have **read access**.
4. This setup allows a **fine-grained control** beyond standard Linux permissions.

---

**Why the mask is often missing “x”**
By default, when a new file is created, the mask reflects normal file defaults (no execute bit).
Security policy says no file should be executable unless explicitly set — that’s why new files’ mask usually ends up as rw-.
You can manually fix this:
```bash
setfacl -m m::rwx file
```

---

```bash
tar --acls -cf backup.tar /project
tune2fs -l /dev/sda1 | grep "Default mount options"
setfacl --restore=backup.acl
```

### References:
- https://www.redhat.com/en/blog/linux-access-control-lists
- https://www.redhat.com/en/blog/access-control-lists
- https://medium.com/@kshakirat0/a-comprehensive-introduction-to-linux-access-control-lists-acls-9c40fddc0e9f
- https://unix.stackexchange.com/questions/152477/how-does-acl-calculate-the-effective-permissions-on-a-file
- https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-access_control_lists#ch-Access_Control_Lists


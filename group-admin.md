### 1. **Groups in Linux**

* Linux organizes users into **groups** for permission management.
* Each file and directory has:

  * **Owner** (user)
  * **Group**
  * **Permissions** (read, write, execute for user/group/others)

---

### 2. **What is a Group Admin?**

A **group admin** is typically a user who can **manage other users in a particular group** without being the root user.

Linux doesn’t have a direct “group admin” role, but you can achieve similar functionality by:

#### a) Using `sudo` with group management commands

* Example: Allow a user to manage a specific group.

```bash
sudo usermod -aG groupname username   # Add user to a group
sudo gpasswd -d username groupname    # Remove user from a group
sudo gpasswd -A adminuser groupname   # Make adminuser the group administrator
```

* **`gpasswd -A`**: Sets a user as the **group administrator**, which allows them to add/remove other members of the group.

#### b) Viewing group admins

```bash
getent group groupname
```

* The output shows group members.
* Users listed after the colon are regular members; those in **`gpasswd -A`** are admins.

---

### 3. **Example**

```bash
sudo gpasswd -A mahin developers
```

* This makes **mahin** the admin of the `developers` group.
* Mahin can now manage group members using `gpasswd` without needing `sudo` for every operation.

```bash
# Add user 'john' to 'developers' group as group admin
gpasswd -a john developers
# Remove user 'alice' from 'developers'
gpasswd -d alice developers
```

---

### 4. **Summary**

* **Group admin** = user allowed to manage a particular group.
* Use `gpasswd -A` to assign group admin rights.
* Admin can **add/remove users** from that group without full root access.

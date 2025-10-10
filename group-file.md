# **The `/etc/group` File in Linux/UNIX**

The `/etc/group` file is a **text file that stores information about groups** on a Linux/UNIX system. Groups are used to organize users and manage permissions efficiently.

Each user must belong to at least **one group (primary group)** and can belong to **multiple secondary groups**. Groups simplify access control, resource sharing, and delegation of administrative privileges.

---

## **1. Purpose of `/etc/group`**

* Defines the **groups** to which users belong.
* Organizes users for access to files, directories, and devices.
* Facilitates delegation of permissions to multiple users at once.
* Helps in monitoring and managing users in large systems.

---

## **2. Format of `/etc/group`**

Each line in `/etc/group` represents a single group, with **four fields separated by colons `:`**:

```
group_name:password:GID:group_members
```

### **Fields Explained**

1. **`group_name`**

   * Name of the group.
   * **Rules:**

     * Must be unique.
     * Less than 255 characters.
     * Starts with a letter.

2. **`password`**

   * Placeholder for group password (rarely used).
   * If `x` is present → shadow passwords are used (`/etc/gshadow`).
   * Allows non-members to join the group using `newgrp` command.

3. **`GID` (Group ID)**

   * Numeric identifier for the group.
   * Used by the OS for permissions and auditing.
   * Must be unique.

4. **`group_members`**

   * Comma-separated list of usernames in the group.
   * Example: `juan,shelley,bob`

**Example entry:**

```
general:x:502:juan,shelley,bob
```

* `general` → group name
* `x` → shadow password
* `502` → GID
* `juan, shelley, bob` → members

---

## **3. Primary vs Secondary Groups**

* **Primary Group**

  * Each user has **one primary group**.
  * Automatically created with the same name as the user unless specified otherwise.

* **Secondary Groups**

  * Users can belong to **multiple secondary groups**.
  * Must be manually added using `usermod -G groupname username`.

---

## **4. Commands Related to `/etc/group`**

### **View Group Information**

```bash
cat /etc/group
less /etc/group
more /etc/group
groups username   # Show all groups a user belongs to
id username       # Show UID, GID, and groups
```

### **Add/Modify/Delete Groups**

```bash
# Add a new group
sudo groupadd groupname

# Add a group with specific GID
sudo groupadd --gid 3000 groupname

# Delete a group
sudo groupdel groupname

# Modify group name
sudo groupmod --new-name newname oldname

# Modify GID
sudo groupmod --gid new_gid groupname
```

### **Manage Group Membership**

```bash
# Add a user to a secondary group
sudo usermod -G groupname username

# Add/remove members using gpasswd
sudo gpasswd -a username groupname   # Add
sudo gpasswd -d username groupname   # Remove
sudo gpasswd -M user1,user2 groupname  # Set exact members
sudo gpasswd -A admin1,admin2 groupname  # Set group admins
```

### **Switch Groups**

```bash
newgrp groupname   # Change primary group for current session
sg groupname       # Run command as different group
```

### **Change Group Ownership of Files**

```bash
chgrp groupname filename
```

---

## **5. Shadowed Group File: `/etc/gshadow`**

* Stores **encrypted group passwords** and administrators.
* Used when `/etc/group` password field contains `x`.

---

## **6. Typical Workflow Example**

```bash
# Create a new user
sudo useradd testuser

# View last entry in /etc/passwd
tail -1 /etc/passwd

# View last entry in /etc/group
tail -1 /etc/group

# Create a new group
sudo groupadd testgroup

# Add the user to the new group
sudo usermod -G testgroup testuser

# Verify secondary group membership
groups testuser
```

---

## **7. Summary**

* `/etc/group` stores **group information**: name, GID, password, members.
* Each line corresponds to a single group.
* Linux automatically creates **primary groups**; **secondary groups** are optional.
* Group management commands: `groupadd`, `groupdel`, `groupmod`, `usermod`, `gpasswd`, `groups`, `id`.
* Shadowed passwords are stored in `/etc/gshadow`.
* Groups help in **access control**, **user management**, and **delegation**.

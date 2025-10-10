## **1. What is `sg`?**

* **`sg`** stands for **“switch group”**.
* It allows a user to **execute commands with a different group ID (GID)** temporarily.
* Useful when a user is a member of multiple groups and needs to run a command **with permissions of a specific group**.

---

## **2. Syntax**

```bash
sg group_name [command]
```

* `group_name` → target group you want to switch to
* `[command]` → optional command to run under that group

**If no command is specified**, `sg` opens a new **shell** with the group switched.

---

## **3. How it Works**

* The user must be a **member of the target group**.
* After switching, **all files created** in that shell or command will have the **group ownership set to the new group**.

---

## **4. Examples**

### a) Switch to a group and open a new shell

```bash
sg developers
```

* Opens a shell where the **primary group is `developers`**.
* Run commands in this shell; all new files have group `developers`.

### b) Run a command with a specific group

```bash
sg developers "touch testfile.txt"
```

* Creates `testfile.txt` with group ownership `developers` without switching shell.

---

### c) Check current group after switching

```bash
sg developers "id"
```

* Output:

```
uid=1001(mahin) gid=1002(developers) groups=1002(developers),1000(users)
```

* Shows that primary group is now `developers`.

---

## **5. Key Notes**

* User **must already belong to the target group** (`/etc/group` or `vigr`).
* Does **not require root**; uses existing group membership.
* Useful for **collaborative directories** where group ownership controls access.

---

## **6. Summary**

* `sg` = switch to a **different group temporarily**.
* Can execute a **single command** or open a **new shell** with that group.
* Works only for **groups the user is a member of**.

---

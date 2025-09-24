# 🔹 `compgen` Command Cheat Sheet

### 📌 Syntax:

```bash
compgen [options] [word]
```

* `options` = what to list (users, groups, commands, etc.)
* `word` = optional prefix to filter results

---

## 1. **List Users**

```bash
compgen -u
```

Lists all user accounts (from `/etc/passwd`).

Example:

```
root
daemon
bin
sys
nobody
vivek
```

---

## 2. **List Groups**

```bash
compgen -g
```

Lists all groups (from `/etc/group`).

---

## 3. **List Shell Built-in Commands**

```bash
compgen -b
```

Examples:

```
alias
bg
break
builtin
cd
command
compgen
```

---

## 4. **List All Commands (available in PATH)**

```bash
compgen -c
```

This includes built-ins, aliases, and executables in `$PATH`.

---

## 5. **List Aliases**

```bash
compgen -a
```

Shows all defined Bash **aliases**.

---

## 6. **List Functions**

```bash
compgen -A function
```

Shows all defined **functions** in the current shell.

---

## 7. **List Available Keywords**

```bash
compgen -k
```

Lists Bash reserved keywords:

```
if
then
else
fi
for
while
function
case
```

---

## 8. **List Services**

```bash
compgen -s
```

Shows services from `/etc/services` (TCP/UDP ports).

---

## 9. **List All Possible Completions for a Given Word**

```bash
compgen -A command ls
```

Shows all commands starting with **ls**.

---

## 10. **List All Exported Variables**

```bash
compgen -v
```

Example:

```
HOME
PATH
USER
SHELL
PWD
```

---

## 11. **List All Names (all kinds)**

```bash
compgen -A function -A variable -A alias -A builtin
```

Shows **everything** possible: functions, variables, aliases, builtins.

---

## 12. **Show Help**

```bash
compgen -h
```

---

# ⚡ Practical Examples

* List all commands starting with `dock`:

  ```bash
  compgen -c dock
  ```
* List all users starting with `r`:

  ```bash
  compgen -u r
  ```
* List all groups starting with `adm`:

  ```bash
  compgen -g adm
  ```

---

✅ So the **main options** for `compgen` are:

| Flag          | Meaning                  |
| ------------- | ------------------------ |
| `-u`          | Users                    |
| `-g`          | Groups                   |
| `-b`          | Built-ins                |
| `-c`          | Commands                 |
| `-a`          | Aliases                  |
| `-k`          | Keywords                 |
| `-s`          | Services                 |
| `-v`          | Variables                |
| `-A function` | Functions                |
| `-A ...`      | All types of completions |


# 🧠 **`popd` Command in Linux**

---

## 📘 **What is `popd`?**

The **`popd`** command is used to **remove directories from the directory stack** and **change the current working directory** to the directory that was removed.

It works **together with the `pushd` command**, which adds directories to the stack.

> Think of it like a **browser history for directories**: you push directories you want to visit, and pop them off when you want to go back.

---

## ⚙️ **Syntax**

```bash
popd [OPTION] [+N | -N]
```

* **`+N`** → Remove the Nth entry from the left (start counting at 0).
* **`-N`** → Remove the Nth entry from the right (start counting at 0).

If no argument is given, `popd` removes the **top directory** from the stack (leftmost) and changes into the new top directory.

---

## 📄 **Directory Stack**

The **directory stack** is a list of directories that you’ve saved using `pushd`.

* View the stack:

```bash
dirs
```

Example:

```bash
$ dirs
~/projects ~/downloads /etc
```

---

## 🧩 **Basic Examples**

### 1️⃣ Pop the top directory

```bash
pushd /etc
pushd /var
dirs
popd
dirs
```

Output:

```
Before popd: /var /etc ~
After popd:  /etc ~
```

✅ The top directory `/var` is removed, and you move to `/etc`.

---

### 2️⃣ Pop a specific directory using `+N`

```bash
dirs
popd +1
```

* `+1` removes the **second directory** from the left in the stack.

---

### 3️⃣ Pop a directory using `-N`

```bash
dirs
popd -0
```

* `-0` removes the **first directory from the right** in the stack.

---

### 4️⃣ Combined with `pushd` for navigation

```bash
pushd /usr
pushd /bin
pushd /lib
dirs
popd
dirs
```

✅ Use `pushd` to add directories, `popd` to remove and move back.

---

## ⚡ **Options**

| Option | Description                                                                     |
| ------ | ------------------------------------------------------------------------------- |
| `-n`   | Removes the directory from the stack **without changing** the current directory |
| `+N`   | Remove the Nth entry from the left of the stack                                 |
| `-N`   | Remove the Nth entry from the right of the stack                                |

---

## 🏗️ **Practical Use Cases**

1. **Quickly switch between directories**
   Use `pushd` and `popd` to jump between frequently visited directories without typing full paths.

2. **Script navigation**
   Save a directory stack in a script, perform operations in multiple directories, and return to the original location.

3. **Undo directory changes**
   If you accidentally moved to the wrong folder, use `popd` to revert to the previous location.

---

## 💡 **Notes**

* `popd` is a **shell built-in command** in `bash` and `zsh`, not a standalone program.
* Directory stack is temporary and exists **per shell session**.
* Use `dirs -v` to view **index numbers** for easier `+N` or `-N` usage.

Example:

```bash
dirs -v
0  ~/projects
1  ~/downloads
2  /etc
```

---

### Quick Recap

| Command     | Action                                            |
| ----------- | ------------------------------------------------- |
| `pushd dir` | Add directory to stack & move into it             |
| `popd`      | Remove top directory from stack & move to new top |
| `dirs`      | Show directory stack                              |
| `popd +N`   | Remove Nth entry from left                        |
| `popd -N`   | Remove Nth entry from right                       |
| `popd -n`   | Remove from stack **without changing directory**  |

---

The `popd` command is especially useful for **efficient navigation** when working in **nested directories or scripts**.

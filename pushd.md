Here’s a **complete guide to the `pushd` command** in Linux, which complements `popd` and is all about **directory stack management**.

---

# 🧠 **`pushd` Command in Linux**

---

## 📘 **What is `pushd`?**

The **`pushd`** command is used to **save the current directory on a stack** and **change to a new directory**.

* Think of it as **bookmarking your current directory** before jumping to a new one.
* It is commonly used together with **`popd`** to navigate efficiently between directories.

---

## ⚙️ **Syntax**

```bash
pushd [OPTION] [+N | -N | directory]
```

* **`directory`** → The path you want to move to (and push the current directory onto the stack).
* **`+N`** / **`-N`** → Rotate the directory stack (explained below).

---

## 📄 **Directory Stack**

The **directory stack** is a **list of directories** saved with `pushd` and `popd`.

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

### 1️⃣ Push to a directory

```bash
pwd
pushd /etc
pwd
dirs
```

* Current directory is saved on the stack.
* You are now in `/etc`.
* Stack shows your previous directory on top of the new directory.

---

### 2️⃣ Swap directories

```bash
pushd /var
pushd /tmp
dirs
pushd
```

* Typing `pushd` without arguments **swaps the top two directories** in the stack.

---

### 3️⃣ Rotate stack using `+N` or `-N`

```bash
dirs -v
0  ~/projects
1  ~/downloads
2  /etc
```

* `pushd +1` → Rotate so that the 2nd directory becomes the top.
* `pushd -0` → Rotate the last directory to the top.

---

### 4️⃣ Push multiple directories (stack navigation)

```bash
pushd /usr
pushd /bin
pushd /lib
dirs
popd
dirs
```

* Stack lets you **jump back quickly** using `popd`.

---

## ⚡ **Options**

| Option | Description                                                 |
| ------ | ----------------------------------------------------------- |
| `-n`   | Rotate the stack **without changing** the current directory |
| `+N`   | Rotate Nth entry to the top (count from left/top)               |
| `-N`   | Rotate Nth entry to the top (count from right/down)              |

---

## 🏗️ **Practical Use Cases**

1. **Quick navigation**
   Move between directories efficiently without typing long paths repeatedly.

2. **Nested project directories**
   Save multiple directories in stack for quick access.

3. **Scripting**
   Use pushd/popd in scripts to temporarily enter directories, run commands, and return.

---

## 💡 **Notes**

* `pushd` is a **shell built-in command** in `bash` and `zsh`, not a standalone program.
* Stack is **per shell session**. Exiting the shell clears it.
* Use `dirs -v` to **see numbered stack entries** for rotation commands.

---

### Quick Recap

| Command     | Action                                      |
| ----------- | ------------------------------------------- |
| `pushd dir` | Push current dir to stack & move to new dir |
| `popd`      | Pop top dir from stack & move to it         |
| `dirs`      | Show directory stack                        |
| `pushd`     | Swap top two directories in stack           |
| `pushd +N`  | Rotate stack, Nth from left to top          |
| `pushd -N`  | Rotate stack, Nth from right to top         |
| `pushd -n`  | Rotate stack without changing current dir   |

---

💡 **Tip:** Use `pushd` + `popd` for **efficient navigation between multiple directories**, especially during development or system administration tasks.

---

If you want, I can also **combine `pushd` and `popd` in a visual example with a directory stack diagram** so you can see exactly how directories move in and out of the stack.

Do you want me to do that?

## 🔹 Difference Between `exit` and `return`

* **`exit`**

  * Ends the **whole script/shell**.
  * Sets the exit code of the script (`$?` to caller).

* **`return`**

  * Ends only the **function** (or a sourced script).
  * Sets the **function’s return status** (`$?` inside or after the function).
  * Cannot be used in a standalone script (unless sourced).

---

## 🔹 Syntax

```bash
return [N]
```

* `N` = numeric exit status (0–255).
* If `N` is omitted, the return status is that of the last command executed in the function.

---

## 🔹 Examples

### 1. Basic function return

```bash
myfunc() {
    echo "Doing work"
    return 5
}

myfunc
echo "Function returned: $?"
```

Output:

```
Doing work
Function returned: 5
```

---

### 2. Return without argument

```bash
myfunc() {
    ls /no/such/file
    return    # returns exit code of ls (2)
}

myfunc
echo "Function returned: $?"
```

If `ls` failed with code `2`, function returns `2`.

---

### 3. Return vs Exit

```bash
foo() {
    echo "Inside foo"
    return 1
    echo "Never runs"
}

bar() {
    echo "Inside bar"
    exit 1
    echo "Never runs"
}

foo
echo "After foo, still running"

bar
echo "This will never print"
```

* After `foo`, script continues.
* After `bar`, script **stops completely**.

---

### 4. Using return in sourced script

```bash
# script.sh
return 42
```

```bash
source script.sh
echo $?   # prints 42
```

⚠️ If you run `./script.sh`, it fails: `return: can only 'return' from a function or sourced script`.

---

### 5. Return values vs output

Shell functions can only return **numbers (0–255)**.
If you need to return text, use **stdout**:

```bash
get_name() {
    echo "Mahin"
}

name=$(get_name)
echo "Got name: $name"
```


## 🔹 What is `trap`?

* `trap` lets you specify **commands/functions** that run when the shell receives a **signal** or when certain **events** occur.
* Signals are notifications sent to a process by the kernel or other processes (e.g., `kill`, `Ctrl+C`).

So with `trap`, you can:

* **Clean up temporary files** before exit.
* **Gracefully shut down** a script on interruption.
* **Debug** by tracing signals or errors.

---

## 🔹 Syntax

```bash
trap [COMMANDS] [SIGNALS...]
```

* **COMMANDS**: The code (or function) to run. Quote it if multiple commands.
* **SIGNALS**: One or more signal names or numbers.

Examples:

```bash
trap "echo Interrupted" SIGINT
trap cleanup SIGINT SIGTERM
trap - SIGINT        # remove the trap for SIGINT
```

---

## 🔹 Common Signals

| Signal    | Number | Sent by      | Meaning                                     |
| --------- | ------ | ------------ | ------------------------------------------- |
| `SIGINT`  | 2      | `Ctrl+C`     | Interrupt (stop script)                     |
| `SIGTERM` | 15     | `kill`       | Default termination signal                  |
| `SIGQUIT` | 3      | `Ctrl+\`     | Quit (produces core dump)                   |
| `SIGHUP`  | 1      | Hangup       | Terminal closed or process disowned         |
| `EXIT`    | 0      | Shell itself | Run when the script exits (normal or error) |
| `ERR`     | -      | Bash only    | Run when a command fails (if `set -e`)      |

---

## 🔹 Usage Examples

### 1. **Basic cleanup**

```bash
#!/bin/bash
tmpfile="/tmp/testfile.$$"

cleanup() {
    echo "Cleaning up..."
    rm -f "$tmpfile"
}

trap cleanup SIGINT SIGTERM EXIT

echo "Working with $tmpfile"
echo "data" > "$tmpfile"
sleep 30
```

* Handles Ctrl+C, `kill`, or normal exit → cleanup runs.

---

### 2. **Trap multiple commands inline**

```bash
trap "echo 'Caught SIGINT'; rm -f /tmp/file; exit 1" SIGINT
```

---

### 3. **Trap EXIT for always-run code**

```bash
trap "echo Script finished" EXIT
```

Runs regardless of how the script exits (success or failure).

---

### 4. **Trap ERR for debugging**

```bash
set -e  # exit on error
trap 'echo "Error at line $LINENO"' ERR

cp missingfile /tmp
echo "This won't run"
```

---

### 5. **Remove a trap**

```bash
trap - SIGINT
```

Now SIGINT will behave normally again (terminate script without cleanup).

---

## 🔹 Key Points

* Always **quote** commands: `trap "cmd1; cmd2" SIGINT` (avoids word splitting).
* **Order matters**: trap must be set *before* signals are received.
* `EXIT`, `ERR`, `DEBUG`, `RETURN` are **pseudo-signals** available in Bash.
* You can trap **multiple signals at once**.
* `trap '' SIGNAL` ignores a signal.

Example (ignore Ctrl+C):

```bash
trap '' SIGINT
=

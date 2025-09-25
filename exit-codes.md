## 🔹 What are Exit Codes?

* When a process (command/script) finishes, it returns a **numeric value (0–255)** to the shell.
* `$?` holds the last command’s exit code.
* Convention:

  * `0` → **Success** (command executed without errors).
  * Non-zero → **Failure / Error** (the meaning depends on the program).

---

## 🔹 Shell-Reserved Exit Codes (from `bash(1)` and POSIX)

| Exit Code | Meaning                                                             |
| --------- | ------------------------------------------------------------------- |
| **0**     | Success                                                             |
| **1**     | General error / Catchall for general errors                         |
| **2**     | Misuse of shell builtins (invalid arguments, missing keyword, etc.) |
| **126**   | Command found but **not executable**                                |
| **127**   | Command **not found**                                               |
| **128**   | Invalid exit argument (e.g., `exit -1` or `exit 300`)               |
| **130**   | Script terminated by **Ctrl+C (SIGINT)**                            |
| **137**   | Process killed with **SIGKILL (kill -9)**                           |
| **139**   | Segmentation fault (SIGSEGV)                                        |
| **143**   | Process terminated with **SIGTERM (kill)**                          |
| **255**   | Exit status out of range (also used for unexpected errors)          |

---

## 🔹 Signal-related Exit Codes

By convention:

* Exit code = **128 + signal number**.
* Example:

  * `128 + 2 = 130` → SIGINT (Ctrl+C)
  * `128 + 9 = 137` → SIGKILL
  * `128 + 11 = 139` → SIGSEGV

This way you can tell if a process died because of a signal.

---

## 🔹 Special Shell Behavior

* `exit N` → explicitly sets exit status to **N**.
* If no `exit` is given, exit code = exit code of **last command**.
* If a command is **terminated by a signal**, exit code = **128 + signal number**.
* In functions, you can use `return N` (0–255).

---

## 🔹 Examples

```bash
true           # always succeeds
echo $?        # 0

false          # always fails
echo $?        # 1

ls /no/such    # no such file
echo $?        # 2 (from ls, not shell)

bash -c 'exit 126'  # simulate "not executable"
echo $?        # 126

bash -c 'exit 127'  # simulate "not found"
echo $?        # 127
```

---

## 🔹 Exit Code Ranges

| Range       | Meaning                                     |
| ----------- | ------------------------------------------- |
| **0**       | Success                                     |
| **1–125**   | Application-specific errors                 |
| **126**     | Command invoked cannot execute              |
| **127**     | Command not found                           |
| **128**     | Invalid exit argument                       |
| **129–255** | Terminated by signals or custom error codes |


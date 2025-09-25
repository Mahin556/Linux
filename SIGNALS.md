## 🔹 How to List Signals in Your Shell

You can run:

```bash
kill -l
```

This prints all signals that your system/kernel supports.
Most Linux systems follow **POSIX + BSD + System V extensions**, so usually you’ll see **64 signals (1–64)**.

---

## 🔹 Standard Signal Types in Shell

### 1. **POSIX Standard Signals** (always present)

| Signal    | Number | Default Action | Description                                        |
| --------- | ------ | -------------- | -------------------------------------------------- |
| `SIGHUP`  | 1      | Terminate      | Hangup (terminal closed, controlling process died) |
| `SIGINT`  | 2      | Terminate      | Interrupt from keyboard (**Ctrl+C**)               |
| `SIGQUIT` | 3      | Core dump      | Quit from keyboard (**Ctrl+\**)                    |
| `SIGILL`  | 4      | Core dump      | Illegal instruction                                |
| `SIGABRT` | 6      | Core dump      | Abort signal (`abort()` library call)              |
| `SIGFPE`  | 8      | Core dump      | Floating-point exception (divide by zero)          |
| `SIGKILL` | 9      | Terminate      | Kill signal (cannot be caught/ignored)             |
| `SIGSEGV` | 11     | Core dump      | Invalid memory reference (segfault)                |
| `SIGPIPE` | 13     | Terminate      | Broken pipe (writing to closed pipe/socket)        |
| `SIGALRM` | 14     | Terminate      | Timer expired (`alarm()` function)                 |
| `SIGTERM` | 15     | Terminate      | Termination signal (default from `kill`)           |
| `SIGUSR1` | 10     | Terminate      | User-defined signal 1                              |
| `SIGUSR2` | 12     | Terminate      | User-defined signal 2                              |
| `SIGCHLD` | 17     | Ignore         | Child process stopped or terminated                |
| `SIGCONT` | 18     | Continue       | Continue a stopped process                         |
| `SIGSTOP` | 19     | Stop           | Stop process (cannot be caught/ignored)            |
| `SIGTSTP` | 20     | Stop           | Stop typed at terminal (**Ctrl+Z**)                |
| `SIGTTIN` | 21     | Stop           | Background process read from terminal              |
| `SIGTTOU` | 22     | Stop           | Background process write to terminal               |

---

### 2. **Other Common Signals (Linux / BSD extensions)**

| Signal      | Number | Default Action | Description                         |
| ----------- | ------ | -------------- | ----------------------------------- |
| `SIGBUS`    | 7      | Core dump      | Bus error (bad memory access)       |
| `SIGPOLL`   | 29     | Terminate      | Pollable event (I/O on file/socket) |
| `SIGPROF`   | 27     | Terminate      | Profiling timer expired             |
| `SIGSYS`    | 31     | Core dump      | Bad system call                     |
| `SIGTRAP`   | 5      | Core dump      | Trace/breakpoint trap               |
| `SIGURG`    | 23     | Ignore         | Urgent condition on socket          |
| `SIGVTALRM` | 26     | Terminate      | Virtual timer expired               |
| `SIGXCPU`   | 24     | Core dump      | CPU time limit exceeded             |
| `SIGXFSZ`   | 25     | Core dump      | File size limit exceeded            |
| `SIGWINCH`  | 28     | Ignore         | Window resize signal                |

---

### 3. **Linux-specific Signals (Realtime & Others)**

* `SIGSTKFLT` (16) → Stack fault (obsolete, mostly unused)
* `SIGPWR` (30) → Power failure signal
* `SIGIO` (29) → Synonym for `SIGPOLL`
* **Realtime signals**: `SIGRTMIN` to `SIGRTMAX` (typically 34–64)

  * These are **application-defined**, queued signals with guaranteed delivery order.
  * Used heavily in real-time applications and POSIX threads.

---

## 🔹 Special “Pseudo-Signals” in Bash

These are not real OS signals but can be used in `trap`:

| Name     | Description                               |
| -------- | ----------------------------------------- |
| `EXIT`   | Triggered when the script exits           |
| `ERR`    | Triggered when a command fails (`set -e`) |
| `DEBUG`  | Triggered before every command executes   |
| `RETURN` | Triggered on a shell function return      |

---

## 🔹 Default Actions

* **Terminate (T)** → kill process immediately
* **Core dump (C)** → kill + dump memory image
* **Stop (S)** → suspend until resumed
* **Ignore (I)** → signal is discarded

---

✅ **In short**:
There are about **20 core POSIX signals**, plus **10–15 common Unix extensions**, plus **30 realtime signals**.
You can see them all on your machine with:

```bash
kill -l
```

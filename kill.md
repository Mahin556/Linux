## `kill` Command — Complete Guide

---

### What is `kill`?

> `kill` **sends signals** to processes — it doesn't just "kill" them. It can stop, pause, resume, or terminate processes depending on the signal sent.

---

### Basic Syntax

```bash
kill [signal] [PID]
kill -[signal] [PID]
kill -s [signal] [PID]
```

---

### All Signals — Complete List

| Signal No. | Name | Short Description |
|-----------|------|-------------------|
| 1 | `SIGHUP` | Hangup — reload config |
| 2 | `SIGINT` | Interrupt — same as Ctrl+C |
| 3 | `SIGQUIT` | Quit + core dump |
| 4 | `SIGILL` | Illegal instruction |
| 5 | `SIGTRAP` | Trace/breakpoint trap |
| 6 | `SIGABRT` | Abort signal |
| 7 | `SIGBUS` | Bus error |
| 8 | `SIGFPE` | Floating point error |
| **9** | **`SIGKILL`** | **Force kill — cannot be caught/ignored** |
| 10 | `SIGUSR1` | User-defined signal 1 |
| 11 | `SIGSEGV` | Segmentation fault |
| 12 | `SIGUSR2` | User-defined signal 2 |
| **15** | **`SIGTERM`** | **Graceful terminate (default)** |
| 16 | `SIGSTKFLT` | Stack fault |
| 17 | `SIGCHLD` | Child stopped/exited |
| 18 | `SIGCONT` | Continue if stopped |
| **19** | **`SIGSTOP`** | **Pause — cannot be caught/ignored** |
| 20 | `SIGTSTP` | Soft stop — same as Ctrl+Z |
| 21 | `SIGTTIN` | Background read from terminal |
| 22 | `SIGTTOU` | Background write to terminal |
| 23 | `SIGURG` | Urgent socket condition |
| 24 | `SIGXCPU` | CPU time limit exceeded |
| 25 | `SIGXFSZ` | File size limit exceeded |
| 26 | `SIGVTALRM` | Virtual timer expired |
| 27 | `SIGPROF` | Profiling timer expired |
| 28 | `SIGWINCH` | Window resize signal |
| 29 | `SIGIO` | I/O now possible |
| 30 | `SIGPWR` | Power failure |
| 31 | `SIGSYS` | Bad system call |

---

### Most Used Signals

| Signal | Command | Use Case |
|--------|---------|----------|
| **15** SIGTERM | `kill 1234` | Graceful shutdown ← **default** |
| **9** SIGKILL | `kill -9 1234` | Force kill frozen process |
| **1** SIGHUP | `kill -1 1234` | Reload config without restart |
| **2** SIGINT | `kill -2 1234` | Same as Ctrl+C |
| **19** SIGSTOP | `kill -19 1234` | Pause/freeze a process |
| **18** SIGCONT | `kill -18 1234` | Resume a paused process |

---

### Ways to Send a Signal

```bash
# By PID
kill 1234
kill -9 1234
kill -SIGKILL 1234
kill -KILL 1234          # all 4 are equivalent

# By name (killall)
killall firefox          # kills all processes named firefox
killall -9 nginx

# By pattern (pkill)
pkill chrome             # kills by name pattern
pkill -9 -u qe           # kill all processes of user 'qe'
pkill -f "python script.py"  # match full command line

# Kill multiple PIDs
kill -9 1234 5678 9101
```

---

### kill vs killall vs pkill

| Command | Targets by | Example |
|---------|-----------|---------|
| `kill` | **PID** | `kill -9 1234` |
| `killall` | **Exact name** | `killall firefox` |
| `pkill` | **Pattern/user/group** | `pkill -u john` |
| `xkill` | **Click window** (GUI) | `xkill` then click |

---

### SIGTERM vs SIGKILL — Key Difference

```
SIGTERM (15)                    SIGKILL (9)
─────────────────────           ─────────────────────
✅ Can be caught                ❌ Cannot be caught
✅ Can be ignored               ❌ Cannot be ignored
✅ Allows cleanup               ❌ No cleanup
✅ Saves data                   ❌ Data may be lost
❌ May not work on frozen proc  ✅ Always works
```

### Best Practice:
```bash
kill 1234        # try graceful first
sleep 5
kill -9 1234     # force if still alive
```

---

### Find PID Before Killing

```bash
ps aux | grep firefox        # find by name
pgrep firefox                # get PID directly
pidof nginx                  # get PID of exact name
top                          # interactive, note the PID
htop                         # visual, press F9 to kill
```

---

### Practical Examples

```bash
# Kill a hung process
kill -9 4055

# Reload nginx config
kill -1 $(pidof nginx)

# Pause a process (freeze it)
kill -19 1234

# Resume it
kill -18 1234

# Kill all processes of a user
pkill -u qe

# Kill process by port (e.g port 8080)
kill -9 $(lsof -t -i:8080)

# Kill all background jobs in shell
kill $(jobs -p)
```

---

### Signal Handling Summary

```
Can be Caught/Ignored:
  SIGTERM(15), SIGHUP(1), SIGINT(2), SIGUSR1(10), SIGUSR2(12)

Cannot be Caught/Ignored (always work):
  SIGKILL(9), SIGSTOP(19)

Caused by Hardware/Kernel:
  SIGSEGV(11), SIGBUS(7), SIGFPE(8), SIGILL(4)
```

---

### Exit After Kill — Check it worked

```bash
kill -9 1234
echo $?       # 0 = signal sent successfully
              # 1 = no such process or permission denied

# Confirm process is gone
ps aux | grep 1234
# or
pgrep 1234 && echo "still alive" || echo "dead"
```

---

## Default Signal in `kill`

---

### The Default is **SIGTERM (Signal 15)**

```bash
kill 1234
# is exactly the same as
kill -15 1234
kill -TERM 1234
kill -SIGTERM 1234
```

---

### What SIGTERM Does

```
Process receives SIGTERM
        ↓
Process CAN choose to:
   ├── Handle it gracefully (save data, close files, cleanup)
   ├── Ignore it completely
   └── Terminate immediately
```

---

### Why SIGTERM is the Default

| Reason | Explanation |
|--------|-------------|
| **Safe** | Gives process time to clean up |
| **Polite** | Asks process to stop, doesn't force |
| **Data protection** | Process can save state before exit |
| **Resource cleanup** | Closes files, sockets, temp files |
| **Industry standard** | Unix/Linux best practice |

---

### SIGTERM vs SIGKILL — Quick Recap

```
kill 1234          →   SIGTERM(15)  =  "Please stop"
kill -9 1234       →   SIGKILL(9)   =  "Stop RIGHT NOW"
```

| | SIGTERM (default) | SIGKILL |
|--|------------------|---------|
| **Can be ignored?** | ✅ Yes | ❌ No |
| **Allows cleanup?** | ✅ Yes | ❌ No |
| **Always works?** | ❌ No | ✅ Yes |
| **Safe for data?** | ✅ Yes | ❌ No |

---

### Golden Rule

```bash
# Always try default (SIGTERM) first
kill 1234

# Wait a moment...
sleep 3

# Only then force kill if still alive
kill -9 1234
```

> **Never jump straight to `kill -9`** — always give the process a chance to exit gracefully first.

---

# Process Management in Linux

## Introduction to Process Management
A process is an instance of a running program. Linux provides multiple utilities to monitor, manage, and control processes effectively. Each process has a unique **Process ID (PID)** and belongs to a parent process.

## Index of Commands Covered

### Viewing Processes
- `ps aux` – View all running processes
- `ps -u username` – View processes for a specific user
- `ps -C processname` – Show a process by name
- `pgrep processname` – Find a process by name and return its PID
- `pidof processname` – Find the PID of a running program

### Managing Processes
- `kill PID` – Terminate a process by PID
- `pkill processname` – Terminate a process by name
- `kill -9 PID` – Force kill a process
- `pkill -9 processname` – Kill all instances of a process
- `kill -STOP PID` – Stop a running process
- `kill -CONT PID` – Resume a stopped process
- `renice -n 10 -p PID` – Lower priority of a process
- `renice -n -5 -p PID` – Increase priority of a process (requires root)

### Background & Foreground Processes
- `command &` – Run a command in the background
- `jobs` – List background jobs
- `fg %jobnumber` – Bring a job to the foreground
- `Ctrl + Z` – Suspend a running process
- `bg %jobnumber` – Resume a suspended process in the background

### Monitoring System Processes
- `top` – Interactive process viewer
- `htop` – User-friendly process viewer (requires installation)
- `nice -n 10 command` – Run a command with a specific priority
- `renice -n -5 -p PID` – Change priority of an existing process

### Daemon Process Management
- `systemctl list-units --type=service` – List all system daemons
- `systemctl start service-name` – Start a daemon/service
- `systemctl stop service-name` – Stop a daemon/service
- `systemctl enable service-name` – Enable a service at startup

## Viewing Process Details
### Using `ps`
Show processes for a specific user:
```bash
ps -u username
```
Show a process by name:
```bash
ps -C processname
```

### Using `pgrep`
Find a process by name and return its PID:
```bash
pgrep processname
```

### Using `pidof`
Find the PID of a running program:
```bash
pidof processname
```

## Managing Processes
### Killing Processes
To terminate a process by PID:
```bash
kill PID
```
To terminate using process name:
```bash
pkill processname
```
Force kill a process:
```bash
kill -9 PID
```
Kill all instances of a process:
```bash
pkill -9 processname
```

### Stopping & Resuming Processes
Stop a running process:
```bash
kill -STOP PID
```
Resume a stopped process:
```bash
kill -CONT PID
```

### Changing Process Priority
View process priorities:
```bash
top  # Look at the NI column
```
Change priority of a running process:
```bash
renice -n 10 -p PID  # Lower priority (positive values)
renice -n -5 -p PID  # Higher priority (negative values, root required)
```

### Running Processes in the Background
Run a command in the background:
```bash
command &
```
List background jobs:
```bash
jobs
```
Bring a job to the foreground:
```bash
fg %jobnumber
```
Send a running process to the background:
```bash
Ctrl + Z  # Suspend process
bg %jobnumber  # Resume in background
```

## Monitoring System Processes
### Using `top`
Interactive process viewer:
- Press `k` and enter a PID to kill a process.
- Press `r` to renice a process.
- Press `q` to quit.

### Using `htop`
A user-friendly alternative to `top`:
```bash
htop
```
Allows mouse-based interaction for process management.

### Using `nice` & `renice`
Run a command with a specific priority:
```bash
nice -n 10 command
```
Change the priority of an existing process:
```bash
renice -n -5 -p PID
```

## Daemon Processes
Daemon processes run in the background without user intervention.
List all system daemons:
```bash
systemctl list-units --type=service
```
Start a daemon:
```bash
systemctl start service-name
```
Stop a daemon:
```bash
systemctl stop service-name
```
Enable a service at startup:
```bash
systemctl enable service-name
```

## Conclusion
Process management is crucial for system performance and stability. By using tools like `ps`, `top`, `htop`, `kill`, and `nice`, you can efficiently control and monitor Linux processes.


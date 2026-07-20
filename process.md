## Process States in Linux (`STAT` Column)

---

### Primary States

| State | Symbol | Meaning |
|-------|--------|---------|
| **Running** | `R` | Actively executing on CPU or in run queue |
| **Sleeping** | `S` | Interruptible sleep — waiting for event (I/O, timer, signal) |
| **Uninterruptible Sleep** | `D` | Waiting for I/O (disk/network) — **cannot be killed** |
| **Stopped** | `T` | Paused via `Ctrl+Z` or `SIGSTOP` signal |
| **Zombie** | `Z` | Process finished but **parent hasn't collected exit status** yet |
| **Idle** | `I` | Idle kernel thread (modern kernels) |

---

### Modifier Flags (appear after primary state)

| Flag | Meaning |
|------|---------|
| `s` | **Session leader** — leads a process group (e.g. a shell) |
| `+` | **Foreground** process group — tied to active terminal |
| `l` | **Multi-threaded** process |
| `N` | **Low priority** (nice value > 0) |
| `<` | **High priority** (nice value < 0) |
| `L` | Has **locked pages** in RAM (real-time processes) |

---

### Common Combinations Explained

| STAT | Meaning |
|------|---------|
| `Ss` | Sleeping + session leader → **typical idle shell** |
| `Ss+` | Sleeping + session leader + foreground → **active terminal shell** |
| `S+` | Sleeping + foreground → **running program in terminal** |
| `R+` | Running + foreground → **actively executing right now** |
| `Sl` | Sleeping + multi-threaded → **typical app like browser/server** |
| `SN` | Sleeping + low priority → **background/nice'd process** |
| `D` | Uninterruptible sleep → **doing heavy disk I/O** |
| `Z` | Zombie → **orphaned dead process** |

---

### Visual Flow

```
Created → R (Running)
              ↓
         S (Sleeping)  ←→  D (Uninterruptible)
              ↓
         T (Stopped via Ctrl+Z)
              ↓
         R (Resumed via fg/bg)
              ↓
         Z (Zombie — waiting for parent to reap)
              ↓
         Gone (parent calls wait())
```

---

### Key Differences — S vs D vs Z

| | `S` | `D` | `Z` |
|--|-----|-----|-----|
| **Can be killed?** | ✅ Yes | ❌ No | ❌ No |
| **Using CPU?** | ❌ No | ❌ No | ❌ No |
| **Using RAM?** | ✅ Yes | ✅ Yes | Minimal |
| **Waiting for?** | Signal/event | I/O completion | Parent process |
| **Dangerous?** | Normal | Can cause hangs | Clutter, rare issues |

---

## `ps aux` Output Explained

This command lists **all running processes** on the system. Here's what each column means:

---

### Column Headers

| Column | Meaning |
|--------|---------|
| **USER** | Who owns the process |
| **PID** | Process ID (unique number) |
| **%CPU** | CPU usage percentage |
| **%MEM** | Memory usage percentage |
| **VSZ** | Virtual memory size (KB) |
| **RSS** | Physical RAM actually used (KB) |
| **TTY** | Terminal the process is attached to |
| **STAT** | Process state |
| **START** | Time the process started |
| **TIME** | Total CPU time consumed |
| **COMMAND** | The actual command running |

---

### Process-by-Process Breakdown

| PID | User | Command | What it means |
|-----|------|---------|---------------|
| **1** | root | `/bin/bash` | The **init/main bash shell**, started at boot (00:38) |
| **69** | root | `/bin/bash` | Another root bash session, started at 02:15 |
| **2992** | root | `/bin/bash` | Root shell on `pts/1` |
| **3007** | root | `/bin/bash` | Root shell on `pts/3` |
| **4039** | root | `su - qe` | Root **switched user** to `qe` using `su` |
| **4040** | qe | `-bash` | Login shell created **for user `qe`** after `su` |
| **4048** | qe | `bash` | Another bash shell under `qe` |
| **4055** | qe | `bash` | Yet another bash shell under `qe` |
| **4072** | root | `ps aux` | **This very command** you just ran |

---

### STAT Column Decoded

| Code | Meaning |
|------|---------|
| **S** | Sleeping (waiting for something) |
| **Ss** | Sleeping + **session leader** |
| **Ss+** | Sleeping, session leader, **foreground process** |
| **S+** | Sleeping in **foreground** |
| **R+** | **Running** in foreground ← this is `ps aux` itself |

---

### Key Observations

- **All processes use 0% CPU/RAM** — the system is nearly idle
- **`pts/3`** is the most active terminal — user `qe` is working there
- The `su - qe` (PID 4039) → `-bash` (PID 4040) chain shows a **privilege/user switch**
- PID **1 being bash** (not `systemd`) suggests this is likely a **Docker container** or minimal environment, not a full Linux system

---

In Linux, every process has a **priority** and a **nice value**.

* **Priority (PRI):** The value the Linux scheduler uses to decide which process gets CPU time.
* **Nice value (NI):** A user-controlled value that influences the process priority.

  * Range: **-20 to 19**
  * **-20** = Highest priority
  * **19** = Lowest priority

### 1. View Process Priority Using `ps`

```bash
ps -eo pid,ppid,ni,pri,cmd
```

Example:

```bash
$ ps -eo pid,ppid,ni,pri,cmd

PID  PPID  NI PRI CMD
1      0    0  19 /sbin/init
1254   1    5  24 nginx
```

Where:

* `PID` = Process ID
* `NI` = Nice value
* `PRI` = Priority

---

### 2. View Priority of a Specific Process

```bash
ps -p <PID> -o pid,ni,pri,cmd
```

Example:

```bash
ps -p 1254 -o pid,ni,pri,cmd
```

Output:

```bash
PID  NI PRI CMD
1254  5  24 nginx
```

---

### 3. Using `top`

Run:

```bash
top
```

Look for these columns:

```text
PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
```

* `PR` = Priority
* `NI` = Nice value

Example:

```text
PID USER PR NI %CPU COMMAND
1254 root 25  5  12.5 nginx
```

---

### 4. Using `htop` (More User-Friendly)

Install:

```bash
sudo yum install htop -y     # RHEL/CentOS
sudo apt install htop -y     # Ubuntu
```

Run:

```bash
htop
```

You'll see:

* `PRI` (Priority)
* `NI` (Nice value)

---

### 5. Check Scheduling Policy and Priority

```bash
chrt -p <PID>
```

Example:

```bash
chrt -p 1254
```

Output:

```text
pid 1254's current scheduling policy: SCHED_OTHER
pid 1254's current scheduling priority: 0
```

This is especially useful for **real-time processes** (`SCHED_FIFO`, `SCHED_RR`).

---

### Interview Answer

**How do you check the priority of a process in Linux?**

> We can check a process's priority using commands like `ps`, `top`, `htop`, or `chrt`. The `ps -eo pid,ni,pri,cmd` command displays both the Nice value (NI) and Priority (PRI) of processes. In `top`, the `PR` column shows the current priority and the `NI` column shows the nice value. Lower nice values correspond to higher scheduling priority.

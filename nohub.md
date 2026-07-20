## `nohup` Command — Complete Guide

---

### What is `nohup`?

> `nohup` stands for **"No Hang Up"** — it runs a command that **keeps running even after you log out** or close the terminal.

---

### The Problem it Solves

```
Normal process:
  You login → start process → logout → SIGHUP sent → process DIES ❌

With nohup:
  You login → nohup start process → logout → SIGHUP ignored → process LIVES ✅
```

---

### Basic Syntax

```bash
nohup command &
nohup command [arguments] &
```
> The `&` sends it to **background** — without it, nohup still works but blocks the terminal

---

### Basic Examples

```bash
# Run a script
nohup ./script.sh &

# Run python script
nohup python3 app.py &

# Run with arguments
nohup ./backup.sh /home /backup &

# Run a server
nohup node server.js &
```

---

### Output — `nohup.out`

```
By default, nohup saves ALL output to:
  → nohup.out  (in current directory)
  → ~/nohup.out (if current dir is not writable)
```

```bash
# Default — output goes to nohup.out
nohup ./script.sh &

# Custom output file
nohup ./script.sh > mylog.log &

# Separate stdout and stderr
nohup ./script.sh > output.log 2> error.log &

# Merge both into one file
nohup ./script.sh > all.log 2>&1 &

# Discard all output
nohup ./script.sh > /dev/null 2>&1 &
```

---

### Check the PID

```bash
nohup ./script.sh &
# Output: [1] 4321  ← this is your PID

# Or save PID for later
nohup ./script.sh &
echo $! > myscript.pid    # $! = PID of last background process
```

---

### Monitor the Process

```bash
# Check if still running
ps aux | grep script.sh

# Watch the output live
tail -f nohup.out

# Check by PID
ps -p 4321

# Using pgrep
pgrep -a script.sh
```

---

### Stop a nohup Process

```bash
# Find PID
pgrep -a script.sh

# Graceful stop
kill 4321

# Force stop
kill -9 4321

# Using saved PID file
kill $(cat myscript.pid)
```

---

### nohup vs & vs disown

| Feature | `&` alone | `nohup` | `disown` |
|---------|-----------|---------|---------|
| Runs in background | ✅ | ✅ | ✅ |
| Survives logout | ❌ | ✅ | ✅ |
| Ignores SIGHUP | ❌ | ✅ | ✅ |
| Saves output to file | ❌ | ✅ auto | ❌ |
| Works on running process | ❌ | ❌ | ✅ |

```bash
# disown — detach an already running process
./script.sh &          # start in background
disown                 # detach from terminal
```

---

### nohup with Multiple Commands

```bash
# Run two commands
nohup bash -c "command1 && command2" &

# Run a sequence
nohup bash -c "cd /app && python3 server.py" &

# Run a loop
nohup bash -c "while true; do ./task.sh; sleep 60; done" &
```

---

### Practical Real-World Examples

```bash
# Keep web server running
nohup python3 -m http.server 8080 &

# Long running backup
nohup rsync -av /home/ /backup/ > backup.log 2>&1 &

# Run ML training job overnight
nohup python3 train_model.py > training.log 2>&1 &

# Database dump
nohup mysqldump -u root -p mydb > dump.sql &

# Keep log of everything
nohup ./monitor.sh >> /var/log/monitor.log 2>&1 &
```

---

### What Happens Internally

```
nohup ./script.sh &
        ↓
  1. SIGHUP signal → IGNORED for this process
  2. stdout/stderr → redirected to nohup.out
  3. Process detached → runs independently
  4. Terminal closes → process keeps running
  5. Parent (shell) exits → process adopted by init/systemd (PID 1)
```

---

### Key Points to Remember

```
✅ Always use & with nohup for background execution
✅ Check nohup.out for output/errors
✅ Save PID using $! for easy management later
✅ Use > /dev/null 2>&1 to suppress all output
❌ nohup cannot be applied to already running processes (use disown)
❌ nohup does not make a process a proper daemon
```

---

### nohup vs screen vs tmux

| Tool | Use Case |
|------|----------|
| `nohup` | Simple fire-and-forget background jobs |
| `screen` | Detachable terminal sessions you can reattach |
| `tmux` | Advanced multi-window terminal multiplexer |

```bash
# If you need to WATCH the process live later → use tmux/screen
tmux new -s mysession
./script.sh

# Detach with Ctrl+B then D
# Reattach later
tmux attach -t mysession
```
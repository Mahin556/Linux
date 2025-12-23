# 🌋 **Complete Guide to the `stress` Command in Linux (Full Explanation + Examples)**

`stress` is a Linux tool used to **generate artificial load** on:

* CPU
* Memory (RAM)
* Disk I/O
* I/O wait
* Threads

It is used heavily for:

* Auto Scaling testing
* Benchmarking
* Performance testing
* Reliability testing
* Triggering scaling policies
* Identifying bottlenecks
* Testing alarms (CloudWatch, Prometheus)

---

# 1️⃣ **Install stress**

### **Ubuntu / Debian**

```
sudo apt update
sudo apt install stress -y
```

### **RHEL / CentOS / Amazon Linux**

```
sudo yum install stress -y
```

If repo missing / you get “No package stress available”:

```
sudo amazon-linux-extras install epel -y
sudo yum install stress -y
```

---

# 2️⃣ **Basic Syntax**

```
stress [OPTIONS]
```

---

# 3️⃣ **Most Important Options (Must Learn)**

| Option          | Meaning                                |
| --------------- | -------------------------------------- |
| `-c N`          | Start **N CPU workers** (max CPU load) |
| `-m N`          | Start **N memory workers**             |
| `--vm-bytes X`  | Amount of memory each worker allocates |
| `-i N`          | Start **N I/O workers**                |
| `-d N`          | Start **N disk workers**               |
| `--hdd-bytes X` | Amount of data each HDD worker writes  |
| `-t TIME`       | Run test for specific duration         |

---

# 4️⃣ **Create CPU Load**

### **Use 4 CPU cores at 100%**

```
stress -c 4
```

### **Run CPU load for 60 seconds**

```
stress -c 4 -t 60
```

### **Run until stopped**

```
stress -c 8
```

(Press **CTRL + C** to stop)

---

# 5️⃣ **Check CPU Load While Running**

Open another terminal:

```
top
```

or

```
htop
```

You should see **CPU 100% usage**.

---

# 6️⃣ **Memory (RAM) Load**

### **Allocate 1GB RAM**

```
stress -m 1 --vm-bytes 1G
```

### **Allocate 4GB RAM for 2 minutes**

```
stress -m 4 --vm-bytes 1G -t 120
```

### **Stress test full RAM (dangerous)**

```
stress -m 2 --vm-bytes 90%
```

⚠️ If you allocate too much memory → system may hang or OOM-killer may kill `stress`.

---

# 7️⃣ **Disk / HDD Load**

### **One disk worker**

```
stress -d 1
```

### **Write 2GB to disk**

```
stress -d 1 --hdd-bytes 2G
```

### **Simulate high disk IOPS**

```
stress -d 5 --hdd-bytes 512M
```

This is useful to test EBS Burst, IOPS alarms, and disk bottlenecks.

---

# 8️⃣ **I/O Load (System I/O Wait)**

### **Generate I/O pressure**

```
stress -i 4
```

This will stress:

* syscall operations
* memory operations
* IO wait
* context switching

Helpful for testing systems where IO wait can increase latency.

---

# 9️⃣ **Combined CPU + RAM + IO Load (Realistic Testing)**

### **Combo Test**

```
stress -c 4 -m 2 --vm-bytes 512M -i 2 -t 120
```

This simulates real production load.

---

# 🔟 **Practical Scenarios (MOST IMPORTANT SECTION)**

## ⭐ Scenario 1 — Test AWS Auto Scaling (CPU policy)

Set CPU policy to scale at **70% CPU**.

Then run:

```
stress -c 4
```

This will trigger:

* CloudWatch CPU Alarm
* Auto Scaling Group to launch new instances

Very commonly used in interviews + real production.

---

## ⭐ Scenario 2 — Test Kubernetes HPA (Horizontal Pod Autoscaler)

If CPU threshold is 80%:

```
stress -c 8
```

K8s will create new pods automatically.

---

## ⭐ Scenario 3 — Test server under heavy RAM pressure

```
stress -m 2 --vm-bytes 2G
```

---

## ⭐ Scenario 4 — Crash system intentionally (for DR testing)

⚠️ Dangerous — Only in labs.

```
stress -c 100 -m 4 --vm-bytes 90% -i 5
```

---

## ⭐ Scenario 5 — Find bottleneck

Try components one-by-one:

CPU:

```
stress -c 2
```

Memory:

```
stress -m 2 --vm-bytes 512M
```

I/O:

```
stress -i 4
```

Disk:

```
stress -d 1
```

This helps identify:

* CPU bottleneck
* RAM shortage
* Disk slowness
* I/O issues

---

# 1️⃣1️⃣ **Run Stress in Background**

```
nohup stress -c 4 -t 300 &
```

---

# 1️⃣2️⃣ **Stop Stress**

Find PID:

```
pgrep stress
```

Kill it:

```
kill -9 <PID>
```

Or simply CTRL + C.

---

# 1️⃣3️⃣ **Important: stress vs stress-ng**

`stress` is old.
`stress-ng` is newer and more powerful.

If you want a guide on `stress-ng` also, tell me — it has 200+ stressors.

---

# 1️⃣4️⃣ **Monitoring Tools to Use Along with stress**

### CPU:

```
top
htop
mpstat
iostat
sar
```

### Memory:

```
free -m
vmstat
sar -r
```

### Disk:

```
iostat -x
iotop
df -h
```

### Network:

```
iftop
nethogs
sar -n DEV
```

---

In the **`stress`** command, a **worker** means:

# **👉 A separate process (or thread) created by `stress` to generate load.**

Each worker performs one type of load-generating activity:

* **CPU worker** → uses 100% CPU
* **Memory worker** → allocates RAM
* **I/O worker** → performs I/O operations (read/write)
* **HDD worker** → writes to disk
* **VM worker** → memory stress with malloc/free loops

So when you specify:

```
stress -c 4
```

It means:

✔ Create **4 CPU workers**
✔ Each worker = 1 separate process
✔ Each process = max CPU load on one core

---

# 🔥 **Very Simple Example to Understand**

Imagine you hire people for a job:

* If you hire 1 worker → only 1 person is working
* If you hire 10 workers → 10 people are working together

Same concept here:

| Command | Meaning                                       |
| ------- | --------------------------------------------- |
| `-c 1`  | 1 CPU worker = 1 process eating CPU           |
| `-c 4`  | 4 CPU workers = 4 processes eating CPU        |
| `-m 2`  | 2 memory workers = 2 processes allocating RAM |

---

# **Example Breakdown**

### Command:

```
stress -c 3 -m 2 --vm-bytes 256M
```

This means:

### ✔ CPU Side

* `-c 3` → **3 CPU workers**
* Each worker = 1 full CPU-hungry process

Your CPU usage increases on **3 cores**.

---

### ✔ Memory Side

* `-m 2` → **2 memory workers**
* `--vm-bytes 256M` → each worker allocates 256 MB RAM

So total RAM allocated = **2 × 256 MB = 512 MB**

---

# **How to See Workers Running?**

Run:

```
ps -ef | grep stress
```

You will see multiple processes:

```
stress: cpu worker 0
stress: cpu worker 1
stress: cpu worker 2
stress: vm worker 0
stress: vm worker 1
```

Each line = separate worker.

---

# **Why Workers Are Used?**

Workers allow you to:

* Generate **parallel** load
* Simulate multi-core CPU load
* Simulate many processes hitting memory
* Stress test concurrency
* Trigger AWS EC2 **Auto Scaling** policies
* Test Kubernetes HPA scaling
* See how system behaves under multiple tasks

---

# **Worker Types (Complete List)**

| Worker Type | Option        | What It Does                   |
| ----------- | ------------- | ------------------------------ |
| CPU         | `-c`          | Continuously burns CPU cycles  |
| Memory (VM) | `-m`          | Allocates memory repeatedly    |
| I/O         | `-i`          | Generates system I/O load      |
| HDD         | `-d`          | Writes temporary files to disk |
| HDD-Bytes   | `--hdd-bytes` | Sets write size per HDD worker |

---

# **In short:**

**A worker = one process = one load generator.**

The more workers you create →
the more load your system gets →
the faster CPU/RAM/IO goes to 100% →
the faster Auto Scaling happens.

---


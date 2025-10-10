## **1. What is `uptime`?**

The `uptime` command shows **how long the system has been running** along with **system load averages** and **logged-in users**.

It’s a quick way to see the **health and activity** of the system.

---

## **2. Basic Syntax**

```bash
uptime [options]
```

* Usually run **without options**.
* Output is a single line with uptime, number of users, and load averages.

---

## **3. Default Output**

Example:

```bash
$ uptime
 16:25:10 up 5 days, 3:12,  3 users,  load average: 0.15, 0.20, 0.25
```

**Explanation of fields:**

| Field                            | Description                                            |
| -------------------------------- | ------------------------------------------------------ |
| `16:25:10`                       | Current system time                                    |
| `up 5 days, 3:12`                | System uptime (5 days, 3 hours 12 minutes)             |
| `3 users`                        | Number of users currently logged in                    |
| `load average: 0.15, 0.20, 0.25` | System load averages for the last 1, 5, and 15 minutes |

---

## **4. Load Average Explained**

* The **load average** represents **average number of processes in the run queue** (waiting for CPU) over time.
* Format: `1min, 5min, 15min`
* Example: `0.15, 0.20, 0.25`

  * Very low → system idle
  * Close to number of CPU cores → system fully utilized
  * Higher than CPU cores → system overloaded

**Rule of thumb:**

* On a **4-core CPU**:

  * Load ≤ 4 → normal
  * Load > 4 → CPU bottleneck

---

## **5. Options**

| Option | Description                                       |
| ------ | ------------------------------------------------- |
| `-p`   | Show uptime in **pretty format** (human-readable) |
| `-s`   | Show **system startup time**                      |
| `-V`   | Show **version** of uptime command                |

**Examples:**

```bash
$ uptime -p
up 5 days, 3 hours, 12 minutes

$ uptime -s
2025-10-05 13:13:00
```

---

## **6. Use Cases**

1. **Check how long system has been running**

```bash
uptime
```

2. **Monitor system load**

```bash
uptime
# Compare load average to number of CPU cores
```

3. **Check startup time**

```bash
uptime -s
```

4. **Pretty print uptime**

```bash
uptime -p
```

---

## **7. Related Commands**

* `w` → Shows uptime + logged-in users + their activity
* `top` → Shows uptime + load averages + processes in real time
* `cat /proc/uptime` → Shows uptime in seconds (raw data)

---

### ✅ **Summary**

* `uptime` = shows **how long the system has been up**, **users logged in**, and **CPU load averages**.
* Load average helps check if the system is **idle, fully utilized, or overloaded**.
* Use `-p` or `-s` for **human-readable formats**.

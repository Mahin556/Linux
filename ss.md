### References:
-

---

```bash
ss -t #to see the tcp sockets only
ss -u #to see the udp sockets only
ss -l #to see the listening sockets
ss -p #to see the process that is using the socket
ss -n #to see the ports only, otherwise it will show you the hostname only like 443-> https, 172.20.10.4-> amanpathakdevops.com
ss -a #to see both types of sockets including listening and non-listening
ss -i #to see the detailed metrics for your particular process like retransmission, congestion window, rtt, etc., in case your application is running slow but CPU and RAM are fine.
```
```bash
================ SCENARIO 3 — PORT LISTENING BUT TRAFFIC NOT REACHING APP ================

COMMAND TO CHECK ALL LISTENING SOCKETS (ALWAYS USE sudo):

sudo ss -tulpen

-------------------------------- WHAT EACH FLAG MEANS --------------------------------
-t  → TCP sockets
-u  → UDP sockets
-l  → Only LISTENING ports
-p  → Show process name & PID using the port
-e  → Extended info (UID, inode, etc.)
-n  → Numeric IPs & ports (no DNS lookup)

-------------------------------- WHY sudo IS IMPORTANT --------------------------------
* Without sudo, some sockets are HIDDEN
* You may MISS the real process binding the port
* sudo ensures COMPLETE visibility of:
  - System services
  - Root-owned processes
  - Container runtimes

-------------------------------- WHAT TO VERIFY --------------------------------
* Is the port actually LISTENING?
* Is it bound to:
  - 127.0.0.1  → Local only (external traffic will FAIL)
  - 0.0.0.0    → Accepts traffic from anywhere
* Is the correct application owning the port?
* Is another process hijacking the port?

-------------------------------- COMMON ROOT CAUSES --------------------------------
* App listening on localhost instead of 0.0.0.0
* Wrong process bound to the port
* Firewall / Security Group blocking traffic
* Container not exposing port correctly

-------------------------------- LEGACY ALTERNATIVE --------------------------------
sudo netstat -tulpen

=======================================================================================
```
```bash
================ SCENARIO 2 — BACKEND APP CAN'T CONNECT TO POSTGRES ==================

PROBLEM STATEMENT:
* You are inside a Backend Pod / VM
* Application is RUNNING
* Connection to Postgres DB is FAILING
* This is a DESTINATION reachability issue

CORRECT COMMAND TO CHECK DESTINATION PORT REACHABILITY:

sudo ss -tni dport = :5432

(Example shown with 443 earlier — for Postgres ALWAYS use 5432)

-------------------------------- WHY THIS COMMAND --------------------------------
* When the issue is:
  - "App cannot CONNECT to DB"
  - "Traffic not reaching destination"
→ You must check OUTGOING connections

That’s why **dport** is used.

-------------------------------- FLAG BREAKDOWN --------------------------------
-t  → TCP connections (Postgres uses TCP)
-n  → Numeric output (no DNS resolution)
-i  → INTERNAL TCP info (VERY IMPORTANT)
dport → Destination port (DB side)

-------------------------------- WHY -i IS CRITICAL --------------------------------
* Shows TCP-level details:
  - cwnd (congestion window)
  - rtt (round-trip time)
  - retransmissions
  - send/receive queues
* Helps identify:
  - Packet drops
  - SYN retries
  - Network congestion
  - Connection timeouts

-------------------------------- WHAT TO LOOK FOR --------------------------------
* SYN-SENT state → DB not reachable
* No output → Connection not even attempted
* High retransmits → Network / firewall issue
* ESTAB but app still failing → App-level issue

-------------------------------- COMMON ROOT CAUSES --------------------------------
* Wrong DB hostname / IP
* DB Security Group / Firewall blocking 5432
* Kubernetes NetworkPolicy blocking egress
* DB not listening on 0.0.0.0
* Wrong credentials (network OK, auth fails)

-------------------------------- BONUS: VERIFY DB IS LISTENING (ON DB SIDE) --------------------------------
sudo ss -tulpen | grep 5432

-------------------------------- ONE-LINE INTERVIEW ANSWER --------------------------------
“When checking reachability to a destination service, always inspect outgoing connections using ss with dport and -i.”

==================================================================================
```
```bash
================ SCENARIO 1 — FIND PROCESS USING PORT 443 ==================

PROBLEM STATEMENT:
* You want to know:
  - Which PROCESS is using socket/port 443
* This is a LOCAL LISTENING port check

CORRECT COMMAND:

sudo ss -tlpn | grep 443

-------------------------------- WHY THIS WORKS --------------------------------
* Port 443 is typically used by:
  - HTTPS servers
  - Reverse proxies (Nginx, Envoy)
  - Ingress controllers

This command shows:
* Listening sockets
* Process name + PID
* Port number in numeric form

-------------------------------- FLAG BREAKDOWN --------------------------------
-t  → TCP sockets
-l  → Listening sockets only
-p  → Show process using the socket (PID + program)
-n  → Numeric output (NO DNS / service-name resolution)

-------------------------------- WHY -n IS IMPORTANT --------------------------------
* Skips hostname & service-name resolution
* Much faster output
* Avoids confusion like:
  443 → https
  80  → http

-------------------------------- ALTERNATIVE (NO grep – CLEANER) --------------------------------

Inbound (service listening on 443):
sudo ss -tlpn sport = :443

Outbound (process connecting TO 443):
sudo ss -tnp dport = :443

-------------------------------- WHEN TO USE sport vs dport --------------------------------
* sport → Source port (local listening services)
* dport → Destination port (outgoing connections)

-------------------------------- COMMON USE CASES --------------------------------
* Web server not starting
* Port already in use
* Debugging TLS / HTTPS issues
* Kubernetes NodePort / Ingress troubleshooting

-------------------------------- ONE-LINE INTERVIEW ANSWER --------------------------------
“To identify which process is using a port, use ss with -l -p -n and filter by source port.”

==================================================================================
```

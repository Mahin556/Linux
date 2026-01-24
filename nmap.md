```bash
nmap -sP 192.168.29.0/24 #Find all up device in a network
nmap -sn 192.168.29.0/24
nmap -Pn 192.168.29.0/24

nmap -sT -p 80,443 192.168.29.0/24

nmap -sS -p 80,443 192.168.29.0/24

nmap -sS -D 192.168.29.83 192.168.29.0/24

#Scan most used 1000ports t scane on specific host
nmap -sT 192.168.29.105
nmap -sS 192.168.29.105

nmap -O 192.168.29.105 #Guess OS of traget

nmap -A 192.168.29.171

nmap --script vuln 192.168.29.105
```
```bash
📦 NMAP TARGETS – SIMPLE EXPLANATION
──────────────────────────────────
Nmap needs to know WHAT to scan.
These are the common ways to give targets:

1️⃣ Single IP
   nmap 1.2.3.4
   → Scan one computer

2️⃣ Subnet (CIDR)
   nmap 1.2.3.0/24
   → Scan all IPs in that network

3️⃣ IP Range
   nmap 1.2.3.4-8
   → Scan IPs from .4 to .8

4️⃣ Multiple IPs
   nmap 1.2.3.4 5.6.7.8
   → Scan only these specific machines

5️⃣ Text File
   nmap -iL hosts.txt
   → Scan targets listed in a file

6️⃣ Domain Name
   nmap example.com
   → Resolve domain to IP and scan it

🧠 TIP:
- Small targets = safer & faster
- Big ranges = more traffic
- Always scan with permission
──────────────────────────────────
```

```bash
📦 NMAP PORT SELECTION – SIMPLE BOX EXPLANATION
─────────────────────────────────────────────
By default, Nmap scans the MOST COMMON ports.
You can control EXACTLY which ports to scan.

─────────────────────────────────────────────
1️⃣ Single Port
nmap 1.2.3.4 -p 80
→ Scan only port 80

─────────────────────────────────────────────
2️⃣ Sequential Port Range
nmap 1.2.3.4 -p 20-30
→ Scan ports 20 to 30

─────────────────────────────────────────────
3️⃣ Specific / Distributed Ports
nmap 1.2.3.4 -p 80,22,111
→ Scan only listed ports

─────────────────────────────────────────────
4️⃣ Service Name (Service-specific)
nmap 1.2.3.4 -p http
nmap 1.2.3.4 -p http,https
→ Uses service → port mapping
(http=80, https=443)

─────────────────────────────────────────────
5️⃣ Protocol Specific
nmap 1.2.3.4 -p T:22,U:53
→ T = TCP, U = UDP

─────────────────────────────────────────────
6️⃣ All Ports (⚠️ Slow)
nmap 1.2.3.4 -p-
→ Scan ALL 65535 ports

─────────────────────────────────────────────
🔥 Extra Useful
nmap 1.2.3.4 --top-ports 100
→ Scan top 100 common ports

─────────────────────────────────────────────
🧠 Tips
• Smaller port list = faster scan
• -p- = noisy & slow
• Use top-ports for quick checks
• Combine with -sS / -sU for power

─────────────────────────────────────────────
```
```bash
📦 NMAP SCAN TECHNIQUES – SIMPLE BOX EXPLANATION
─────────────────────────────────────────────

These options tell Nmap *HOW* to scan ports.

─────────────────────────────────────────────
1️⃣ TCP CONNECT SCAN  (-sT)
• Full TCP handshake (SYN → SYN/ACK → ACK)
• Uses OS networking (no raw packets)
• Noisy but reliable

Use when:
✔ No root access
✔ Accuracy > stealth

─────────────────────────────────────────────
2️⃣ TCP SYN SCAN  (-sS)
• Half-open scan (SYN → SYN/ACK → RST)
• Does NOT complete connection
• Fast and stealthy

Use when:
✔ Root access
✔ Most common & preferred scan

─────────────────────────────────────────────
3️⃣ FIN SCAN  (-sF)
• Sends FIN packet
• Closed port → RST
• Open port → no response

Use when:
✔ Firewall evasion
❌ Works poorly on Windows

─────────────────────────────────────────────
4️⃣ XMAS SCAN  (-sX)
• FIN + PSH + URG flags set
• “Christmas tree” packet

Use when:
✔ IDS / firewall evasion
❌ Not reliable on Windows

─────────────────────────────────────────────
5️⃣ NULL SCAN  (-sN)
• No TCP flags set
• Closed → RST
• Open → no reply

Use when:
✔ Stealth scanning
❌ Windows ignores it

─────────────────────────────────────────────
6️⃣ PING SCAN  (-sn)
• No port scan
• Only checks if host is alive

Use when:
✔ Host discovery only

─────────────────────────────────────────────
7️⃣ UDP SCAN  (-sU)
• Scans UDP services (DNS, SNMP, NTP)
• Very slow
• No response often means open

Use when:
✔ UDP services matter

─────────────────────────────────────────────
8️⃣ ACK SCAN  (-sA)
• Sends ACK packets
• Determines firewall rules
• Does NOT find open ports

Use when:
✔ Firewall mapping

─────────────────────────────────────────────
🧠 QUICK MEMORY TIP
-sT → noisy
-sS → stealth
-sU → slow
-sA → firewall
-sN/-sF/-sX → evasion
-sn → alive check

─────────────────────────────────────────────
```
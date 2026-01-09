```bash
=============================== dig — DNS TRUTH TELLER ===============================
              DNS LOOKUPS • RECORDS • TRACE • BTS EXPLANATION
====================================================================================

WHAT IS `dig`?
* `dig` = **Domain Information Groper**
* It is a DNS troubleshooting tool
* It directly queries DNS servers and shows:
  - Exact DNS responses
  - Which server replied
  - How the resolution happened
* Unlike browsers:
  - dig does NOT cache
  - dig does NOT lie
  - dig shows raw DNS truth

Think of dig as:
→ 🔍 **X-ray machine for DNS**

------------------------------------------------------------------------------------
WHY dig IS IMPORTANT FOR DEVOPS / CLOUD
------------------------------------------------------------------------------------

* DNS is the first dependency for almost everything:
  - Applications
  - Load Balancers
  - Kubernetes
  - APIs
* If DNS is broken → app is broken
* dig helps answer:
  - Is DNS resolving?
  - Which server is replying?
  - Is propagation complete?
  - Are records configured correctly?

------------------------------------------------------------------------------------
BASIC DNS LOOKUP (DOMAIN → IP)
------------------------------------------------------------------------------------

Command:
dig google.com

What happens internally:
* Your system sends a DNS query
* dig shows:
  - Query sent
  - Answer received
  - TTL
  - Record type
  - Responding DNS server

Useful for:
* Checking if DNS resolves at all
* Debugging "site not opening"

------------------------------------------------------------------------------------
GET ONLY THE IP (CLEAN OUTPUT)
------------------------------------------------------------------------------------

Command:
dig +short google.com

Output:
* Only IP address(es)
* No metadata
* No headers

Why this is useful:
* Scripting
* Automation
* Health checks

Example use:
* Bash scripts
* Terraform external data
* Monitoring

------------------------------------------------------------------------------------
QUERY SPECIFIC RECORD TYPES
------------------------------------------------------------------------------------

Command:
dig google.com MX

What this checks:
* Mail Exchange records
* Used by email servers

Common record types:
* A     → IPv4 address
* AAAA  → IPv6 address
* MX    → Mail server
* TXT   → Verification / SPF / DKIM
* CNAME → Alias
* NS    → Name servers

Use cases:
* Email not working
* Domain verification failed
* SSL / SPF issues

------------------------------------------------------------------------------------
DNS TRACE (MOST POWERFUL FEATURE)
------------------------------------------------------------------------------------

Command:
dig google.com +trace

What happens behind the scenes:
* dig starts from:
  - Root DNS servers (.)
* Then goes to:
  - TLD servers (.com)
* Then goes to:
  - Authoritative Name Servers
* Finally gets the IP

You see the FULL DNS journey:
Root → TLD → Authoritative → Answer

------------------------------------------------------------------------------------
WHY `dig +trace` IS GOLD
------------------------------------------------------------------------------------

It answers:
* Where DNS is breaking
* Whether propagation is complete
* If authoritative server is misconfigured

Examples:
* Root responds ✔️
* TLD responds ✔️
* Authoritative server fails ❌ → configuration issue

------------------------------------------------------------------------------------
DNS PROPAGATION CHECK
------------------------------------------------------------------------------------

Use:
dig domain.com +trace

Why:
* DNS propagation = updating records across servers
* dig +trace shows:
  - Which servers already have new record
  - Which ones don’t

This removes guesswork:
❌ “Wait 24 hours”
✅ “This NS has not updated yet”

------------------------------------------------------------------------------------
REAL-WORLD TROUBLESHOOTING SCENARIOS
------------------------------------------------------------------------------------

1️⃣ Website not opening
* dig domain.com
* If no answer → DNS issue

2️⃣ Works for me, not for others
* dig +trace domain.com
* Check propagation status

3️⃣ Email delivery failing
* dig domain.com MX

4️⃣ Load balancer DNS confusion
* dig lb-name.amazonaws.com
* Validate resolved IPs

------------------------------------------------------------------------------------
dig VS ping VS nslookup
------------------------------------------------------------------------------------

* ping:
  - Checks reachability
  - NOT DNS authoritative

* nslookup:
  - Older tool
  - Less detailed

* dig:
  - Industry standard
  - Script-friendly
  - Deep visibility

➡️ **Always prefer dig**

------------------------------------------------------------------------------------
KEY TAKEAWAYS
------------------------------------------------------------------------------------

* dig tells the **truth about DNS**
* Shows real authoritative responses
* Essential for:
  - Cloud
  - Kubernetes
  - DevOps
  - Networking
* If DNS is broken → everything is broken

------------------------------------------------------------------------------------
ONE-LINE INTERVIEW ANSWER
------------------------------------------------------------------------------------

"`dig` is a DNS diagnostic tool used to query DNS servers directly and analyze
record resolution, propagation, and authoritative responses."

====================================================================================
```
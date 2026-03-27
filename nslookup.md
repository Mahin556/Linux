```bash
# nslookup has two modes:

# Non-interactive (single command)

# Interactive (subcommands like set, server, root are mainly used here)

nslookup ebay.com
```
```bash
controlplane:~$ nslookup
> google.com #Queries current configured DNS server for A record (default type)
Server:         8.8.8.8
Address:        8.8.8.8#53

Non-authoritative answer:
Name:   google.com
Address: 74.125.130.113
Name:   google.com
Address: 74.125.130.138
Name:   google.com
Address: 74.125.130.100
Name:   google.com
Address: 74.125.130.102
Name:   google.com
Address: 74.125.130.101
Name:   google.com
Address: 74.125.130.139
Name:   google.com
Address: 2404:6800:4003:c01::64
Name:   google.com
Address: 2404:6800:4003:c01::65
Name:   google.com
Address: 2404:6800:4003:c01::71
Name:   google.com
Address: 2404:6800:4003:c01::8a
> 
```
```bash
> server 8.8.4.4 #Change DNS server
Default server: 8.8.4.4
Address: 8.8.4.4#53
> youtube.com
Server:         8.8.4.4
Address:        8.8.4.4#53

Non-authoritative answer:
Name:   youtube.com
Address: 142.251.10.190
Name:   youtube.com
Address: 142.251.10.136
Name:   youtube.com
Address: 142.251.10.91
Name:   youtube.com
Address: 142.251.10.93
Name:   youtube.com
Address: 2404:6800:4003:c0f::88
Name:   youtube.com
Address: 2404:6800:4003:c0f::be
Name:   youtube.com
Address: 2404:6800:4003:c0f::5b
Name:   youtube.com
Address: 2404:6800:4003:c0f::5d
```
```bash
set type=x #Query specific record type

> set type=A
> google.com

# Other examples:

> set type=MX
> gmail.com

> set type=NS
> google.com

> set type=PTR
> 8.8.8.8

> set type=SOA
> google.com

> set type=ANY
> google.com
```
```bash
set debug #Detailed query info

> set debug
> google.com

# Shows packet details, flags, TTL, etc.
# Good for troubleshooting DNS

> google.com
Server:         8.8.4.4
Address:        8.8.4.4#53

------------
    QUESTIONS:
        google.com, type = AAAA, class = IN
    ANSWERS:
    ->  google.com
        has AAAA address 2404:6800:4003:c01::66
        ttl = 298
    ->  google.com
        has AAAA address 2404:6800:4003:c01::65
        ttl = 298
    ->  google.com
        has AAAA address 2404:6800:4003:c01::71
        ttl = 298
    ->  google.com
        has AAAA address 2404:6800:4003:c01::8b
        ttl = 298
    AUTHORITY RECORDS:
    ADDITIONAL RECORDS:
------------
Non-authoritative answer:
Name:   google.com
Address: 2404:6800:4003:c01::66
Name:   google.com
Address: 2404:6800:4003:c01::65
Name:   google.com
Address: 2404:6800:4003:c01::71
Name:   google.com
Address: 2404:6800:4003:c01::8b
```
```bash
set nodebug # Disable debug

> set nodebug
```
```bash
set recurse # Enable recursive lookup

> set recurse

DNS/ server will resolve fully for you
```
```bash
> youtube.com
;; Connection to 8.8.4.4#53(8.8.4.4) for youtube.com failed: timed out.
;; no servers could be reached
Server:         8.8.4.4
Address:        8.8.4.4#53

Non-authoritative answer:
Name:   youtube.com
Address: 74.125.130.190
Name:   youtube.com
Address: 74.125.130.136
Name:   youtube.com
Address: 74.125.130.93
Name:   youtube.com
Address: 74.125.130.91
Name:   youtube.com
Address: 2404:6800:4003:c01::88
Name:   youtube.com
Address: 2404:6800:4003:c01::5d
Name:   youtube.com
Address: 2404:6800:4003:c01::be
Name:   youtube.com
Address: 2404:6800:4003:c01::5b
youtube.com     text = "facebook-domain-verification=64jdes7le4h7e7lfpi22rijygx58j1"
youtube.com     rdata_257 = 0 issue "pki.goog"
youtube.com     text = "v=spf1 include:google.com mx -all"
youtube.com     text = "google-site-verification=QtQWEwHWM8tHiJ4s-jJWzEQrD_fF3luPnpzNDH-Nw-w"
youtube.com     nameserver = ns1.google.com.
youtube.com     mail exchanger = 0 smtp.google.com.
youtube.com
        origin = ns1.google.com
        mail addr = dns-admin.google.com
        serial = 875064004
        refresh = 900
        retry = 900
        expire = 1800
        minimum = 60
youtube.com     nameserver = ns4.google.com.
youtube.com     nameserver = ns3.google.com.
youtube.com     nameserver = ns2.google.com.
youtube.com     rdata_65 = 1 .

Authoritative answers can be found from:
```
```bash
set norecurse # Disable recursion

> set norecurse
> google.com

# Useful to test authoritative-only behavior
```

```bash
#Non-interactive shortcuts (faster way)
# Instead of interactive mode, you can do:
nslookup google.com 8.8.8.8
nslookup -server=8.8.8.8 example.com

# For MX record:
nslookup -type=MX gmail.com

# For NS record:
nslookup -type=NS google.com

nslookup -type=any google.com

nslookup -type=soa redhat.com

nslookup -type=ns google.com

nslookup -type=a google.com

nslookup -type=mx google.com

nslookup -type=txt google.com

nslookup -debug mydomain.com

nslookup -debug -type=A+AAAA -nosearch -recurse mydomain.com 1.1.1.1

nslookup -query=mx example.com

nslookup -port=5353 example.com #Use non-default port

nslookup -timeout=5 example.com
nslookup -retry=3 example.com
```
```bash
# Reverse DNS Lookup

# Simple way:
nslookup 8.8.8.8

# Manual PTR query:
nslookup -type=ptr 8.8.8.8

# Advanced PTR format:
nslookup -type=ptr 8.8.8.8.in-addr.arpa
```
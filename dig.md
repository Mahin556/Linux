```bash
# Install dig (if not installed)
sudo apt install dnsutils        # Debian/Ubuntu
sudo yum install bind-utils      # RHEL/CentOS

# Basic lookup (domain → IP)
dig google.com        # Resolves domain using default DNS server

# Short output (only IP)
dig +short google.com   # Prints only IP (good for scripts)

# Specific record types
dig google.com A      # IPv4 record
dig google.com AAAA   # IPv6 record
dig google.com MX     # Mail servers
dig google.com NS     # Name servers
dig google.com TXT    # Text/SPF records
dig google.com SOA    # Authority info

# Use specific DNS server
dig google.com @8.8.8.8   # Query Google DNS directly

# Full DNS resolution path
dig google.com +trace   # Shows root → TLD → authoritative flow

# Reverse lookup (IP → domain)
dig -x 8.8.8.8     # Finds PTR record

# Show only answer section
dig google.com +noall +answer   # Clean answer only

# Show query time and stats
dig google.com +stats   # Displays query time and server info

# Remove comment lines
dig geeksforgeeks.org +nocomments   # Hides comment section

# Hide all sections
dig geeksforgeeks.org +noall     # Clears all display flags

# Show only answer section
dig geeksforgeeks.org +noall +answer   # Displays only DNS answer

# Query all record types
dig geeksforgeeks.org ANY        # Shows all available records

# Query MX record (mail servers)
dig geeksforgeeks.org MX         # Shows mail exchange records

# Show statistics (query time, server used)
dig geeksforgeeks.org +noall +answer +stats   # Answer + stats

# Clean reverse lookup output
dig +noall +answer -x 8.8.8.8    # Shows only PTR answer

# Batch query from file (one domain per line)
dig -f file.txt +short           # Queries multiple domains
```
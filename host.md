```bash
# Basic usage
host geeksforgeeks.org        # Returns IP address of domain

# Reverse lookup (IP → domain)
host 52.25.109.230            # Returns domain name of IP

# Verbose / detailed output
host -a geeksforgeeks.org     # Shows all records (verbose mode)
host -v geeksforgeeks.org     # Verbose output

# Query specific record type
host -t A geeksforgeeks.org     # IPv4 record
host -t AAAA geeksforgeeks.org  # IPv6 record
host -t NS geeksforgeeks.org    # Name servers
host -t MX geeksforgeeks.org    # Mail servers
host -t SOA geeksforgeeks.org   # Start of Authority
host -t TXT geeksforgeeks.org   # TXT records

# Compare SOA records from authoritative servers
host -C geeksforgeeks.org     # Checks SOA consistency

# Set retry attempts
host -R 3 geeksforgeeks.org   # Retry 3 times if query fails

# List all hosts in a domain (zone transfer, needs permission)
host -l geeksforgeeks.org     # Lists hosts (if allowed)

# Use specific DNS server
host geeksforgeeks.org 8.8.8.8   # Query Google DNS

# Specify query class (default is IN - Internet)
host -c IN geeksforgeeks.org   # Query Internet class

# Set timeout (wait time)
host -W 5 geeksforgeeks.org    # Wait 5 seconds for response

# Force TCP instead of UDP
host -T domain.com              # Query over TCP

# Use IPv4 transport only
host -4 domain.com              # Force IPv4 query

# Use IPv6 transport only
host -6 domain.com              # Force IPv6 query

# Disable recursion
host -r domain.com              # Query without recursion

# Wait forever for reply
host -w google.com             # No timeout
```
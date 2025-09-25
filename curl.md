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

## **1. Core Usage**

### Fetching Data

```bash
curl https://example.com/
curl https://www.geeksforgeeks.org/
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

---

## **9. References**

* [Arch man page](https://man.archlinux.org/man/curl.1.en)
* [Linux man page](https://man7.org/linux/man-pages/man1/curl.1.html)
* [Options timeline](https://curl.se/docs/optionsall.html)
* [Everything curl](https://everything.curl.dev/cmdline/help.html)
* [HTTP scripting guide](https://curl.se/docs/httpscripting.html)

---

✅ This is the **final merged, structured, no-detail-left-out `curl` reference**.

Would you like me to now turn this into a **one-page visual PDF cheat sheet** (tables + diagrams for options & use cases)?

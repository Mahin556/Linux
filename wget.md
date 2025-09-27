- Download a file and interact with REST API
- Networking command.
- It supports the HTTP,HTTPS, FTP, and FTPS internet protocols. 
- Can deal with unstable network connection, try multiple times to retrive the file and allow to resume file download if interupted.
- You can also use Wget to interact with REST APIs without having to install any additional external programs. You can make GET, POST, PUT, and DELETE HTTP requests with single and multiple headers right in the terminal.

* Download a wget
```bash
sudo apt-get install wget #ubuntu
sudo yum install wget #rhel
```

- Wget offers a wide range of command-line options to customize downloads and API interactions.


| **Flag**                    | **Purpose**                        | **Example**                                       | **Details & Use Cases**                                                                             |
| --------------------------- | ---------------------------------- | ------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| **`-P DIR`**                | Save files to a specific directory | `wget -P Downloads/ URL`                          | Saves the file into the given directory (creates it if missing). Helps keep downloads organized.    |
| **`-q`**                    | Quiet mode (minimal output)        | `wget -q URL`                                     | Suppresses all output except errors. Useful in scripts and cron jobs.                               |
| **`--show-progress`**       | Show only progress bar             | `wget -q --show-progress URL`                     | Displays a clean progress bar while hiding other logs. Great for interactive use.                   |
| **`-c`**                    | Resume interrupted download        | `wget -c URL`                                     | Continues a partially downloaded file. Essential for large files or unstable connections.           |
| **`--limit-rate=RATE`**     | Limit download speed               | `wget --limit-rate=200k URL`                      | Restricts bandwidth (e.g., `200k`, `2m`). Useful for avoiding network congestion.                   |
| **`-O FILE`**               | Save with specific filename        | `wget -O file.txt URL`                            | Stores the content with the chosen name instead of server’s filename. Handy for scripting.          |
| **`-i FILE`**               | Download URLs from a file          | `wget -i list.txt`                                | Reads multiple URLs from a file and downloads them. Perfect for batch jobs.                         |
| **`-b`**                    | Run in background                  | `wget -b URL`                                     | Starts the download in background, logs to `wget-log`. Lets you keep using the terminal.            |
| **`--tries=N`**             | Retry N times                      | `wget --tries=3 URL`                              | Retries a failed download N times. Useful on flaky connections.                                     |
| **`-T SECONDS`**            | Set timeout                        | `wget -T 5 URL`                                   | Aborts if server doesn’t respond within given seconds. Prevents hanging forever.                    |
| **`--header=STRING`**       | Add HTTP request header            | `wget --header="Authorization: Bearer TOKEN" URL` | Attach custom headers (auth tokens, API keys, etc.). Supports multiple headers.                     |
| **`--method=METHOD`**       | Use custom HTTP method             | `wget --method=POST URL`                          | Override default `GET` method. Combine with `--body-data` and `--header` for API calls.             |
| **`--body-data=STRING`**    | Send request body (for APIs)       | `wget --method=POST --body-data="key=value" URL`  | Sends inline data in request body. Useful for POST/PUT API interactions.                            |
| **`--mirror`**              | Mirror entire site                 | `wget --mirror URL`                               | Recursively downloads a site for offline viewing. Preserves structure.                              |
| **`-r`**                    | Recursive download                 | `wget -r URL`                                     | Fetch linked files/pages recursively. Use with care to avoid crawling entire sites unintentionally. |
| **`-np`**                   | No parent directories              | `wget -r -np URL`                                 | Prevents ascending to parent directories during recursion. Keeps scope limited.                     |
| **`--user` / `--password`** | Basic auth                         | `wget --user=admin --password=secret URL`         | Supplies credentials for protected resources. Combine with HTTPS for security.                      |

---

**Pro Tips**:

* Combine `-c` with `--limit-rate` for resuming big downloads without choking bandwidth.
* For scripting APIs, use `--method`, `--header`, and `--body-data` together.
* Use `-q` + `--show-progress` in automation for clean logs.

### Issues while using `wget`
- Download failure
- Authentication error

* Comman issues and then fixes
| **Symptom / Error**                               | **Likely Cause**                                                  | **Fix (Exact Command / Tactic)**                                                                                                                                                         |
| ------------------------------------------------- | ----------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Files saved as `name.ext.1`, `.2`, …**          | File with same name already exists in target directory            | Overwrite explicitly: `wget -O name.ext URL`  <br>Or save to another directory: `wget -P Downloads/ URL`                                                                                 |
| **Download restarts from 0%**                     | Missing resume flag OR server doesn’t support HTTP range requests | Resume with: `wget -c URL` <br>If server lacks support → re-download fully OR use curl: `curl -C - -o name.ext URL`                                                                      |
| **Very slow / unstable transfer**                 | Bandwidth contention, server throttling, flaky link               | Predictable throttling: `wget --limit-rate=200k URL` <br>Increase robustness: `wget --tries=10 -T 10 -c URL` <br>Consider scheduling during off-peak hours                               |
| **`wget: command not found`**                     | Wget not installed                                                | Install: <br>Debian/Ubuntu → `sudo apt-get install -y wget` <br>RHEL/CentOS → `sudo yum install -y wget`                                                                                 |
| **403 Forbidden / 404 Not Found**                 | Wrong URL, missing headers, expired signed link                   | Add headers: `wget --header="Authorization: Bearer $TOKEN" URL` <br>Check API scope or link validity                                                                                     |
| **401 Unauthorized (API calls)**                  | Invalid token, missing scope, or wrong header format              | Correct usage: `wget --header="Authorization: Bearer $TOKEN" URL` <br>Re-issue token with proper scopes                                                                                  |
| **SSL connect error / certificate verify failed** | Missing CA certs, system clock skew, proxy MITM                   | Sync time: `sudo timedatectl set-ntp true` <br>Update certs: `sudo update-ca-certificates` <br>If behind corporate proxy → import proxy CA and use `--ca-certificate=/path/proxy-ca.crt` |
| **Stuck waiting for response**                    | Server is hanging or connection stalled                           | Use timeout: `wget -T 5 URL` <br>Retry: `wget --tries=5 URL`                                                                                                                             |
| **Partial HTML saved instead of file**            | Got a login page, redirect, or error HTML                         | Debug headers: `wget -S --spider URL` <br>Follow redirects (default) or add missing headers/cookies                                                                                      |
| **API JSON mixed with logs**                      | Progress info printed to stderr                                   | Clean output: `wget -qO- URL` or `wget -q -O - URL` → prints only payload                                                                                                                |



### Downloading a files

* Download a single file and multiple files
* Handle downloads in unstable network conditions
* Resume a download after interruption
* Save downloads into specific directories
* Limit speed, overwrite files, or run in background

If you’re evaluating `curl` for similar tasks, see the companion guide: **Workflow: Downloading Files with curl**.

---

#### 1. Preparing Directories

First, create a directory to save the files you will download throughout this tutorial:

```bash
mkdir -p DigitalOcean-Wget-Tutorial/Downloads
```

This creates:

* A directory named **DigitalOcean-Wget-Tutorial**
* Inside it, a **Downloads** subdirectory

Now, navigate into it:

```bash
cd DigitalOcean-Wget-Tutorial
```

You are now inside the workspace where you’ll store all your downloads.

---

#### 2. Downloading a File

Download a file using **Wget** by typing `wget` followed by the URL:

```bash
wget https://code.jquery.com/jquery-3.6.0.min.js
```

Example output:

```
--2021-07-21 16:25:11--  https://code.jquery.com/jquery-3.6.0.min.js
Resolving code.jquery.com (code.jquery.com)... 69.16.175.10, 69.16.175.42, ...
Connecting to code.jquery.com (code.jquery.com)|69.16.175.10|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 89501 (87K) [application/javascript]
Saving to: ‘jquery-3.6.0.min.js’

jquery-3.6.0.min.js 100%[===================>]  87.40K   114KB/s    in 0.8s    

2021-07-21 16:25:13 (114 KB/s) - ‘jquery-3.6.0.min.js’ saved [89501/89501]
```

Check the directory contents:

```bash
ls
```

Output:

```
Downloads  jquery-3.6.0.min.js  jquery.min.js
```

---

#### 3. Downloading to a Specific Directory

By default, files go into the **current directory**. Use `-P` to choose a target directory:

```bash
wget -P Downloads/ https://code.jquery.com/jquery-3.6.0.min.js
```

Example output:

```
Saving to: ‘Downloads/jquery-3.6.0.min.js’
```

Verify inside `Downloads`:

```bash
ls Downloads
```

Output:

```
jquery-3.6.0.min.js
```

---

#### 4. Turning Wget’s Output Off

Wget normally prints detailed logs. Use `-q` to silence output:

```bash
wget -q https://code.jquery.com/jquery-3.6.0.min.js
```

Check:

```bash
ls
```

Output:

```
Downloads  jquery-3.6.0.min.js  jquery-3.6.0.min.js.1  jquery.min.js
```

⚠️ Note: If file exists, Wget creates `filename.1`, `filename.2`, etc.

---

#### 5. Showing Only a Progress Bar

Combine `-q` with `--show-progress` for a clean progress bar:

```bash
wget -q --show-progress https://code.jquery.com/jquery-3.6.0.min.js
```

Example output:

```
jquery-3.6.0.min.js.2         100%[================================================>]  87.40K   207KB/s    in 0.4s
```

---

#### 6. Downloading Multiple Files
- In order to download multiples files using Wget, you need to create a .txt file and insert the URLs of the files you wish to download. After inserting the URLs inside the file, use the wget command with the -i option followed by the name of the .txt file containing the URLs.

1. Create a file `images.txt` with URLs:

```bash
nano images.txt
```

Paste:

```
https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313__340.jpg
https://cdn.pixabay.com/photo/2016/01/05/17/51/maltese-1123016__340.jpg
https://cdn.pixabay.com/photo/2020/06/30/22/34/dog-5357794__340.jpg
```

2. Download them all:

```bash
wget -i images.txt -P Downloads/ -q --show-progress
```

Example output:

```
puppy-1903313__340.jpg   100%[=================>] 26.44K  93.0KB/s in 0.3s
maltese-1123016__340.jpg 100%[=================>] 50.81K  --.-KB/s in 0.06s
dog-5357794__340.jpg     100%[=================>] 30.59K  --.-KB/s in 0.07s
```

Check:

```bash
ls Downloads
```

Output:

```
dog-5357794__340.jpg  jquery-3.6.0.min.js  maltese-1123016__340.jpg  puppy-1903313__340.jpg
```

---

#### 7. Limiting Download Speed

Throttle speed with `--limit-rate`:

```bash
wget --limit-rate=15k -P Downloads/ -q --show-progress https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313__340.jpg
```

Output:

```
puppy-1903313__340.jpg.1 100%[====================================>] 26.44K 16.1KB/s in 1.6s
```

---

#### 8. Overwriting a Downloaded File

Use `-O` to force a specific filename:

```bash
wget -O image2.jpg -q --show-progress https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313__340.jpg
```

Output:

```
image2.jpg 100%[====================================>] 26.44K --.-KB/s in 0.04s
```

Running the same command again **overwrites** the file.

---

#### 9. Resuming a Download

Simulate interruption with **Ctrl+C** after starting:

```bash
wget --limit-rate=1k -q --show-progress https://cdn.pixabay.com/photo/2018/03/07/19/51/grass-3206938__340.jpg
```

Then resume with `-c`:

```bash
wget -c --limit-rate=1k -q --show-progress https://cdn.pixabay.com/photo/2018/03/07/19/51/grass-3206938__340.jpg
```

---

#### 10. Downloading in the Background

Run in background with `-b`:

```bash
wget -b https://cdn.pixabay.com/photo/2018/03/07/19/51/grass-3206938__340.jpg
```

Check progress in log:

```bash
tail -f wget-log
```

Output example:

```
Saving to: ‘grass-3206938__340.jpg’
0K .......... .......... .......... .. 100% 338K=0.1s
‘grass-3206938__340.jpg’ saved [33520/33520]
```

---

#### 11. Setting a Timeout

Limit server response wait with `-T`:

```bash
wget -T 5 -q --show-progress https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313__340.jpg
```

---

#### 12. Setting Maximum Number of Tries

Limit retries with `--tries=N`:

```bash
wget --tries=3 -q --show-progress https://cdn.pixabay.com/photo/2018/03/07/19/51/grass-3206938__340.jpg
```

Retry forever with `inf`:

```bash
wget --tries=inf -q --show-progress https://cdn.pixabay.com/photo/2018/03/07/19/51/grass-3206938__340.jpg
```

---

Perfect 👍 Let’s expand this into a **detailed, full comparison guide** of **Wget vs Curl for API workflows** — including **context, reasoning, examples, and option explanations**.

---

### 📘 Wget vs Curl for API Workflows — Detailed Guide

When working with APIs or downloads, both **Wget** and **Curl** are powerful tools, but they serve different purposes. Choosing the right one depends on whether you need **robust downloading** or **fine-grained HTTP control**.

---

#### 🟢 General Philosophy

* **Wget**:

  * Built for **retrieving files from the web**.
  * Excels at **resilient downloading** (resume, retries, mirroring, backgrounding).
  * Limited flexibility with **API-specific workflows**, but can still handle simple JSON GET/POST requests.

* **Curl**:

  * Built for **talking to URLs** with full **HTTP protocol control**.
  * Excels at **complex APIs** (authentication flows, multipart uploads, custom TLS, HTTP/2).
  * Doesn’t provide built-in mirroring or background downloads like Wget.

---

#### 📊 Task-by-Task Comparison

| **Task**                                                                     | **Prefer Wget**                                                                                                                                                | **Prefer Curl**                                                                                                                          |
| ---------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **Large/batch downloads** (resume, backgrounding)                            | ✅ `wget -c -b URL` <br> `-c` → continue/resume <br> `-b` → background mode <br> `--tries=N` → retry count                                                      | Possible with `curl -C - -O URL` (resume) but less ergonomic for multiple files.                                                         |
| **Simple JSON GET/POST with headers**                                        | ✅ `wget -qO- --header="Authorization: Bearer $TOKEN" --method=post URL` <br> `-q` → quiet <br> `-O-` → send output to stdout <br> `--method` → set HTTP method | ✅ `curl -s -H "Authorization: Bearer $TOKEN" -X POST URL` <br> `-s` → silent <br> `-H` → add header <br> `-X` → method                   |
| **Complex APIs** (OAuth device flow, mTLS, multipart forms, HTTP/2, proxies) | ❌ Limited                                                                                                                                                      | ✅ Rich flags: <br> `--http2` → use HTTP/2 <br> `--form` → multipart form <br> `--cacert` → custom CA cert <br> `--proxy` → proxy support |
| **Retry/backoff resilience**                                                 | ✅ Built-in retry & resume: <br> `--tries=10 -T 5 -c`                                                                                                           | ⚠️ Available but manual: <br> `--retry 5 --retry-delay 2 --retry-max-time 30`                                                            |
| **Website mirroring**                                                        | ✅ `wget -r -np -k URL` <br> `-r` → recursive <br> `-np` → no parent dirs <br> `-k` → convert links for offline use                                             | ❌ Not designed for this                                                                                                                  |
| **Fine control over request/response**                                       | Basic only: `--header`, `--method`, `--body-data`                                                                                                              | ✅ Full: custom headers, JSON/XML bodies, streaming responses, content negotiation                                                        |

---

#### ⚖️ Rule of Thumb

* If your script looks like:
  **“download 100 files and retry until successful”** → use **Wget**.
* If your script looks like:
  **“call an API endpoint with tokens, JSON payloads, and TLS settings”** → use **Curl**.
* 👉 You can **mix both** in workflows:

  * Use `curl` to **get an access token**.
  * Use `wget` to **bulk download files with that token**.

---

#### ✅ Example Workflows

##### 1. Robust File Download (Wget is better)

```bash
wget -c --tries=10 -P Downloads/ https://example.com/bigfile.zip
```

* `-c` → resume partial downloads.
* `--tries=10` → retry 10 times.
* `-P Downloads/` → save to Downloads folder.

---

##### 2. Simple API GET with Authorization (Both work)

**Using Wget:**

```bash
wget -qO- --header="Authorization: Bearer $TOKEN" https://api.example.com/data
```

* `-q` → quiet (no logs).
* `-O-` → print to stdout.
* `--header` → add auth header.

**Using Curl:**

```bash
curl -s -H "Authorization: Bearer $TOKEN" https://api.example.com/data
```

* `-s` → silent mode.
* `-H` → add header.

---

##### 3. Complex API POST with JSON (Curl is better)

```bash
curl -s -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name":"test","enabled":true}' \
  https://api.example.com/resources
```

* `-X POST` → set method.
* `-H` → headers (auth + JSON type).
* `-d` → data payload.

---

##### 4. Website Mirroring (Only Wget)

```bash
wget -r -np -k https://example.com/
```

* `-r` → recursive.
* `-np` → don’t go up to parent dirs.
* `-k` → convert links for offline browsing.

---

##### 5. Retry with Timeout (Both possible)

**Wget (built-in resilience):**

```bash
wget -T 5 --tries=3 -c https://example.com/file.zip
```

* `-T 5` → 5-second timeout.
* `--tries=3` → 3 attempts.
* `-c` → continue partial.

**Curl (manual retries):**

```bash
curl --retry 3 --retry-delay 5 --retry-max-time 20 -O https://example.com/file.zip
```

* `--retry 3` → retry 3 times.
* `--retry-delay 5` → wait 5s between retries.
* `--retry-max-time 20` → max retry time 20s.

---

#### 📝 Performance Tips

* **Wget**:

  * Add `-q --show-progress` for clean logs.
  * Always use `-c` for large assets.
  * For CI/CD, pin `wget --version` in logs for reproducibility.

* **Curl**:

  * Use `-sS` (silent but show errors).
  * For JSON APIs, pair with `jq` for parsing:

    ```bash
    curl -s https://api.example.com/data | jq .
    ```
  * Use `--compressed` for Gzip/Brotli support.

---

#### 🔑 Summary

* **Wget excels** at:

  * ✅ Large, resilient downloads
  * ✅ Recursive mirroring
  * ✅ Background tasks with retries

* **Curl excels** at:

  * ✅ Complex API workflows
  * ✅ Authentication and encryption
  * ✅ Multipart uploads and advanced HTTP features

👉 Use them together when workflows need **both reliable downloads and complex API interactions**.


Here’s a **detailed, expanded version** of your section on **Interacting with REST APIs using Wget**, including explanations of the options, command breakdowns, and best practices.

---

### Interacting with REST APIs Using Wget

Wget is not only a powerful downloader but can also be used to interact with REST APIs without installing additional tools like `curl` or HTTP clients. With Wget’s support for custom HTTP methods, headers, and request bodies, you can send **GET**, **POST**, **PUT**, and **DELETE** requests directly from your shell.

This section provides **ready-to-use API recipes** for common workflows, explains the flags used, and highlights best practices for security and reliability.

---

#### Export Tokens Safely (Recommended Practice)

Instead of pasting API tokens into commands (which may get saved in shell history or CI/CD logs), export them once per session as environment variables:

```bash
export DO_TOKEN="paste-your-token-here"
```

This way, you can inject them into headers like:

```bash
--header="Authorization: Bearer $DO_TOKEN"
```

---

#### API Copy-Paste Recipes (Common Methods)

##### 1. GET Request (Fetch JSON, with query parameters)

```bash
wget -qO- \
  --header="Accept: application/json" \
  "https://jsonplaceholder.typicode.com/posts?_limit=2"
```

✅ **Explanation of options**

* `-q` → Quiet mode (no progress bar or noise).
* `-O-` → Write output to stdout (so response prints in terminal instead of saving as a file).
* `--header="Accept: application/json"` → Tells the API we want JSON.
* URL with `?_limit=2` → Adds query parameters.

---

##### 2. POST Request (Send JSON Body)

```bash
wget -qO- \
  --method=post \
  --header="Content-Type: application/json" \
  --header="Accept: application/json" \
  --body-data '{"title":"Wget POST","body":"Example body","userId":1}' \
  https://jsonplaceholder.typicode.com/posts
```

✅ **Explanation of options**

* `--method=post` → Explicitly sets HTTP POST.
* `--body-data` → Inline JSON payload to send in request body.
* `--header="Content-Type: application/json"` → Required so server interprets body correctly.
* `--header="Accept: application/json"` → Ensures response is JSON.

---

##### 3. PUT Request (Update/Replace Resource)

```bash
wget -qO- \
  --method=put \
  --header="Content-Type: application/json" \
  --header="Accept: application/json" \
  --body-data '{"title":"Updated","body":"Updated body","userId":1,"id":1}' \
  https://jsonplaceholder.typicode.com/posts/1
```

✅ **Explanation of options**

* `--method=put` → Tells Wget to use HTTP PUT.
* `--body-data` → Sends new representation of resource.
* Same headers as POST.
* Endpoint ends in `/1` → Updates resource ID `1`.

---

##### 4. DELETE Request (Remove Resource)

```bash
wget -qO- \
  --method=delete \
  --header="Accept: application/json" \
  https://jsonplaceholder.typicode.com/posts/1
```

✅ **Explanation of options**

* `--method=delete` → Sends HTTP DELETE.
* `--header="Accept: application/json"` → Ensures clean JSON response.

---

##### 5. Multiple Headers Example (General Pattern)

```bash
wget -qO- \
  --header="Authorization: Bearer $DO_TOKEN" \
  --header="Content-Type: application/json" \
  URL_HERE
```

✅ **Why**: Many APIs require multiple headers like authentication tokens, API versioning, or special content negotiation. You can chain multiple `--header` flags.

---

##### 6. Resilient API Calls Over Flaky Networks

```bash
wget -qO- -c --tries=8 -T 10 \
  --method=post \
  --header="Authorization: Bearer $DO_TOKEN" \
  --header="Content-Type: application/json" \
  --body-data '{"ping":"pong"}' \
  https://api.example.com/v1/endpoint
```

✅ **Explanation of extra options**

* `-c` → Resume partial downloads (useful if response is large).
* `--tries=8` → Retry up to 8 times.
* `-T 10` → Set 10-second timeout for each attempt.
* Combined with POST body + headers for resilience.

---

#### Opinionated Defaults for CI/CD and Reliability

* **Use `-qO-` in CI/CD** → Prints only response body (keeps logs clean).

  * For error logs: redirect stderr → `2>>build.log`.

* **Pair `--tries` with `-T`**

  * Retries **without timeouts** → build may hang forever.
  * Timeouts **without retries** → flaky under transient loss.

* **Use `$DO_TOKEN` (env var)** instead of hardcoding tokens inline.

  * Prevents accidental exposure in `bash_history` or pipeline logs.

* **For large files/artifacts**

  * Always add `-c` (resume).
  * Keeps CI stable over unstable connections.

* **Record tool version for reproducibility**

```bash
wget --version
```

---

#### Quick Reference: Key Wget Options for APIs

| Option                  | Purpose                                               |
| ----------------------- | ----------------------------------------------------- |
| `-q`                    | Quiet (minimal logs, suppress progress bar)           |
| `-O-`                   | Print response to stdout (instead of saving file)     |
| `--method=METHOD`       | Specify HTTP method (GET, POST, PUT, DELETE, PATCH)   |
| `--header="Key: Value"` | Send custom HTTP headers (auth, content-type, etc.)   |
| `--body-data="JSON"`    | Send raw request body (inline)                        |
| `--body-file=file.json` | Send request body from a file                         |
| `-c`                    | Resume partial transfers (useful for large responses) |
| `--tries=N`             | Retry failed requests N times                         |
| `-T SECS`               | Timeout after SECS seconds                            |
| `--spider`              | Check if URL is accessible (no download)              |

---

✅ **Rule of Thumb**:

* Use Wget for **robust downloads** and **basic API calls**.
* Use Curl for **complex APIs** (OAuth flows, multipart uploads, HTTP/2).

---

### Working Behind Proxies, Custom User-Agents, and Cookies

Many real-world environments require Wget to operate through corporate proxies, authenticate via login forms, or present itself as a specific client (via User-Agent headers). Wget provides built-in options to handle all of these scenarios.

---

#### 1. Working Behind Proxies

In corporate or university networks, all outbound HTTP/HTTPS traffic may need to go through a proxy. Wget respects standard environment variables for proxy configuration.

##### Example (HTTP/HTTPS Proxy)

```bash
export http_proxy="http://proxy.corp:3128"
export https_proxy="http://proxy.corp:3128"

wget -qO- https://example.com/status
```

✅ **Explanation**:

* `http_proxy` → Defines proxy for HTTP requests.
* `https_proxy` → Defines proxy for HTTPS requests.
* `-qO-` → Quiet + write response body to stdout.

🔹 **Tip**: For SOCKS proxies (e.g., via SSH tunnels), you can use:

```bash
export all_proxy="socks5://127.0.0.1:1080"
```

🔹 **Bypass proxy for local hosts**:

```bash
export no_proxy="localhost,127.0.0.1,.internal.example.com"
```

---

#### 2. Custom User-Agents

Some servers reject requests from "generic" clients, or tailor responses depending on the **User-Agent** string. By default, Wget identifies as something like:

```
User-Agent: Wget/1.21.2 (linux-gnu)
```

You can override this with `--user-agent`.

##### Example (Custom UA)

```bash
wget -qO- \
  --user-agent="WgetTutorial/1.0 (+https://yourdomain.example)" \
  https://api.example.com/status
```

✅ **Why this matters**:

* API endpoints may only allow browsers or specific clients.
* For scraping, a realistic UA (e.g., Chrome, Firefox) may prevent blocking.

---

#### 3. Cookies: Persisting and Reusing Sessions

When interacting with authenticated web apps, APIs, or forms, Wget can **store cookies** from one request and **reuse them** in subsequent requests.

##### Step 1: Save cookies during login

```bash
wget \
  --save-cookies cookies.txt \
  --keep-session-cookies \
  https://site.example.com/login
```

✅ **Explanation**:

* `--save-cookies cookies.txt` → Store cookies in a file.
* `--keep-session-cookies` → Keeps cookies that normally expire at session end.

---

##### Step 2: Reuse cookies for subsequent requests

```bash
wget \
  --load-cookies cookies.txt \
  -O report.csv \
  "https://site.example.com/reports?id=123"
```

✅ **Explanation**:

* `--load-cookies cookies.txt` → Reuse cookies from earlier login.
* `-O report.csv` → Save output as `report.csv`.

---

#### 4. Logging in via POST (Form Authentication)

Many login endpoints expect form fields via POST. In that case, combine cookies with `--method=post` and `--body-data` or `--post-data`.

##### Example (Form POST with cookies)

```bash
wget \
  --save-cookies cookies.txt \
  --keep-session-cookies \
  --method=post \
  --header="Content-Type: application/x-www-form-urlencoded" \
  --body-data="username=user&password=secret" \
  https://site.example.com/login
```

Then reuse the cookie for subsequent authenticated requests.

---

#### 5. Security Notes

* **Do not hardcode passwords/tokens** → Prefer environment variables or files excluded from logs (`.env`).
* **Cookie files** may contain sensitive session data. Treat them like credentials.
* **Proxies** can see all HTTP traffic. For HTTPS, they may intercept with custom CAs. Always verify `--ca-certificate` if using a corporate proxy.

---

#### Quick Reference: Options Covered

| Option / Variable           | Purpose                                       |
| --------------------------- | --------------------------------------------- |
| `http_proxy`, `https_proxy` | Define proxy servers for HTTP/HTTPS           |
| `all_proxy`                 | Define proxy for all protocols (e.g., SOCKS5) |
| `no_proxy`                  | Exclude hosts from proxy                      |
| `--user-agent=STRING`       | Override default User-Agent                   |
| `--save-cookies=FILE`       | Save cookies to a file                        |
| `--keep-session-cookies`    | Preserve session cookies (default expire)     |
| `--load-cookies=FILE`       | Reuse cookies from a file                     |
| `--method=METHOD`           | Explicitly set HTTP method (GET, POST, etc.)  |
| `--body-data=STRING`        | Inline request body                           |
| `--post-data=STRING`        | Alias for form-encoded POST body              |

---

Got it ✅ — let’s build this section into a **complete, detailed tutorial** that ties together **saving JSON responses, pretty-printing with `jq`, and using Wget for GET, POST, PUT, DELETE requests** with the JSONPlaceholder API.

---

### 📌 Saving and Pretty-Printing JSON Responses (with `jq`)

When working with REST APIs, responses are usually returned in **JSON**. Wget can fetch the JSON, but to make it human-readable or extract fields, you need a tool like [`jq`](https://stedolan.github.io/jq/).

---

#### 1. Install `jq`

##### Debian/Ubuntu:

```bash
sudo apt-get update && sudo apt-get install -y jq
```

##### RHEL/CentOS:

```bash
sudo yum install -y jq
```

---

#### 2. Save and Pretty-Print a JSON Response

##### Step 1: Save API response with Wget

```bash
wget -qO response.json --header="Accept: application/json" \
  "https://jsonplaceholder.typicode.com/posts?_limit=2"
```

* `-q` → quiet (hide progress and logs).
* `-O response.json` → save as `response.json`.
* `--header="Accept: application/json"` → explicitly request JSON.

---

##### Step 2: Pretty-print JSON

```bash
jq . response.json
```

✅ Output will be a clean, indented JSON structure.

---

##### Step 3: Extract specific fields

```bash
jq -r '.[0].id' response.json
```

This prints only the `id` of the first element. Useful for **scripting and pipelines**.

---

📖 **Note:**
We are using **[JSONPlaceholder](https://jsonplaceholder.typicode.com/)**, a free fake REST API for testing. It doesn’t affect real databases.

---

### 🚀 Sending API Requests with Wget

Now, let’s see how to send the four main HTTP methods: **GET, POST, PUT, DELETE**.

---

#### 1. Sending GET Requests

GET is the **default method** in Wget.

```bash
wget -O- https://jsonplaceholder.typicode.com/posts?_limit=2
```

* `-O-` → send output to **stdout** (the terminal).
* No `--method` needed (default = GET).

✅ Sample Output:

```json
[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat...",
    "body": "quia et suscipit..."
  },
  {
    "userId": 1,
    "id": 2,
    "title": "qui est esse",
    "body": "est rerum tempore..."
  }
]
```

👉 To reduce noise (skip `Resolving...` lines), add `-q`:

```bash
wget -O- -q https://jsonplaceholder.typicode.com/posts?_limit=2
```

---

#### 2. Sending POST Requests

POST is used to **create new resources**.

```bash
wget --method=post -O- -q \
  --body-data='{"title":"Wget POST","body":"Wget POST example body","userId":1}' \
  --header=Content-Type:application/json \
  https://jsonplaceholder.typicode.com/posts
```

* `--method=post` → explicitly use POST.
* `--body-data=...` → request body (JSON format).
* `--header=Content-Type:application/json` → declare JSON content.
* `-O- -q` → quiet mode, print only JSON.

✅ Sample Output:

```json
{
  "title": "Wget POST",
  "body": "Wget POST example body",
  "userId": 1,
  "id": 101
}
```

---

#### 3. Sending PUT Requests

PUT is used to **replace/update an existing resource**.

```bash
wget --method=put -O- -q \
  --body-data='{"title":"Wget PUT","body":"Wget PUT example body","userId":1,"id":1}' \
  --header=Content-Type:application/json \
  https://jsonplaceholder.typicode.com/posts/1
```

✅ Sample Output:

```json
{
  "body": "Wget PUT example body",
  "title": "Wget PUT",
  "userId": 1,
  "id": 1
}
```

---

#### 4. Sending DELETE Requests

DELETE is used to **remove a resource**.

```bash
wget --method=delete -O- -q \
  --header=Content-Type:application/json \
  https://jsonplaceholder.typicode.com/posts/1
```

✅ Sample Output:

```json
{}
```

---

### ⚡ Key Options Recap

| Option               | Purpose                                      |
| -------------------- | -------------------------------------------- |
| `-O FILE`            | Save output to a file                        |
| `-O-`                | Print output to stdout                       |
| `-q`                 | Quiet mode (suppress logs)                   |
| `--method=METHOD`    | Specify HTTP method (GET, POST, PUT, DELETE) |
| `--body-data=STRING` | Inline JSON request body                     |
| `--header=STRING`    | Add custom HTTP headers                      |

---

### ✅ Best Practices

* Use `-qO-` in CI/CD to keep logs clean.
* Always set `--header="Content-Type: application/json"` when sending JSON.
* Use `jq` to filter or extract values in pipelines.
* Save responses with `-O file.json` when debugging.


---

Here’s a **complete, detailed guide** on creating and managing a DigitalOcean Droplet using Wget, including multiple headers and all the relevant options:

---

### 🌐 Creating and Managing a DigitalOcean Droplet with Wget

In this section, you will apply your knowledge of Wget and REST APIs to **create, list, and delete a DigitalOcean Droplet**. A key concept here is sending **multiple HTTP headers** in a single request.

---

#### 1. Sending Multiple Headers in Wget

Wget allows you to include as many headers as needed using repeated `--header` options.

**Syntax:**

```bash
wget --header="First-Header: value" \
     --header="Second-Header: value" \
     --header="Nth-Header: value" \
     URL
```

* Each `--header` adds an HTTP header to your request.
* Multiple headers are essential when interacting with authenticated APIs like DigitalOcean.

---

#### 2. Export Your DigitalOcean Token

It’s safer to **store your Personal Access Token in an environment variable** than to paste it in commands (avoids shell history leaks):

```bash
export DO_TOKEN="paste-your-token-here"
```

---

#### 3. Create a Droplet

Use a POST request with JSON data to create a new Droplet.

```bash
wget --method=post -qO- \
  --header="Content-Type: application/json" \
  --header="Authorization: Bearer $DO_TOKEN" \
  --body-data='{
    "name":"Wget-example",
    "region":"nyc1",
    "size":"s-1vcpu-1gb",
    "image":"ubuntu-24-04-x64",
    "tags":["Wget-tutorial"]
  }' \
  https://api.digitalocean.com/v2/droplets
```

**Explanation of options:**

| Option                                       | Purpose                                     |
| -------------------------------------------- | ------------------------------------------- |
| `--method=post`                              | Use POST HTTP method to create a resource   |
| `-qO-`                                       | Quiet mode + output response to stdout      |
| `--header="Content-Type: application/json"`  | Tells API you are sending JSON              |
| `--header="Authorization: Bearer $DO_TOKEN"` | Authenticates your request using your token |
| `--body-data='{}'`                           | JSON body containing Droplet details        |
| `https://api.digitalocean.com/v2/droplets`   | DigitalOcean endpoint to create a Droplet   |

✅ Sample Output:

```json
{"droplet":{"id":237171073,"name":"Wget-example","memory":1024,"vcpus":1,"disk":25,"status":"new","tags":["Wget-tutorial"]}, "links":{"actions":[{"id":1164336542,"rel":"create"}]}}
```

---

#### 4. List Droplets by Tag

To list all Droplets with a specific tag (e.g., `Wget-tutorial`):

```bash
wget -qO- \
  --header="Content-Type: application/json" \
  --header="Authorization: Bearer $DO_TOKEN" \
  "https://api.digitalocean.com/v2/droplets?tag_name=Wget-tutorial"
```

✅ Sample Output:

```json
{
  "droplets":[
    {
      "id":237171073,
      "name":"Wget-example",
      "memory":1024,
      "vcpus":1,
      "disk":25,
      "status":"active",
      "tags":["Wget-tutorial"]
    }
  ]
}
```

* The `tag_name` query parameter filters droplets by tag.
* You can use `jq` to parse this output if needed:

```bash
wget -qO- --header="Authorization: Bearer $DO_TOKEN" "https://api.digitalocean.com/v2/droplets?tag_name=Wget-tutorial" | jq '.droplets[].id'
```

---

#### 5. Delete a Droplet

Use the Droplet `id` to delete it:

```bash
wget --method=delete -qO- \
  --header="Content-Type: application/json" \
  --header="Authorization: Bearer $DO_TOKEN" \
  "https://api.digitalocean.com/v2/droplets/your_droplet_id"
```

* Replace `your_droplet_id` with the actual ID of the Droplet.
* If successful, the API returns **HTTP 204 No Content**.

---

#### 6. Summary of Key Points

* **Multiple headers** are sent with repeated `--header` options.
* Use **POST** to create a Droplet and **DELETE** to remove it.
* Use `-qO-` to suppress verbose output and print only the JSON response.
* Environment variables (like `$DO_TOKEN`) are safer than pasting secrets in commands.
* You can **filter and manage Droplets** using tags and query parameters.

---

This completes a **full workflow for managing DigitalOcean Droplets** with Wget.

It demonstrates **secure authentication, multiple headers, JSON body payloads, listing, and deletion** in a simple, reproducible Wget-based workflow.

---

Here’s a **detailed, structured guide** for the **Website Downloader MCP Server using wget**, incorporating everything from installation to advanced mirroring options:

---

### 🌐 Website Downloader MCP Server (Advanced wget‑Based Website Mirroring)

The **Website Downloader MCP Server** wraps `wget` to create high-fidelity offline mirrors of websites. It **preserves structure, rewrites links**, and confines downloads to specified domains—ideal for **offline documentation, audits, education, or disaster recovery playbooks**.

**GitHub:** [Website Downloader](https://github.com/pskill9/website-downloader)

---

#### 1. MCP Server Requirements

* **wget** installed
* **Node.js (LTS)** and **npm** to run the MCP server
* Sufficient disk space for the mirrored site (mirrors can grow large)

##### Installing wget Quickly

| Platform      | Command                                                   |
| ------------- | --------------------------------------------------------- |
| macOS         | `brew install wget`                                       |
| Debian/Ubuntu | `sudo apt-get update && sudo apt-get install -y wget`     |
| Fedora/RHEL   | `sudo dnf install -y wget`                                |
| Windows       | `choco install wget` (or standalone binary added to PATH) |

---

#### 2. MCP Server Installation & Setup

```bash
# Clone repository
git clone https://github.com/pskill9/website-downloader.git
cd website-downloader

# Install dependencies & build
npm install
npm run build
```

##### Example MCP Client Configuration

```json
{
  "mcpServers": {
    "website-downloader": {
      "command": "node",
      "args": ["/absolute/path/to/website-downloader/build/index.js"]
    }
  }
}
```

---

#### 3. Tool: `download_website` Parameters

| Parameter       | Type    | Description                                                                                                              |
| --------------- | ------- | ------------------------------------------------------------------------------------------------------------------------ |
| `url`           | string  | Root URL to mirror (required)                                                                                            |
| `outputPath`    | string  | Local folder to save mirror (optional; default: current directory)                                                       |
| `depth`         | integer | Maximum recursion depth for following links: 0=only root page, 1=root+direct links, 2=root+direct+next-level links, etc. |
| `extraWgetArgs` | array   | Advanced `wget` flags for rate limiting, headers, authentication, etc. (optional)                                        |

---

#### 4. Quick Start: Shallow Mirror

**Request Payload Example:**

```json
{
  "url": "https://example.com",
  "outputPath": "/path/to/output",
  "depth": 1
}
```

**Equivalent wget Command:**

```bash
wget \
  --recursive \
  --level 1 \
  --page-requisites \
  --convert-links \
  --adjust-extension \
  --no-parent \
  --domains example.com \
  --directory-prefix "/path/to/output" \
  https://example.com
```

---

#### 5. Common wget Flags for Mirroring

| Flag                     | Purpose                                                         |
| ------------------------ | --------------------------------------------------------------- |
| `-r` / `--recursive`     | Follow links and download linked pages/resources                |
| `-l <depth>` / `--level` | Maximum recursion depth                                         |
| `--page-requisites`      | Download all assets (images, CSS, JS) for proper page rendering |
| `--convert-links`        | Rewrite HTML links to local copies                              |
| `--adjust-extension`     | Ensure file extensions match content type (e.g., `.html`)       |
| `--no-parent`            | Prevent ascending to parent directories                         |
| `--domains <list>`       | Restrict downloads to specific domain(s)                        |

---

#### 6. Polite Full-Site Mirror (Rate Limiting)

**Payload Example (if `extraWgetArgs` is supported):**

```json
{
  "url": "https://docs.example.org",
  "outputPath": "/srv/mirrors/docs-example",
  "depth": 5,
  "extraWgetArgs": ["--wait=1", "--random-wait", "--limit-rate=200k"]
}
```

* `--wait=1` / `--random-wait`: Respect server load
* `--limit-rate=200k`: Cap download bandwidth

---

#### 7. Authentication (Cookies & Headers)

**Cookies:**

```bash
wget \
  --recursive -l 2 --convert-links --page-requisites --adjust-extension --no-parent \
  --load-cookies /path/to/cookies.txt \
  --directory-prefix "/path/to/output" \
  https://portal.example.com/docs
```

**Headers / Tokens:**

```bash
wget \
  --recursive -l 2 --convert-links --page-requisites --adjust-extension --no-parent \
  --header "Authorization: Bearer $TOKEN" \
  --directory-prefix "/path/to/output" \
  https://secure.example.com/knowledge-base
```

---

#### 8. Cross-Domain Assets & Scope Control

* Single-domain mirrors may have broken external links
* To include specific external hosts:

```bash
wget -r -l 2 --convert-links --page-requisites --adjust-extension --no-parent \
  --span-hosts --domains example.com,static.examplecdn.com \
  --directory-prefix "/path/to/output" \
  https://example.com
```

* Exclude unwanted paths: `--reject "/videos/,/search"`
* Include specific file types: `--accept ".html,.css,.js,.png"`

---

#### 9. Verifying & Serving the Mirror Locally

```bash
cd /path/to/output/example.com
python3 -m http.server 8080
```

* Browse to `http://localhost:8080` to view the mirror

---

#### 10. Advanced Control (via `extraWgetArgs`)

| Control Area           | Example Flags                                                     |
| ---------------------- | ----------------------------------------------------------------- |
| Performance/Politeness | `--wait=SECONDS`, `--random-wait`, `--limit-rate=200k`            |
| Scope                  | `--domains`, `--reject`, `--accept`, `--no-parent`, `--level N`   |
| Robustness             | `--tries=8`, `-T 10`, `-c`, `--timeout=10`, `--retry-connrefused` |
| Naming/Compatibility   | `--restrict-file-names=windows`, `--adjust-extension`             |
| TLS/Proxy              | `--ca-certificate=/path/ca.crt`, env `http_proxy`/`https_proxy`   |

> Only use flags you understand; over-broad settings (e.g., `--span-hosts` without `--domains`) can produce huge downloads.

---

#### 11. Troubleshooting (MCP Context)

| Issue                | Possible Cause / Solution                                                   |
| -------------------- | --------------------------------------------------------------------------- |
| Empty/partial pages  | JS-rendered content; use server-rendered routes or static exports           |
| Missing CSS/images   | Cross-domain assets; add `--span-hosts` + `--domains`                       |
| 403 / 401            | Supply cookies/headers; change user agent (`--user-agent="WgetMirror/1.0"`) |
| 429 / rate-limiting  | Add `--wait` / `--random-wait` and reduce `--limit-rate`                    |
| Corporate TLS issues | Import proxy CA; use `--ca-certificate`                                     |

---

#### 12. Ethics & Compliance

* Respect **robots.txt** and site **Terms of Service**
* Obtain permission for private content
* Use polite waits and bandwidth limits
* Keep internal mirrors restricted if redistribution is prohibited
* Log actions for **auditability**

---

This setup gives **full control over offline mirroring**, including:

* Scoped downloads
* Multi-level recursion
* Rate limiting & politeness
* Authentication via cookies or headers
* Handling cross-domain assets

It is ideal for **documentation archives, audits, DR playbooks, and offline browsing**.

---


### ⚙️ Advanced Edge‑Case Operations with Wget

These advanced techniques help ensure **robust, secure, and repeatable workflows** in enterprise environments, CI/CD pipelines, and automated scripts.

---

#### 1. Handling Corporate TLS Interception with a Custom CA

In enterprise environments, HTTPS traffic may be intercepted by corporate proxies. This can cause TLS handshake failures when Wget attempts to connect to secure endpoints. To fix this:

1. **Import the proxy’s root certificate**:

```bash
wget --ca-certificate=/etc/ssl/certs/corp-proxy-ca.crt https://secure.example.com/data.json
```

2. **Keep CA bundles updated**:

```bash
# Debian/Ubuntu
sudo update-ca-certificates
```

3. **Ensure system clock is accurate**:

```bash
sudo timedatectl set-ntp true
```

> A correct system clock prevents TLS handshake errors due to invalid certificate validity.

---

#### 2. Handling Non‑2xx Responses and Exit Codes

Wget provides **exit codes** that can be leveraged in scripts to handle failures:

| Exit Code | Meaning                                        |
| --------- | ---------------------------------------------- |
| `0`       | Success                                        |
| `4`       | Network failure                                |
| `8`       | Server returned an error (non‑2xx HTTP status) |

**Check server responses without downloading content**:

```bash
wget --spider --server-response https://api.example.com/v1/health || echo "API down"
```

**CI/CD Integration**:

```bash
wget -qO- https://api.example.com/v1/health
if [ $? -ne 0 ]; then
  echo "API health check failed, halting build."
  exit 1
fi
```

> Using `--spider` ensures only headers are fetched, reducing unnecessary data transfer.

---

#### 3. Idempotency Notes for PUT and DELETE Requests

APIs that accept `PUT` or `DELETE` may behave differently on retries. Wget can send these methods with:

```bash
wget --method=PUT \
  --body-data '{"name":"update"}' \
  --header="Content-Type: application/json" \
  --header="Authorization: Bearer $DO_TOKEN" \
  https://api.example.com/v1/resource/42
```

##### Key Recommendations:

* Confirm that endpoints are **idempotent**:

  * `PUT` should safely update without creating duplicates
  * `DELETE` should not fail or delete unrelated data if retried
* Use `PATCH` when supported for partial updates
* Always check API documentation to avoid unintended effects

---

#### 4. Verifying Integrity of Large File Downloads

For large images, backups, or artifacts, verify checksums to prevent corruption:

```bash
wget -O ubuntu.img https://releases.ubuntu.com/24.04/ubuntu-server.img
wget -O ubuntu.img.sha256 https://releases.ubuntu.com/24.04/ubuntu-server.img.sha256
sha256sum -c ubuntu.img.sha256
```

##### Automation Example:

```bash
wget -O backup.tar.gz https://storage.example.com/backup.tar.gz
wget -O backup.tar.gz.sha256 https://storage.example.com/backup.tar.gz.sha256

if ! sha256sum -c backup.tar.gz.sha256; then
  echo "Checksum verification failed!"
  exit 1
fi
```

> Integrating checksum validation ensures **production safety** and alerts you if files are corrupted during transfer.

---

#### ✅ Summary of Best Practices

1. **Corporate TLS**: Use custom CAs and verify system time.
2. **Non-2xx Responses**: Always check exit codes for automation reliability.
3. **Idempotent Methods**: Ensure PUT/DELETE retries do not cause side effects.
4. **Large File Verification**: Always check hashes to validate downloads.

---

This ensures your **Wget workflows are robust, secure, and production-ready**, even in edge-case enterprise and CI/CD scenarios.

---

### ⚡ Wget Performance Benchmarking in the Real World

This section provides **repeatable methods to measure Wget performance**, including wall‑clock time, CPU, memory usage, and the effect of flags like `--limit-rate`, `-c` (resume), and retries/timeouts. These practices are **CI/CD-friendly** and suitable for automation.

---

#### 1. What You’ll Measure

1. **Baseline throughput** for a fresh download
2. **Bandwidth-capped downloads** with `--limit-rate`
3. **Resume performance** using `-c` after interruption
4. **Retry/timeout behavior** for unreliable endpoints

> Replace the sample URL with any large, publicly accessible file approved for benchmarking.

---

#### 2. Setup Temporary Workspace

```bash
TMPDIR="$(mktemp -d)"; cd "$TMPDIR"
TEST_URL="https://speed.hetzner.de/100MB.bin"  # sample 100MB object
OUT="test.bin"
```

##### Metric Format with GNU Time

```bash
/usr/bin/time -f 'wall=%E user=%U sys=%S rss=%MKB exit=%x' <command>
```

* `wall` – elapsed time (hh:mm:ss)
* `user/sys` – CPU time in user/kernel space
* `rss` – peak resident memory (KB)
* `exit` – process exit code

---

#### 3. Baseline Download (Unthrottled)

```bash
/usr/bin/time -f 'wall=%E user=%U sys=%S rss=%MKB exit=%x' \
  wget -q --show-progress -O "$OUT" "$TEST_URL"
ls -lh "$OUT"
```

**Interpretation:** Provides raw network + disk performance under current conditions.

---

#### 4. Bandwidth-Capped Download (`--limit-rate`)

```bash
rm -f "$OUT"
/usr/bin/time -f 'wall=%E user=%U sys=%S rss=%MKB exit=%x' \
  wget -q --show-progress --limit-rate=200k -O "$OUT" "$TEST_URL"
```

**Interpretation:** Wall time increases, but network impact on other workloads is predictable and controlled.

---

#### 5. Resume After Interruption (`-c`)

```bash
rm -f "$OUT"
wget --limit-rate=1m -O "$OUT" "$TEST_URL" &
PID=$!; sleep 3; kill -INT "$PID" 2>/dev/null || true

# Resume download
/usr/bin/time -f 'wall=%E user=%U sys=%S rss=%MKB exit=%x' \
  wget -q --show-progress -c -O "$OUT" "$TEST_URL"
```

**Interpretation:** Resumed download skips already downloaded bytes, reducing wall-clock time.

---

#### 6. Bounded Retries for Flaky Endpoints

```bash
BAD_URL="https://example.invalid/bogus.bin"
/usr/bin/time -f 'wall=%E user=%U sys=%S rss=%MKB exit=%x' \
  wget --spider --tries=3 -T 5 "$BAD_URL" || echo "bounded failure (as expected)"
```

**Interpretation:** Wall time ≈ `tries × timeout`. Exit code is non-zero, ensuring CI fails early on persistent errors.

---

#### 7. Recording Results (CSV for CI/CD)

```bash
SCENARIO="baseline"; SIZE="$(stat -c%s "$OUT" 2>/dev/null || echo 0)"
/usr/bin/time -f "$SCENARIO,%E,%U,%S,%M,%x" -o results.csv -a true

# Repeat for other scenarios: limit, resume, flaky
echo "scenario,wall,user,sys,rss_kb,exit" | cat - results.csv | tee results.csv
```

> Store `results.csv` as a CI artifact to track performance trends over time.

---

#### 8. Optional: Emulate WAN or Packet Loss (Advanced)

```bash
# Add latency and 1% packet loss (Linux, requires sudo)
sudo tc qdisc add dev eth0 root netem delay 120ms loss 1%
# Run baseline test
# Remove shaping
sudo tc qdisc del dev eth0 root
```

**Interpretation:** Compare wall time and retries under adverse network conditions to validate flags like `--tries`, `-T`, and `-c`.

---

#### 9. Best-Practice Conclusions

1. Use `--limit-rate` to **preserve network capacity**, especially on shared CI/build agents.
2. Prefer `-c` to **resume large downloads**. Ensure the server supports range requests.
3. Always pair `--tries` with `-T` to **bound failure time** and avoid stalls.
4. Record **tool versions** and `results.csv` in CI for **defensible SLOs**.
5. Optional network emulation validates performance under real-world conditions.

---

This methodology ensures **repeatable, reliable, and CI-ready benchmarking** of Wget workflows, whether for artifacts, backups, or website mirroring.

---

### 🕒 Daily Wget Automation (Cron‑Ready)

This implementation shows how to **reliably batch-download assets daily** while incorporating Wget best practices:

* `-qO-` for clean logs
* `-c` to resume partial downloads
* `--tries` + `-T` for resilience
* Environment variable tokens (`$DO_TOKEN`) for secure auth
* Optional callback to a backend API upon completion

---

#### 1️⃣ What You’ll Build

* Download multiple files listed in a text file (`files.txt`)
* Store them under `/var/backups/assets`
* Resume downloads automatically if interrupted
* Retry on flaky networks
* Notify a backend API after successful download (optional)

---

#### 2️⃣ Setup

##### Directory and URL List

```bash
sudo mkdir -p /var/backups/assets
sudo tee /var/backups/assets/files.txt >/dev/null <<'EOF'
https://example.com/static/manual.pdf
https://example.com/assets/logo.png
https://jsonplaceholder.typicode.com/posts?_limit=25
EOF
```

##### Token for Auth (Optional)

```bash
export DO_TOKEN="paste-your-token-here"
```

> ⚠️ In production, store tokens securely using a CI secret, systemd `EnvironmentFile`, or a vault.

---

#### 3️⃣ Automation Script

Create `/usr/local/bin/wget-daily-sync.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

ASSET_DIR="/var/backups/assets"
URL_LIST="${ASSET_DIR}/files.txt"
LOG_FILE="/var/log/wget-sync.log"

mkdir -p "${ASSET_DIR}"

# Download all assets with resilience and clean logs
wget --continue \
     --input-file="${URL_LIST}" \
     --directory-prefix="${ASSET_DIR}" \
     --tries=8 -T 10 \
     -q --show-progress 2>>"${LOG_FILE}"

# Optional: notify backend
if [[ -n "${DO_TOKEN:-}" ]]; then
  wget -qO- --method=post \
    --header="Authorization: Bearer ${DO_TOKEN}" \
    --header="Content-Type: application/json" \
    --body-data "{\"synced\":\"$(date -Is)\",\"count\":$(wc -l < "${URL_LIST}")}" \
    https://api.example.com/v1/sync >/dev/null
fi
```

##### Make Executable

```bash
sudo install -m 0755 ./wget-daily-sync.sh /usr/local/bin/wget-daily-sync.sh
```

---

#### 4️⃣ Schedule with Cron

Run daily at 02:15:

```bash
sudo crontab -e
```

Add the line:

```cron
15 2 * * * /usr/local/bin/wget-daily-sync.sh
```

> Cron will automatically run the script daily at 02:15. Logs are appended to `/var/log/wget-sync.log`.

---

#### 5️⃣ Validation

* **Check downloaded files:**

```bash
ls -lah /var/backups/assets
```

* **Inspect logs:**

```bash
sudo tail -n 100 /var/log/wget-sync.log
```

* **Verify callback (if enabled):**
  The backend should record the timestamp and the number of synced files.

---

#### 6️⃣ Security & Best Practices

1. **Do not hard-code tokens** in scripts; use environment variables or secret stores.
2. **Restrict log access** if they may contain error messages or sensitive URLs:

```bash
sudo chmod 600 /var/log/wget-sync.log
```

3. **Resume downloads safely** with `--continue` (`-c`) to avoid re-downloading large files.
4. **Retry/resilience:** Pair `--tries` with `-T` to prevent stalls or indefinite hangs on flaky networks.
5. **CI/CD friendly:** Logs are clean due to `-q` and optional progress display.

---

#### 7️⃣ Further Enhancements

* **Checksum verification** for large downloads (`sha256sum`).
* **Error notifications** (email or Slack) if `wget` fails repeatedly.
* **Parallel downloads** using `xargs -P` for large file lists.
* **Dynamic URL lists** from an API instead of static `files.txt`.

---

This approach combines **reliability, resilience, and security**, making it suitable for production cron jobs, CI pipelines, or backup automation.

---

Here’s a concise wrap-up for your Wget guide based on the FAQs and previous sections:

---

### Mastering Wget for Automation, API, and Mirroring

Throughout this guide, you’ve learned how to leverage Wget for **robust, auditable, and production-ready workflows**:

##### 1. **Reliable Downloads**

* Use `--continue` (`-c`) to resume interrupted downloads.
* Control retries with `--tries` and timeouts with `-T` for predictable, CI-friendly automation.
* Bandwidth management via `--limit-rate` ensures other workloads aren’t affected.

##### 2. **API Interaction**

* Send GET, POST, PUT, DELETE requests with headers and JSON payloads.
* Authenticate securely using environment variables (`$DO_TOKEN`) instead of embedding secrets.
* Combine Wget with `jq` to parse, filter, and validate JSON API responses.

##### 3. **Website Mirroring**

* High-fidelity mirrors with `-r`, `--page-requisites`, `--convert-links`, `--adjust-extension`, and domain restrictions.
* Respect cross-domain assets, handle cookies, headers, and authentication where required.
* Polite mirroring with `--wait`, `--random-wait`, and `--limit-rate` protects server resources.

##### 4. **Enterprise Edge Cases**

* Corporate TLS interception: use `--ca-certificate` with the proxy CA.
* Handle non-2xx responses and exit codes in scripts for idempotent and resilient automation.
* Validate large downloads via checksums to prevent corruption.

##### 5. **Automation & Scheduling**

* Implement daily cron or systemd timers for batch downloads and optional API callbacks.
* Ensure logs are clean, auditable, and access-restricted.
* Integrate with CI/CD pipelines safely using environment-injected secrets and reproducible Wget versions.

##### 6. **Best Practices**

* Prefer Wget for downloads and simple API calls; use curl for complex HTTP/2, OAuth, or multipart needs.
* Always respect robots.txt, TOS, and server load limits when mirroring.
* Record metrics, logs, and checksums to maintain defensible SLOs and audit trails.

---

**Bottom line:**
By combining Wget’s flexibility with careful scripting, token management, retries, and optional parsing with `jq`, you can automate downloads, interact with APIs, mirror websites, and integrate Wget safely into CI/CD pipelines or enterprise workflows. It’s a **lightweight yet powerful tool** for reliable, repeatable operations across environments.


### References
- https://www.gnu.org/software/wget/manual/wget.html
- https://www.digitalocean.com/community/tutorials/how-to-use-wget-to-download-files-and-interact-with-rest-apis
- https://www.hostinger.com/in/tutorials/wget-command-examples *
- https://phoenixnap.com/kb/wget-command-with-examples *
- https://www.geeksforgeeks.org/linux-unix/wget-command-in-linux-unix/ *
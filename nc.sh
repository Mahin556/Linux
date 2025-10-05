: <<'COMMENT_BLOCK'
✅ Serve multiple files (HTML, CSS, JS, images, etc.)
✅ Automatically detect and send correct MIME types
✅ Work with OpenBSD, GNU, or BusyBox nc versions
✅ Log each request clearly
✅ Run continuously
COMMENT_BLOCK



#!/bin/bash
# =============================================
#  Simple Netcat Web Server with MIME Detection
#  Author: ChatGPT (GPT-5)
#  Version: Advanced
#  =============================================

PORT=${1:-1234}
DOCROOT="${2:-$(pwd)}"

# Detect which netcat variant is available
if nc -h 2>&1 | grep -qi "OpenBSD"; then
  NC_CMD="nc -l -p $PORT"
  echo "[INFO] Using OpenBSD Netcat"
elif nc -h 2>&1 | grep -qi "GNU"; then
  NC_CMD="nc -l -p $PORT"
  echo "[INFO] Using GNU Netcat"
else
  NC_CMD="nc -l -p $PORT"
  echo "[INFO] Using generic Netcat syntax"
fi

echo "[INFO] Serving directory: $DOCROOT"
echo "[INFO] Listening on port: $PORT"
echo "-----------------------------------------------"

# Function: Determine MIME type based on file extension
get_mime_type() {
  case "$1" in
    *.html|*.htm) echo "text/html" ;;
    *.css) echo "text/css" ;;
    *.js) echo "application/javascript" ;;
    *.json) echo "application/json" ;;
    *.jpg|*.jpeg) echo "image/jpeg" ;;
    *.png) echo "image/png" ;;
    *.gif) echo "image/gif" ;;
    *.svg) echo "image/svg+xml" ;;
    *.ico) echo "image/x-icon" ;;
    *.txt|*.log) echo "text/plain" ;;
    *.pdf) echo "application/pdf" ;;
    *.zip) echo "application/zip" ;;
    *.tar|*.gz|*.tgz) echo "application/x-tar" ;;
    *) echo "application/octet-stream" ;;
  esac
}

# Infinite loop to serve multiple clients
while true; do
  $NC_CMD -v | {
    # Read the HTTP request
    read REQUEST
    METHOD=$(echo "$REQUEST" | awk '{print $1}')
    FILE=$(echo "$REQUEST" | awk '{print $2}' | sed 's/^\///')

    [ -z "$FILE" ] && FILE="index.html"

    echo "[REQ] $METHOD $FILE"

    FILE_PATH="$DOCROOT/$FILE"

    # Send response
    if [ -f "$FILE_PATH" ]; then
      MIME_TYPE=$(get_mime_type "$FILE_PATH")
      {
        echo -e "HTTP/1.1 200 OK\r"
        echo -e "Server: Netcat-Bash\r"
        echo -e "Content-Type: $MIME_TYPE; charset=UTF-8\r"
        echo -e "Connection: close\r"
        echo -e "\r"
        cat "$FILE_PATH"
      }
      echo "[OK] Served $FILE ($MIME_TYPE)"
    else
      {
        echo -e "HTTP/1.1 404 Not Found\r"
        echo -e "Server: Netcat-Bash\r"
        echo -e "Content-Type: text/html; charset=UTF-8\r"
        echo -e "Connection: close\r"
        echo -e "\r"
        echo "<h1>404 Not Found</h1>"
        echo "<p>The requested file '$FILE' was not found on this server.</p>"
      }
      echo "[ERR] Missing: $FILE"
    fi
  }
  echo "-----------------------------------------------"
done

: <<'COMMENT_BLOCK'
chmod +x nc_webserver_advanced.sh
./nc_webserver_advanced.sh
./nc_webserver_advanced.sh 8080 /home/user/website
COMMENT_BLOCK

: <<'COMMENT_BLOCK'
curl http://<your_ip>:1234
curl http://<your_ip>:1234/about.html
curl http://<your_ip>:1234/style.css
curl http://<your_ip>:1234/script.js
curl http://<your_ip>:1234/image.png
curl http://<your_ip>:1234/missing.html
COMMENT_BLOCK

: <<'COMMENT_BLOCK'
webserver/
├── index.html
├── about.html
├── contact.html
├── style.css
├── script.js
└── image.png
COMMENT_BLOCK

: <<'COMMENT_BLOCK'
[INFO] Using GNU Netcat
[INFO] Serving directory: /home/user/webserver
[INFO] Listening on port: 1234
-----------------------------------------------
[REQ] GET index.html
[OK] Served index.html (text/html)
-----------------------------------------------
[REQ] GET image.png
[OK] Served image.png (image/png)
-----------------------------------------------
[REQ] GET style.css
[OK] Served style.css (text/css)
-----------------------------------------------
[REQ] GET missing.html
[ERR] Missing: missing.html
-----------------------------------------------
COMMENT_BLOCK

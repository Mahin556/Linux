: <<'COMMENT_BLOCK'
✅ Serves multiple files automatically (HTML, CSS, JS, images)
✅ Detects MIME types
✅ Handles 404 Not Found
✅ Automatically generates a directory listing when a folder is requested (like /)
COMMENT_BLOCK
#!/bin/bash
# =============================================
#  Netcat Web Server with Directory Listing
# =============================================

PORT=${1:-1234}
DOCROOT="${2:-$(pwd)}"

# Detect Netcat variant
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

# Function to determine MIME type
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

# Function to generate directory listing as HTML
dir_listing() {
  local DIR="$1"
  echo "<!DOCTYPE html><html><head><title>Directory Listing</title></head><body>"
  echo "<h1>Directory Listing for $(realpath "$DIR")</h1><ul>"
  for f in "$DIR"/*; do
    NAME=$(basename "$f")
    if [ -d "$f" ]; then
      echo "<li><b><a href=\"$NAME/\">$NAME/</a></b></li>"
    else
      echo "<li><a href=\"$NAME\">$NAME</a></li>"
    fi
  done
  echo "</ul></body></html>"
}

# Infinite loop to handle multiple clients
while true; do
  $NC_CMD -v | {
    read REQUEST
    METHOD=$(echo "$REQUEST" | awk '{print $1}')
    FILE=$(echo "$REQUEST" | awk '{print $2}' | sed 's/^\///')

    [ -z "$FILE" ] && FILE="index.html"

    FILE_PATH="$DOCROOT/$FILE"

    echo "[REQ] $METHOD $FILE"

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
    elif [ -d "$FILE_PATH" ]; then
      {
        echo -e "HTTP/1.1 200 OK\r"
        echo -e "Server: Netcat-Bash\r"
        echo -e "Content-Type: text/html; charset=UTF-8\r"
        echo -e "Connection: close\r"
        echo -e "\r"
        dir_listing "$FILE_PATH"
      }
      echo "[OK] Directory listing for $FILE"
    else
      {
        echo -e "HTTP/1.1 404 Not Found\r"
        echo -e "Server: Netcat-Bash\r"
        echo -e "Content-Type: text/html; charset=UTF-8\r"
        echo -e "Connection: close\r"
        echo -e "\r"
        echo "<h1>404 Not Found</h1>"
        echo "<p>The requested file or directory '$FILE' was not found.</p>"
      }
      echo "[ERR] Missing: $FILE"
    fi
  }
  echo "-----------------------------------------------"
done


The tail command is used to display the last part (end) of files in Linux.
By default, it shows the last 10 lines of each specified file.

It’s most commonly used for:

Viewing latest log entries

Monitoring real-time file updates

Extracting end portions of text or data files

| Option      | Description                                                                           | Example                     |
| ----------- | ------------------------------------------------------------------------------------- | --------------------------- |
| `-n NUM`    | Show the **last NUM lines**                                                           | `tail -n 20 file.txt`       |
| `-c NUM`    | Show the **last NUM bytes**                                                           | `tail -c 100 file.txt`      |
| `-n +NUM`   | Start displaying from **line number NUM** to the end                                  | `tail -n +5 file.txt`       |
| `-f`        | **Follow** file changes in real-time                                                  | `tail -f /var/log/syslog`   |
| `-F`        | Like `-f`, but also **reopens** the file if it’s rotated or recreated (used for logs) | `tail -F /var/log/messages` |
| `-q`        | **Quiet mode** (suppress file headers)                                                | `tail -q file1 file2`       |
| `-v`        | **Verbose mode** (always show file headers)                                           | `tail -v file.txt`          |
| `--help`    | Display help message                                                                  | `tail --help`               |
| `--version` | Show version information                                                              | `tail --version`            |


```bash
tail -f /var/log/syslog | grep "error"

tail -n 5 file1.txt file2.txt

head -n 20 file.txt | tail -n 10

echo -e "line1\nline2\nline3\nline4" | tail -n 2

tail -n 1000 biglog.log

tail -f /var/log/syslog /var/log/auth.log

tail -f /var/log/syslog | grep "CRON"

tail -n 20 access.log | awk '{print $1, $9}'

tail -n 1000 access.log | awk '{print $1}' | sort | uniq -c | sort -nr | head

dmesg | tail -n 15
```

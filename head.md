The head command in Linux is used to display the beginning (top) part of a text file or data stream.
By default, it shows the first 10 lines of each file.

It’s often used to preview files, inspect logs, or check the format of data before processing.

| Option      | Description                                                             | Example                |
| ----------- | ----------------------------------------------------------------------- | ---------------------- |
| `-n NUM`    | Show the first **NUM lines**                                            | `head -n 20 file.txt`  |
| `-n -NUM`   | Show all but the **last NUM lines**                                     | `head -n -5 file.txt`  |
| `-c NUM`    | Show the first **NUM bytes**                                            | `head -c 100 file.txt` |
| `-q`        | **Quiet mode** (don’t print file headers when multiple files are given) | `head -q file1 file2`  |
| `-v`        | **Verbose mode** (always print file headers)                            | `head -v file.txt`     |
| `--help`    | Show help message                                                       | `head --help`          |
| `--version` | Show version info                                                       | `head --version`       |


```bash
head filename.txt #Show 10 lines

head -n 5 /etc/passwd

head -c 100 file.txt

head file1.txt file2.txt
==> file1.txt <==
(first 10 lines)

==> file2.txt <==
(first 10 lines)

head -q file1.txt file2.txt
(first 10 lines)
(first 10 lines)

head -v file.txt

head -n -3 file.txt

ls -l | head -n 15

dmesg | head -n 20
ps aux | head -n 10
cat bigfile.log | head -c 200

echo "=== HEAD ===" && head -n 5 file.txt && echo "=== TAIL ===" && tail -n 5 file.txt

grep "ERROR" /var/log/syslog | head -n 10

sort data.txt | uniq -c | head -n 10

head -n 100 file.txt | less

find /etc -type f -name "*.conf" -exec head -n 2 {} \;

```
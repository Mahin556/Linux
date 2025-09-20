```
grep "pattern" file.txt        # Search for "pattern" in file

grep "pattern" file1 file2     # Search in multiple files

echo "hello world" | grep "hello"   # Search from standard input

grep "linux" file.txt      # Case-sensitive (default)

grep -i "linux" file.txt   # Ignore case

grep -c "error" logfile.log   # Count matching lines

grep -n "main" code.c     # Show line numbers

grep -w "cat" file.txt   # Match "cat" but not "concatenate"

grep -x "hello" file.txt  # Match line containing exactly "hello"

grep -v "error" logfile.log   # Show lines NOT containing "error"

grep -r "TODO" /project       # Search recursively in directories

grep -R "TODO" /project       # Same as -r, but follow symlinks

grep -l "main" *.c      # List files that contain "main"

grep -L "main" *.c      # List files that do NOT contain "main"

grep -A 3 "error" logfile.log   # Show 3 lines After match

grep -B 2 "error" logfile.log   # Show 2 lines Before match

grep -C 4 "error" logfile.log   # Show 4 lines Context (before & after)

grep --color=auto "pattern" file.txt

grep "a.b" file.txt        # Dot matches any character

grep "^start" file.txt     # Match lines starting with "start"

grep "end$" file.txt       # Match lines ending with "end"

grep "[0-9]" file.txt      # Match digits

grep "foo\|bar" file.txt   # Match "foo" or "bar"

grep -E "foo|bar" file.txt     # OR condition

grep -E "(cat|dog)s?" file.txt # Match "cat", "cats", "dog", "dogs"

grep -P "\d+" file.txt        # Match numbers (Perl regex)

grep -P "^\w{3,5}$" file.txt  # Words of length 3–5

grep -F "a.b" file.txt   # Treat "a.b" literally, no regex

grep -e "error" -e "fail" logfile.log   # Match error OR fail

grep -a "text" file.bin     # Search binary files as text

grep -I "text" *            # Ignore binary files

grep -q "success" logfile.log   # No output, just return code
echo $?   # 0 = found, 1 = not found

grep -o "error" logfile.log     # Print only the matching text

grep -m 3 "error" logfile.log   # Stop after 3 matches

find . -type f -name "*.log" | xargs grep "ERROR"

ps aux | grep "nginx"

dmesg | grep -i "usb"

grep -P "\berror\b" logfile.log   # Match "error" as whole word

zgrep "error" logs.gz     # Search inside compressed files

alias grep='grep --color=auto'

grep -r "linux" *

grep -E "error|warning|failure" logfile.txt

grep -E "([0-9]{4})-([0-9]{2})-([0-9]{2})" dates.txt

find /logs/ -type f | xargs -P 4 grep "error"

grep -r --exclude-dir={proc,sys,dev} "error" /

grep -r --exclude-dir=".*" "pattern" /path/to/directory

grep -E "error|fail|warning" logfile.txt

if grep -q "error" logfile.txt; then
    echo "Errors found in the log."
fi

dpkg -l | grep -i python

grep -v ^\# /etc/apache2/apache2.conf | grep .

find . -name “*.mp3” | grep –i JayZ | grep –vi “remix”



```

### Reference
- https://www.geeksforgeeks.org/linux-unix/grep-command-in-unixlinux/
- https://www.digitalocean.com/community/tutorials/grep-command-in-linux-unix
- https://phoenixnap.com/kb/grep-command-linux-unix-examples
- https://www.freecodecamp.org/news/grep-command-in-linux-usage-options-and-syntax-examples/
- https://www.tecmint.com/12-practical-examples-of-linux-grep-command/
- https://medium.com/@cuncis/mastering-grep-command-your-complete-cheat-sheet-for-efficient-text-searching-in-linux-b569a573432b

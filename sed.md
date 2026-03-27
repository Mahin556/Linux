* Stream editor

```bash
sed 's/yes/no/' /etc/ssh/sshd_config #replaces only the first occurrence of yes on each line.
sed 's/yes/no/g' /etc/ssh/sshd_config #replaces all occurrences of yes on each line.

find /etc/ -type f > demo.txt
#sed 's//etc//' demo.txt #Error 

sed 's./etc..' demo.txt 
sed 's./etc.hello.' demo.txt 
sed -i 's./etc.hello.' demo.txt 
```

---

### 🔍 Print / Display Commands

```bash
sed -n '/' /etc/nsswitch.conf          # Incomplete pattern — does nothing useful
sed -n '3,10p' /etc/nsswitch.conf      # Print lines 3 to 10
sed -n '3,$p' /etc/nsswitch.conf       # Print from line 3 to end of file
sed -n '/files/p' /etc/nsswitch.conf   # Print only lines containing "files"
sed -n -e '3p' -e '4p' /etc/nsswitch.conf          # Print line 3 and line 4
sed -n -e '/files/p' -e '/db/p' /etc/nsswitch.conf # Print lines with "files" OR "db"
sed -n '1,+2p' /etc/nsswitch.conf      # Print line 1 and the next 2 lines (lines 1-3)
sed -n '1~2p' /etc/nsswitch.conf       # Print every odd line (1, 3, 5, 7...)
```

---

### ⚠️ Print Without `-n` (prints all + duplicates matches)

```bash
sed '/files/' /etc/nsswitch.conf       # No action specified — just prints all lines
sed '/files/p' /etc/nsswitch.conf      # Prints all lines; matching lines printed twice
sed '/^n/p' /etc/nsswitch.conf         # Prints all lines; lines starting with 'n' printed twice
```

---

### 🔁 Substitution (s)

```bash
sed -n '2 s/files/demo/g' /etc/nsswitch.conf  # Replace "files" with "demo" on line 2 (no output, -n suppresses)
sed -n '6 s/files/demo/g' /etc/nsswitch.conf  # Same but on line 6
sed -n '9 s/files/demo/g' /etc/nsswitch.conf  # Same but on line 9
sed '9 s/files/demo/g' /etc/nsswitch.conf     # Replace "files" with "demo" on line 9, print all
sed '9! s/files/demo/g' /etc/nsswitch.conf    # Replace on ALL lines EXCEPT line 9
sed '/info/ s/Name/demo/g' /etc/nsswitch.conf # On lines matching "info", replace "Name" with "demo"
```

---

### 🗑️ Delete (d)

```bash
sed '1d' /etc/nsswitch.conf      # Delete line 1
sed '$d' /etc/nsswitch.conf      # Delete last line
sed '2,4d' /etc/nsswitch.conf    # Delete lines 2 through 4
sed '/db/d' /etc/nsswitch.conf   # Delete lines containing "db"
sed '/^&/d' /etc/nsswitch.conf   # Delete lines starting with "&" (likely typo for /^#/d)
sed '/^$/d' /etc/nsswitch.conf   # Delete empty/blank lines
```

---

### ➕ Insert / Append / Change (i / a / c)

```bash
sed '3 a hello' /etc/nsswitch.conf    # Append "hello" AFTER line 3
sed '/nis/ a hello' /etc/nsswitch.conf # Append "hello" after lines matching "nis"
sed '3 c hello' /etc/nsswitch.conf    # Replace (change) line 3 with "hello"
sed '/nis/ c hello' /etc/nsswitch.conf # Replace lines matching "nis" with "hello"
sed '3 i hello' /etc/nsswitch.conf    # Insert "hello" BEFORE line 3
```

---

### 💾 Write to File (w)

```bash
sed '/db/ w dbs' /etc/nsswitch.conf   # Write lines containing "db" to a file called "dbs"
cat dbs                                # Display the content of the "dbs" file just written
```

---

### 🛑 Quit (q)

```bash
sed '/db/ q' /etc/nsswitch.conf       # Print lines until first match of "db", then quit
```

---

### 🔢 Line Numbers (=)

```bash
sed '=' /etc/nsswitch.conf            # Print line numbers before each line
```

---

### 🔎 Regex / Anchor Patterns

```bash
sed -n '/^n/p' /etc/nsswitch.conf     # Print lines starting with "n"
sed -n '/s&/p' /etc/nsswitch.conf     # Print lines containing literal "s&"
sed -n '/d&/p' /etc/nsswitch.conf     # Print lines containing literal "d&"
sed -n '/d$/p' /etc/nsswitch.conf     # Print lines ending with "d"
```

---

### 🔡 Character Classes (from your images)

```bash
sed -n '/[A-D]/p' names               # Print lines containing any letter A, B, C, or D
sed -n '/[[:digit:]]/p' posix         # Print lines containing any digit (0-9)
sed -n '/[[:upper:]]/p' posix         # Print lines containing any uppercase letter
```

---

### 📋 Misc / Visibility

```bash
sed -n 'l' /etc/nsswitch.conf         # Show lines with hidden/non-printable characters visible
sed -n 'l 10' /etc/nsswitch.conf      # Same, but wrap output at 10 characters per line
cat /etc/nsswitch.conf                # Just display the file (not sed, but used to verify changes)
history                               # Show command history (not sed)
```

---

> 💡 **Key reminders:**
> - `-n` suppresses default output — use with `p` to print selectively
> - Without `-n`, sed prints every line by default
> - None of these commands modify the file unless you add `-i` (in-place edit)
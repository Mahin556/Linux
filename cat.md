cat = short for concatenate.
It is used to read, display, create, and concatenate files.
One of the most basic but widely used commands in Linux.
```bash
cat file.txt #display the content of file
cat file1.txt file2.txt #display the content of multiple file(concatenate,sequence)
cat > newfile.txt #Create a new file->Type text, then press CTRL + D to save and exit.
cat >> existing.txt #Append to an existing file->Adds new text at the end of existing.txt.
cat file1.txt file2.txt > combined.txt #Combine files into another(concatenate)
cat -n file.txt #number all lines(--number)
cat -n file1.txt file2.txt #Show multiple files with line numbers
cat -b file.txt #number non-empty lines only
cat -s file.txt #squeeze repeated empty lines
cat -E file.txt #show $ at end of each line (useful for debugging whitespace)(--show-ends)
cat -T file.txt #show tab characters as ^I
cat -v file.txt #show non-printable characters (except tabs/newlines)(--show-nonprinting)
cat file.txt > copy.txt #Redirect output to another file
tac file.txt #Display content of file in reverse order
cat -A  "filename" #The '-A' option allows you to combine the effects of '-v', '-E', and '-T' options. Instead of writing '-vET' in the command, you can use '-A'
cat -- "-dashfile" #to open a dash file
cat *.txt
cat *
cat file4 | grep something
```
* View large files with paging
```bash
cat file.txt | less
cat file.txt | more
```

* -u option
- Forces **unbuffered output**.
- Normally, when `cat` writes to the terminal (or a file), the output may be **buffered** (stored temporarily before being written).
- With `-u`, data is written **immediately**, without waiting for the buffer to fill.

---

**When it’s Useful**
- When working with **real-time devices** (like serial ports, pipes, sockets).
- Example:
```bash
cat -u /dev/ttyUSB0
```
This ensures that output from a serial device appears on screen instantly, without buffering delay.
- When piping output into another command where latency matters:
```bash
cat -u logfile | grep "error"
```
- On **modern Linux systems (GNU coreutils)**, the `-u` option is **ignored** because:
 * `stdout` is already **line-buffered** when writing to a terminal.
 * `stdout` is fully **buffered** when redirected to a file, but programs that need real-time usually use tools like `stdbuf`, `unbuffer`, or `tail -f`.

So in practice:

* `cat -u` behaves the same as plain `cat` on modern Linux.
* Historically (older UNIX), it mattered a lot.

```bash
#!/bin/bash
for f in /source/project10/*.pl
do
   echo "***** [Start $f ] ****"
   cat -n "$f"
   echo "***** [End $f ] ****"
done
```
```bash
#!/bin/ksh
for f in $(ls /source/project10/*.pl)
do
        print "*** [Start $f ] ****"
        cat  "$f"
        print "*** [End $f ] ****"
done
```

---

* **1. Fooling Programs**
- Some programs behave differently if they think they are connected to a terminal vs. a file/pipe.
- Example: `bc -l` (calculator) normally prints a copyright message if run on a terminal.
- But if you **pipe** it into `cat`:
  ```bash
  bc -l | cat
  ```
  - `bc` now thinks it’s writing to a **pipe**, not a terminal.
  - So it **skips the copyright banner** and just processes input/output.

---

* **2. Testing Audio Device**
- You can send raw files to sound devices directly:
  ```bash
  cat file.wav > /dev/dsp
  cat recording.au > /dev/audio
  ```
- To record and playback with audio device:
  ```bash
  dd bs=8k count=4 </dev/audio >testing123.au
  cat testing123.au >/dev/audio
  ```
  - Records 4 blocks of 8 KB audio.
  - Plays it back using `cat`.

---

* **3. Gathering Linux System Information**
- `cat` is often used to read kernel/system info from `/proc`:
  ```bash
  cat /proc/cpuinfo     # CPU details
  cat /proc/meminfo     # Memory usage
  cat /proc/version     # Kernel version
  ```

---

* **4. Display Large Blocks of Text in Scripts (Here Document)**
- You can use `cat` with a **here-document** (`<<`) to print blocks of text inside a script.
  Example:
  ```bash
  usage(){
  cat << EOF
  This is help text
  Usage: script.sh [options]
  EOF
  }
  ```
- Handy for **help messages or templates**.

---

* **5. Printing Files in Reverse**
- `cat` itself **cannot** reverse lines, but you can combine it with `tac` (reverse of cat).
  ```bash
  tac file.txt
  cat file.txt | tac
  ```
- `tac` = prints lines in reverse order.

* Show file in binary format
```bash
cat file.txt | xxd -b
```
- Computers store all files as binary data (0s and 1s).
- Normally, text files are displayed in human-readable ASCII characters.
- Sometimes, you need to see the actual binary representation of each byte in the file.
- This is useful for:
    - Debugging binary protocols
    - Inspecting non-printable characters
    - Reverse engineering
    - Understanding file formats

- `xxd -b` → converts input to binary representation:
  Each byte is displayed as 8 bits (0s and 1s)
  Shows ASCII characters alongside binary for reference

* Show file in hexadecimal format
```bash
cat file.txt | hexdump -C
```

* Display specific lines (3 to 6)
```bash
cat file.txt | sed -n '3,6p'
```

* Sort file alphabetically
```bash
cat file.txt | sort
```

* Use here-document (EOF marker)
```bash
cat > file.txt << EOF
Line 1
Line 2
EOF
```



###  References:
- https://www.geeksforgeeks.org/linux-unix/cat-command-in-linux-with-examples/
- https://www.cyberciti.biz/faq/linux-unix-appleosx-bsd-cat-command-examples/
- https://www.man7.org/linux/man-pages/man1/cat.1.html
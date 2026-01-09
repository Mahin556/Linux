```
======================== YES COMMAND – COMPLETE DETAILED GUIDE ========================

------------------------ WHAT IS `yes` COMMAND ------------------------
`yes` is a Linux utility that repeatedly outputs a string until it is stopped.

By default:
- It prints the letter "y" endlessly
- Each output is followed by a newline

The command is mainly used for:
- Generating large amounts of text data
- Automatically answering prompts
- Creating files filled with readable text (not null bytes)
- Testing disk, I/O, and file system behavior

------------------------ BASIC BEHAVIOR ------------------------
yes
# Output:
y
y
y
y
# continues forever until Ctrl+C

------------------------ CUSTOM STRING ------------------------
yes hello
# Output:
hello
hello
hello
# repeats endlessly

------------------------ WHY USE `yes` FOR FILE CREATION ------------------------
Other commands like `dd` often create files filled with NULL characters.
`yes` creates files filled with readable text, which is useful for:
- File system testing
- Compression testing
- Backup testing
- Learning block allocation behavior

------------------------ LIMITING OUTPUT SIZE ------------------------
Since `yes` runs infinitely, it must be limited.
This is done using:
- `head -c` → limits output by byte size

------------------------ SYNTAX ------------------------
yes [text] | head -c [SIZE] > filename

------------------------ SIZE UNITS ------------------------
K  → Kilobytes
M  → Megabytes
G  → Gigabytes

------------------------ EXAMPLES ------------------------

# Create a 50KB file
yes "This is a test file" | head -c 50K > file1

# Create a 50MB file
yes "This is a test file" | head -c 50M > file2

# Create a 1GB file
yes "This is a test file" | head -c 1G > file3

------------------------ PRACTICAL DEMO ------------------------
mkdir /test
cd /test

yes "This is a test file" | head -c 50K > file1
yes "This is a test file" | head -c 50M > file2
yes "This is a test file" | head -c 1G  > file3

ls -lh
# Shows:
# file1 → 50K
# file2 → 50M
# file3 → 1.0G

cd /
rm -rf /test

------------------------ HOW IT WORKS INTERNALLY ------------------------
- `yes` keeps generating text
- Pipe (|) sends output to `head`
- `head -c` stops after N bytes
- Shell redirects output into a file
- File system allocates blocks accordingly

------------------------ USE CASES ------------------------
- Create test files of exact size
- Test disk performance
- Test backup tools
- Test compression ratios
- Demonstrate block allocation
- Teach file system concepts

------------------------ COMMON MISTAKES ------------------------
- Running `yes > file` without `head` (fills disk!)
- Forgetting quotes for multi-word strings
- Running on production systems without caution

------------------------ SAFE PRACTICES ------------------------
- Always limit output with `head`
- Monitor disk space
- Use test directories
- Clean up after testing

------------------------ COMPARISON ------------------------
yes + head  → readable text data
dd          → binary / null-filled data
fallocate  → sparse files (fast, no data written)

------------------------ QUICK COMMAND SUMMARY ------------------------
yes                      # infinite "y"
yes hello                # infinite "hello"
yes text | head -c 1K    # 1KB output
yes text | head -c 10M   # 10MB output
yes text | head -c 1G    # 1GB output

======================== END OF YES COMMAND GUIDE ========================
```

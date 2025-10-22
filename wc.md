### References:
- https://www.geeksforgeeks.org/linux-unix/wc-command-linux-examples/
- https://www.redhat.com/en/blog/linux-wc-command

wc stands for word count.

It’s used to count lines, words, bytes, and characters in one or more files or input streams.

It’s part of the GNU core utilities, available on all Unix/Linux systems.

| Option      | Description                             |
| :---------- | :-------------------------------------- |
| `-l`        | Count **lines** only                    |
| `-w`        | Count **words** only                    |
| `-c`        | Count **bytes**                         |
| `-m`        | Count **characters** (multi-byte aware) |
| `-L`        | Display **length of the longest line**  |
| `--help`    | Show help message                       |
| `--version` | Show version information                |


```bash
$ wc filename.txt #Give ---> lines, words, chars, filename
5  20  120  filename.txt

$ wc -l filename.txt #Count Lines Only
5 filename.txt

$ wc -w filename.txt #Count Words Only
wc -w filename.txt

$ wc -c filename.txt  #Count Bytes
#Shows the total number of bytes (not characters — bytes may differ for multi-byte encodings like UTF-8).

$ wc -m filename.txt #Count Characters-->Shows the number of characters, taking multi-byte encoding into account (useful for Unicode text).

$ wc -L filename.txt #Find the Longest Line Length
#Prints the length (in characters) of the longest line in the file.

$ wc -lw filename.txt

$ wc file1.txt file2.txt
5  20  120  file1.txt
3  15  80   file2.txt
8  35  200  total


ls | wc -l
cat /etc/passwd | wc -l
grep "error" logfile.txt | wc -l
wc -l *.txt
cat *.log | wc -w
cat *.txt | wc -m
ls -1 | wc -l

LINE_COUNT=$(wc -l < myfile.txt)
echo "File has $LINE_COUNT lines."

wc -w < filename.txt #To ignore the filename in output, use input redirection (<):



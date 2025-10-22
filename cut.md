### References:
- https://www.geeksforgeeks.org/linux-unix/cut-command-linux-examples/
- https://phoenixnap.com/kb/linux-cut

---

* `cut` extracts specific sections (fields, bytes, or characters) from each line of a file or input.

* It’s especially useful when processing structured text data (like CSV files, logs, or command outputs).

```bash
cut OPTION... [FILE...]
command | cut OPTION...
```

| Option | Works On   | Based On                   | When to Use                          |
| ------ | ---------- | -------------------------- | ------------------------------------ |
| `-b`   | Bytes      | Physical byte positions    | For binary/byte data                 |
| `-c`   | Characters | Visual character positions | For plain text                       |
| `-f`   | Fields     | Delimited columns          | For structured data (CSV, TSV, etc.) |

| Option               | Description             | Example                                         |
| -------------------- | ----------------------- | ----------------------------------------------- |
| `-b`                 | Extract bytes           | `cut -b 1-5 file`                               |
| `-c`                 | Extract characters      | `cut -c 3-8 file`                               |
| `-d`                 | Set delimiter           | `cut -d ":" -f 1 /etc/passwd`                   |
| `-f`                 | Extract fields          | `cut -d "," -f 2 file.csv`                      |
| `--complement`       | Exclude fields          | `cut -d "," -f 1 --complement file.csv`         |
| `--output-delimiter` | Change output separator | `cut -d ":" -f 1,2 --output-delimiter="," file` |


```bash
cut -b 1-5 file.txt #Extract specific byte positions from each line-->prints bytes 1 to 5 of each line.
echo "abcdef" | cut -b 1,3,5 #---> ace
cut -b 1-3,5-7 state.txt
cut -b 1- state.txt #indicate from 1st byte to end byte of a line
cut -b -3 state.txt #indicate from 1st byte to 3rd byte of a line

cut -f1 file.txt              # Extract 1st field (default delimiter: tab)
cut -f1,3 file.txt            # Extract 1st and 3rd fields
cut -f1-3 file.txt            # Extract fields 1 through 3
cut -f2- file.txt             # Extract from field 2 to the end
cut -f-3 file.txt             # Extract from start to field 3
cut -d',' -f1 names.csv       # Extract 1st field using comma as delimiter

cut -b1 file.txt              # Extract 1st byte
cut -b1,5 file.txt            # Extract bytes 1 and 5
cut -b1-5 file.txt            # Extract bytes 1 to 5
cut -b-5 file.txt             # Extract bytes 1 to 5 (same as above)
cut -b3- file.txt             # Extract from byte 3 to end

cut -c1 file.txt              # Extract 1st character
cut -c1,3,5 file.txt          # Extract characters 1, 3, and 5
cut -c2-5 file.txt            # Extract characters 2 through 5
cut -c-4 file.txt             # Extract from start to 4th character
cut -c5- file.txt             # Extract from 5th character to end


echo "LinuxCommand" | cut -c 1-5 #Linux

#-d → Specify a delimiter
#Use this to split fields by a specific character (default delimiter = TAB).
cut -d ":" -f 1 /etc/passwd

for i in $(cut -d ":" -f 1 /etc/passwd);do echo "Hello $i";done

#-f → Select fields
#Works together with -d.
#Extract one or more fields (columns).
echo "apple,banana,grape" | cut -d "," -f 2

cut -d "," -f 1,3 fruits.csv

cut -d "," -f 2-4 data.csv


#--complement
#Extract everything except the specified fields/characters.
cut -d "," -f 1 --complement file.csv #prints all fields except the first.

cut --complement -c 5 state.txt

#--output-delimiter
#Change the output field separator.
echo "one:two:three" | cut -d ":" -f 1,2 --output-delimiter="," #-->one,two

cut -d " " -f 1,2 state.txt --output-delimiter='%'

cat state.txt | cut -d ' ' -f 1 | sort -r

cat state.txt | head -n 3 | cut -d ' ' -f 1 > list.txt

cut -d " " -f 1 /etc/hosts

cut -c 1-5 filename.txt

grep "root" /etc/passwd | cut -d ":" -f 1,7

cut -d "," -f 2 domains.csv

ps aux | cut -d " " -f 1

df -h | cut -d " " -f 1,5

ls -lh | cut -d' ' -f5

cut -d',' -f1,3 employees.csv

cut -c1-5 file.txt

cut -d':' -f2 -s /etc/passwd

cut -d',' -f1 --complement file.csv

who | cut -c 1-4,18-

cat data.txt | tr -s ' ' | cut -d ' ' -f1,3

sed 's/ /,/g' data.txt | cut -d ',' -f1,3
```


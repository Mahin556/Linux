* `bzip2` = Burrows–Wheeler Block Sorting Compressor
* It compresses files into .bz2 format.
* Typically achieves better compression than gzip, but slower.
* Works only on single files (like gzip); to archive multiple files, combine with tar.

```bash
bzip2 myfile.txt      → myfile.txt.bz2
bunzip2 myfile.txt.bz2 → myfile.txt
```
| Extension         | Meaning                           |
| ----------------- | --------------------------------- |
| `.bz2`            | Standard bzip2 compressed file    |
| `.tar.bz2`        | Tar archive compressed with bzip2 |
| `.tbz` or `.tbz2` | Shortcut for `.tar.bz2`           |

```bash
bzip2 file.txt #Compress a File
bzip2 -k file.txt #keep original file

bunzip2 file.txt.bz2 #decompress file
bzip2 -d file.txt.bz2
bunzip2 -k file.txt.bz2

bzip2 file1.log file2.txt file3.csv
bunzip2 *.bz2

tar -cjf backup.tar.bz2 /home/user
tar -xjf backup.tar.bz2
tar -tjf backup.tar.bz2

bzip2 -v file.txt

bzip2 -t file.txt.bz2

bzip2 -c file.txt > compressed.bz2
bzip2 -dc compressed.bz2 > file.txt

cat bigfile | bzip2 > bigfile.bz2
bzip2 -dc bigfile.bz2 | less

find /var/log -type f -name "*.log" -exec bzip2 {} \;

tar -cjf logs.tar.bz2 /var/log

bzip2 -k file.txt

bzip2 -lv file.txt.bz2

bunzip2 -k file.txt.bz2

tar -cf - /home/user | bzip2 | ssh user@remote 'cat > /backup/home.tar.bz2'

ssh user@remote 'cat /backup/home.tar.bz2' | bzip2 -dc | tar xf -

cat file.txt | bzip2 > file.txt.bz2
bzip2 -dc file.txt.bz2 | less
```

* Compression Level (Speed vs Ratio)

| Option | Meaning                                     |
| ------ | ------------------------------------------- |
| `-1`   | Fastest, lower compression                  |
| `-9`   | Slowest, best compression (default is `-9`) |

```bash
bzip2 -1 file.iso
bzip2 -9 backup.tar
```

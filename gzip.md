* `gzip` = GNU zip — a file compression utility based on the DEFLATE algorithm.
* It’s mainly used to compress single files, not multiple ones (that’s what tar is for).
* The resulting compressed file ends with .gz.

```bash
gzip file.txt    → creates file.txt.gz
gunzip file.txt.gz → restores file.txt
```

| Command                           | Description                                      |
| --------------------------------- | ------------------------------------------------ |
| `gzip file`                       | Compress `file` → replaces it with `file.gz`     |
| `gzip -k file`                    | Compress but keep the original (`-k` = keep)     |
| `gzip file1.txt file2.log file3.csv`                | Compress multiple files |
| `gzip -r dir/`                    | Recursively compress all files in a directory    |
| `gunzip file.gz`                  | Decompress (same as `gzip -d`)                   |
| `gzip -d file.gz`                 | Decompress                                       |
|   `gunzip *.gz`                   | Decompress multiple files |
| `zcat file.gz`                    | View compressed file contents without extracting |
| `zgrep pattern file.gz`           | Search inside compressed files                   |
| `zless file.gz` / `zmore file.gz` | View compressed text with pagination             |

```bash
gunzip -k file.txt.gz
zgrep "error" file.log.gz

tar cf - dir/ | gzip > archive.tar.gz
gzip -dc archive.tar.gz | tar xvf -

gzip -t file.gz #Check compressed file validity

gzip -c file.txt > compressed.gz #Compress and write to stdout

gzip -dc compressed.gz > file.txt #Decompress to stdout

gzip -dc compressed.gz | less #View directly

gzip -N file.txt #Preserve Timestamps and Ownership

cat largefile | gzip > largefile.gz

find /var/log -name "*.log" -print | tar cf - -T - | gzip > logs.tar.gz

gzip -f file.txt #Force Overwrite

gzip -rv /var/log #Recursive Directory Compression with Verbose Output

gunzip -k file.txt.gz #Uncompress Without Removing .gz
```

* Set Compression Level

| Flag     | Meaning                             |
| -------- | ----------------------------------- |
| `-1`     | Fastest, least compression          |
| `-9`     | Slowest, best compression (default) |
| `--fast` | Same as `-1`                        |
| `--best` | Same as `-9`                        |

```bash
gzip -1 bigfile.iso
gzip -9 logs.txt
```

| Command                   | Purpose                      |
| ------------------------- | ---------------------------- |
| `zcat file.gz`            | Show contents                |
| `zgrep "pattern" file.gz` | Grep inside compressed file  |
| `zless file.gz`           | View compressed file (paged) |
| `zmore file.gz`           | View compressed file (paged) |

```bash
zgrep -i "error" /var/log/syslog.gz
```
```bash
tar cf - /etc | gzip | ssh user@remote 'cat > /backup/etc.tar.gz'
ssh user@remote 'cat /backup/etc.tar.gz' | gzip -dc | tar xf -
```
```bash
ls -lh file.txt file.txt.gz
gzip -lv file.txt.gz
```

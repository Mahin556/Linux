* The sha256sum command is a Linux/Unix utility used to compute and verify SHA-256 hashes of files or strings. SHA-256 (Secure Hash Algorithm 256-bit) produces a unique 64-character hexadecimal checksum for a file, useful for verifying integrity and authenticity.
```bash
sha256sum [OPTIONS] [FILE...]
```
* FILE → The file(s) for which the SHA-256 hash will be calculated.
* If no file is provided, sha256sum reads from standard input (stdin).
```bash
controlplane:~$ sha256sum 


```

```bash
$ sha256sum example.txt
d2d2d2f53c...  example.txt
#The first column is the SHA-256 hash.
#The second column is the file name.
```

```bash
echo "Hello World" | sha256sum
a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e  -

controlplane:~$ echo -n "Hello World" | sha256sum
a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e  -
```

* Integrity check
```bash
sha256sum myfile.txt > myfile.txt.sha256

cat myfile.txt.sha256
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  myfile.txt

sha256sum -c myfile.txt.sha256
myfile.txt: OK
```

| Option        | Description                                                            |
| ------------- | ---------------------------------------------------------------------- |
| `-b`          | Read file in **binary mode** (default for Linux, important on Windows) |
| `-c, --check` | Read SHA-256 sums from a file and **verify** them                      |
| `--tag`       | Use a **BSD-style checksum** (filename first)                          |
| `--help`      | Display help information                                               |
| `--version`   | Show version info                                                      |

```bash
sha256sum file1.txt file2.txt file3.txt
sha256sum *.txt > checksums.sha256
sha256sum -c checksums.sha256

sha256sum original_file > file.sha256
scp file user@server:/path/
sha256sum -c file.sha256
```
```bash
#Compute SHA-256 for strings without creating files:
echo -n "string1" | sha256sum
echo -n "string2" | sha256sum
```

| Algorithm | Hash Length | Use Case                                           |
| --------- | ----------- | -------------------------------------------------- |
| MD5       | 128-bit     | Fast, but **not secure**                           |
| SHA-1     | 160-bit     | Better than MD5, but **vulnerable**                |
| SHA-256   | 256-bit     | Recommended for **security-critical verification** |
| SHA-512   | 512-bit     | Stronger, slower than SHA-256                      |

```bash
find . -type f -exec sha256sum {} \; > allfiles.sha256
```
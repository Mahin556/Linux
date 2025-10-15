* base64 is a command-line utility that encodes or decodes data using the Base64 encoding scheme — a way to represent binary data (like images, certificates, passwords, or files) using printable ASCII characters.
* It’s useful because it allows safe transmission of data over text-based protocols (like YAML, JSON, or HTTP).
* Base64 is not encryption — it only encodes data to text form, Anyone can decode it easily.
* Use it only for data representation, not for securing secrets.

```bash
$ echo "hello world" | base64 #encoding ---> aGVsbG8gd29ybGQK ---> trailing K represent '\n' added by echo

$ echo -n "hello world" | base64 #aGVsbG8gd29ybGQ= -n prevents echo from adding a newline — this is the most common way to encode cleanly.

$ base64 myfile.txt #This reads myfile.txt and prints its base64-encoded content to stdout.

$ base64 myfile.txt > myfile.b64

$ echo "aGVsbG8gd29ybGQ=" | base64 --decode #decoding

$ base64 --decode myfile.b64 > myfile.txt
$ base64 -d myfile.b64

#Encode / Decode Binary Files(like an image or certificate)
$ base64 image.png > image.b64
$ base64 -d image.b64 > image.png
```
| Option           | Description                                        | Example                              |
| ---------------- | -------------------------------------------------- | ------------------------------------ |
| `-d`, `--decode` | Decode input                                       | `base64 -d data.txt`                 |
| `-w`, `--wrap=N` | Wrap encoded lines after N characters (default 76) | `base64 -w 0 file.txt` (no wrapping) |
| `--help`         | Display help                                       | `base64 --help`                      |
| `--version`      | Show version info                                  | `base64 --version`                   |

```bash
#By default, GNU base64 wraps encoded output at 76 characters per line.
#To disable wrapping:
$ echo -n "longtext..." | base64 -w 0 #
```

```bash
echo -n "user:password" | base64 #Encode a username:password pair (for Basic Auth) ---> Authorization: Basic dXNlcjpwYXNzd29yZA==

cat secrets.txt | base64 -w 0 #Encode multiple lines from a file

cat cert.pem.b64 | base64 -d > cert.pem #Decode a certificate

encoded=$(echo -n "data123" | base64)
decoded=$(echo "$encoded" | base64 -d)
```

### How Base64 Works (Conceptually)
* Base64 represents binary data using 64 printable characters.
* Each set of 3 bytes (24 bits) is split into 4 groups of 6 bits.
* Each 6-bit group is represented by a printable character (A–Z, a–z, 0–9, +, /).
* Padding with = is used if the data is not divisible by 3.
* Example:
  * Input	Binary	Base64-Output
  * Man	01001101 01100001 01101110	TWFu
 
  

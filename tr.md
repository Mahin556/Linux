
# 🔹 `tr` Command in Unix/Linux

The `tr` (**translate**) command is used to **translate, squeeze, delete, or complement characters** from input.
It works well with **pipes** and **redirection**.

---

## 🔹 Syntax

```bash
tr [OPTION] SET1 [SET2]
```

* **SET1** = characters to replace/delete/match
* **SET2** = characters to map to (for translation)

### Options

| Option      | Description                                               |
| ----------- | --------------------------------------------------------- |
| `-c`        | Complement SET1 (apply to characters *not* in SET1).      |
| `-C`        | Same as `-c` but works differently in some `tr` versions. |
| `-d`        | Delete characters in SET1.                                |
| `-s`        | Squeeze repeated characters into one.                     |
| `-t`        | Truncate SET1 to length of SET2.                          |
| `-u`        | Output is unbuffered (rarely used).                       |
| `--help`    | Show help.                                                |
| `--version` | Show version.                                             |
---
### Supported Character Classes (POSIX Bracket Expressions)
#### Use inside [: ... :]
- [:alnum:] → all letters + digits
- [:alpha:] → all letters
- [:blank:] → horizontal whitespace (space, tab)
- [:cntrl:] → control characters
- [:digit:] → all digits
- [:graph:] → visible (non-space) chars
- [:lower:] → lowercase letters
- [:print:] → printable chars (includes space)
- [:punct:] → punctuation
- [:space:] → whitespace (space, tab, newline, etc.)
- [:upper:] → uppercase letters
- [:xdigit:] → hex digits (0-9, a-f, A-F)

### Escape Sequences
| Sequence | Meaning                  |
| -------- | ------------------------ |
| `\NNN`   | Octal value (1–3 digits) |
| `\\`     | Backslash                |
| `\a`     | Bell                     |
| `\b`     | Backspace                |
| `\f`     | Form feed                |
| `\n`     | Newline                  |
| `\r`     | Carriage return          |
| `\t`     | Tab                      |
| `\v`     | Vertical tab             |


---

## 🔹 Examples

### 1. Convert lowercase → uppercase

```bash
cat file | tr [a-z] [A-Z]
# or
cat file | tr [:lower:] [:upper:]
# or
tr [:lower:] [:upper:] < file
```

✅ Converts text to uppercase.

---

### 2. Convert uppercase → lowercase

```bash
echo "HELLO World" | tr [:upper:] [:lower:]
```

✅ Converts text to lowercase.

---

### 3. Translate whitespace to tabs

```bash
echo "Welcome To GeeksforGeeks" | tr [:space:] "\t"
# or
tr [:space:] "\t" <<< "Welcome To GeeksforGeeks"
```

✅ Replaces spaces with tabs.

---

### 4. Replace braces `{}` with parentheses `()`

```bash
tr "{}" "()" < input.txt > output.txt
```

✅ Every `{` becomes `(` and every `}` becomes `)`.

---

### 5. Squeeze repeated spaces (`-s`)

```bash
echo "Welcome    To    GeeksforGeeks" | tr -s " "
# or
tr -s " " <<< "Welcome    To    GeeksforGeeks"

echo "aaabbbccc" | tr -s "a"
# abbbccc

```

✅ Converts multiple spaces into a single space.

---

### 6. Delete characters (`-d`)

```bash
echo "Welcome To GeeksforGeeks" | tr -d W
# or
tr -d W <<< "Welcome To GeeksforGeeks"

echo "hello" | tr -d "h"
# ello

```

✅ Removes the character `W`.

---

### 7. Delete digits

```bash
echo "My ID is 73535" | tr -d [:digit:]
# or
tr -d [:digit:] <<< "My ID is 73535"
```

✅ Removes all digits.

---

### 8. Complement (`-c`)

```bash
echo "My ID is 73535" | tr -cd [:digit:]
# or
tr -cd [:digit:] <<< "My ID is 73535"
```

✅ Removes everything **except digits** (output: `73535`).

---

### 9. Remove newlines

```bash
echo -e "hello\nworld" | tr -d '\n'
```

✅ Output:

```
helloworld
```

---

### 10. Replace multiple characters at once

```bash
echo "12345" | tr "123" "abc"
```

✅ Output:

```
abc45
```

---

### 11. Using ranges

```bash
echo "abcdef" | tr "a-f" "A-F"
```

✅ Output:

```
ABCDEF
```

---

### 12. Truncate with `-t`

```bash
echo "123456" | tr -t "123" "ab"

echo "abc" | tr -t "abc" "12"
# 12c   (c unchanged because SET2 shorter)

```

✅ Output:

```
ab3456
```

(Since `SET2` is shorter, extra characters from `SET1` are truncated).

### 13. Replace Characters
```
echo "12345" | tr 123 987
# 98745
```

### 14. Print Words Line by Line
```
cat file.txt | tr -cs "[:alnum:]" "\n"
```
(Non-alphanumeric replaced with newline)

### 15. Save Output to File
```
cat input.txt | tr -d [:digit:] > clean.txt
```

---

## 🔹 Summary Cheat Sheet

| Option                   | Meaning                         | Example         | Output                  |         |
| ------------------------ | ------------------------------- | --------------- | ----------------------- | ------- |
| `tr [a-z] [A-Z]`         | Translate lowercase → uppercase | `echo hello     | tr [a-z] [A-Z]`         | `HELLO` |
| `tr [:upper:] [:lower:]` | Translate uppercase → lowercase | `echo HELLO     | tr [:upper:] [:lower:]` | `hello` |
| `tr -s " "`              | Squeeze spaces                  | `echo "a   b"   | tr -s " "`              | `a b`   |
| `tr -d "X"`              | Delete character                | `echo AXB       | tr -d X`                | `AB`    |
| `tr -d [:digit:]`        | Delete digits                   | `echo ab123     | tr -d [:digit:]`        | `ab`    |
| `tr -cd [:digit:]`       | Keep only digits                | `echo "id 42"   | tr -cd [:digit:]`       | `42`    |
| `tr "{}" "()"`           | Translate braces → parens       | `echo "{x}"     | tr "{}" "()"`           | `(x)`   |
| `tr -d '\n'`             | Remove newlines                 | `echo -e "a\nb" | tr -d '\n'`             | `ab`    |

### References
- https://www.geeksforgeeks.org/linux-unix/tr-command-in-unix-linux-with-examples/
- https://phoenixnap.com/kb/linux-tr

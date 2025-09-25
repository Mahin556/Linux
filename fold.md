# 🔹 Linux `fold` Command – Complete Guide

The `fold` command in Linux is used to **wrap or truncate lines** in a file or input to a specified width, improving readability.

---

## 🔹 Syntax

```bash
fold [OPTIONS] [FILE]
```

* If **no file** is specified, `fold` reads from **stdin**.
* By default, lines are **wrapped at 80 columns**.

---

## 🔹 Options

| Option      | Description                                                                    |
| ----------- | ------------------------------------------------------------------------------ |
| `-w N`      | Wrap lines at width `N` columns. Default is 80.                                |
| `-b N`      | Wrap lines at `N` bytes rather than columns (useful for multibyte characters). |
| `-s`        | Break lines at spaces (do not split words if possible).                        |
| `--help`    | Display help information.                                                      |
| `--version` | Display version information.                                                   |

---

## 🔹 Detailed Explanation of Options

### 1. **Wrap Lines to a Specific Width (`-w`)**

```bash
fold -w 60 GfG.txt
```

✅ Wraps text at **60 columns** instead of the default 80.

---

### 2. **Wrap by Bytes (`-b`)**

```bash
fold -b 40 GfG.txt
```

✅ Wrap lines **at 40 bytes**, counting byte length instead of character columns.
Useful when dealing with **multibyte or wide characters**.

---

### 3. **Break at Spaces (`-s`)**

```bash
fold -w 50 -s GfG.txt
```

✅ Ensures lines break at the **last space within the width**, avoiding splitting words.

Comparison:

* Without `-s` → words may be split across lines.
* With `-s` → lines only break at spaces.

---

### 4. **Read from Standard Input**

```bash
echo "This is a very long sentence that needs to be wrapped" | fold -w 20
```

✅ Wraps the input **at 20 columns**.

---

### 5. **Combination: Bytes + Spaces**

```bash
fold -b 40 -s GfG.txt
```

✅ Wrap lines **at 40 bytes**, breaking at spaces to avoid splitting words.

---

## 🔹 Real-World Use Cases

1. **Make long log files readable**:

```bash
fold -w 100 server.log | less
```

2. **Format text for printing**:

```bash
fold -w 80 report.txt > report_formatted.txt
```

3. **Prepare email content**:

```bash
cat message.txt | fold -w 72 > email_body.txt
```

4. **Display large single-line data in terminal**:

```bash
fold -w 50 huge_data.csv
```

5. **Avoid word splits when wrapping**:

```bash
fold -w 60 -s article.txt
```

---

## 🔹 Key Points

* Default width = **80 columns**.
* `-s` is essential for **human-readable text** (avoids mid-word breaks).
* `-b` is important for **byte-accurate wrapping**, e.g., UTF-8 multibyte characters.
* Works well in **pipes** with other commands:

```bash
cat file.txt | fold -w 70 | less
```

---

## 🔹 Examples Summary

| Command                 | Description                          |                                 |                                 |
| ----------------------- | ------------------------------------ | ------------------------------- | ------------------------------- |
| `fold GfG.txt`          | Wrap at 80 columns (default).        |                                 |                                 |
| `fold -w 60 GfG.txt`    | Wrap at 60 columns.                  |                                 |                                 |
| `fold -b 40 GfG.txt`    | Wrap at 40 bytes.                    |                                 |                                 |
| `fold -w 50 -s GfG.txt` | Wrap at 50 columns, break at spaces. |                                 |                                 |
| `echo "Long sentence"   | fold -w 20`                          | Wrap stdin input at 20 columns. |                                 |
| `cat file.txt           | fold -w 70                           | less`                           | View wrapped text page by page. |


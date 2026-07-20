# `icdiff` — Side-by-Side Diff with Color Coding

`icdiff` enhances the traditional `diff` command with side-by-side comparison and color highlighting.

---

## Installation

```bash
sudo apt install icdiff        # Debian/Ubuntu
sudo yum install icdiff        # RHEL/CentOS
sudo pacman -S icdiff          # Arch Linux
pip install icdiff             # via Python pip
```

---

## Basic Comparison

```bash
icdiff file1.txt file2.txt
```

Output displays two columns side by side:
- **Red** — deletions (left side)
- **Green** — additions (right side)
- **Yellow** — conflicts/changes

---

## Options

### Show Line Numbers

```bash
icdiff --line-numbers file1.txt file2.txt
```

### Recursive Directory Comparison

```bash
icdiff --recursive dir1 dir2
```

### Other Useful Options

```bash
icdiff --cols=200 file1.txt file2.txt        # Set output width (default: 80)
icdiff --no-headers file1.txt file2.txt      # Hide filename headers
icdiff --strip-trailing-cr file1.txt file2.txt   # Ignore Windows line endings
icdiff -U 5 file1.txt file2.txt             # Show 5 lines of context (default: 3)
icdiff --whole-file file1.txt file2.txt      # Show entire file, not just diffs
icdiff --highlight file1.txt file2.txt       # Highlight changed characters within a line
```

---

## Git Integration

Add to `~/.gitconfig`:

```ini
[diff]
    tool = icdiff
[difftool "icdiff"]
    cmd = icdiff --line-numbers "$LOCAL" "$REMOTE"
```

Then use it with:

```bash
git difftool file.txt
```

---

## vs Traditional `diff`

| Feature | `diff` | `icdiff` |
|---|---|---|
| Output style | Line-by-line | Side-by-side |
| Color coding | No | Yes |
| Git integration | Built-in | Manual config |
| Readability | Low | High |
| Line numbers | `-n` flag | `--line-numbers` |

---

**Tip:** Use `--cols=$(tput cols)` to auto-match your terminal width:
```bash
icdiff --cols=$(tput cols) file1.txt file2.txt
```
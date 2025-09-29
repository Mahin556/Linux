- In Linux, some commands exist as shell built-ins (handled inside the shell like bash, zsh, etc.) and some as external binaries (like /bin/ls, /usr/bin/cat).
- `type` command is used to find weather command is built-in or external
```bash
type
```
#### Examples
```bash
type echo
```
Example output if it’s a built-in:
```bash
echo is a shell builtin
```
If it’s an external binary:
```bash
ls is /bin/ls
```

#### Other ways
##### Using command -V(Works like type)
```bash
command -V echo
```

##### Using `which` (external binary only)
```bash
which
```
- If it shows a path (/bin/echo), then that’s the binary.
- But note: which won’t tell you if it’s a built-in — it only searches $PATH.

##### Using `builtin` keyword
```bash
builtin echo "hello"
```
- If it works, then echo is built-in.
- If not, it’s not available as a built-in.

##### Checking all built-ins
```bash
help
compgen -b
```
- This lists all shell built-ins for the current shell.

##### Example in Bash:
```bash
type echo    # shell builtin
type pwd     # shell builtin
type ls      # /bin/ls (external)
type cat     # /bin/cat (external)
```


**Navigation & Editing**

* `Ctrl + A` → Move to **beginning of line**
* `Ctrl + E` → Move to **end of line**
* `Ctrl + U` → Cut from **cursor to start of line**
* `Ctrl + K` → Cut from **cursor to end of line**
* `Ctrl + W` → Cut word **before cursor**
* `Alt + D` → Cut word **after cursor**
* `Ctrl + Y` → **Paste (yank)** the last cut text
* `Alt + Y` → Cycle through previously cut text after `Ctrl+Y`
* `Ctrl + L` → Clear screen (same as `clear`)
* `Ctrl + _` → Undo last editing action
* `Ctrl + Shift + C` -> Copy the selected text or command
* `Ctrl + Shift + V` -> Paste copied text or command
* `Ctrl + Shift + N` -> Open a new terminal window
* `Ctrl + Shift + T` -> Open a new tab in the terminal
* `Ctrl + Tabor/Ctrl + PageDown` -> Switch between terminal tabs
---

**Movement by words**

* `Alt + B` → Move cursor **back one word**
* `Alt + F` → Move cursor **forward one word**

---

**Command Control**

* `Ctrl + C` → Kill the running process
* `Ctrl + Z` → Suspend process (send to background)
* `fg` → Resume suspended process in foreground
* `bg` → Resume suspended process in background
* `Ctrl + D` → Logout / End of input (EOF)
* `Ctrl + \` → Quit and **core dump** (force kill)

---

**History & Search**

* `Ctrl + R` → Reverse search in history (`(reverse-i-search)`)
* `Ctrl + G` → Cancel search
* `Ctrl + P` → Previous command (like ↑ arrow)
* `Ctrl + N` → Next command (like ↓ arrow)
* `!!` → Run **last command** again
* `!abc` → Run most recent command starting with `abc`
* `!$` → Last argument of previous command
* `!*` → All arguments of previous command

---

**Screen / Terminal**

* `Ctrl + S` → Stop output to screen (freeze)
* `Ctrl + Q` → Resume screen output
* `Ctrl + L` → Clear terminal screen
* `Ctrl + D` → Close terminal / logout if prompt is empty

---

**Process Management (with jobs)**

* `jobs` → Show suspended/background jobs
* `fg %1` → Bring job 1 to foreground
* `bg %1` → Continue job 1 in background
* `disown %1` → Remove job from shell’s job table

---

**Other Handy Shortcuts**

* `Tab` → Autocomplete command/file
* `Tab + Tab` → List all possible completions
* `Esc + .` → Insert last argument of previous command
* `Ctrl + T` → Swap characters at cursor (transpose)
* `Alt + T` → Swap current and previous word
* `Alt + U` → Uppercase from cursor to end of word
* `Alt + L` → Lowercase from cursor to end of word
* `Alt + C` → Capitalize word at cursor


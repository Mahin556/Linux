Vim has a *huge* number of shortcuts (also called keybindings, commands, or motions). To make it easier, I’ll give you a **comprehensive categorized list**.

---

### **Modes in Vim**

* `Esc` → Switch to **Normal mode**
* `i` → Insert mode (before cursor)
* `I` → Insert mode at beginning of line
* `a` → Insert mode (after cursor)
* `A` → Insert mode at end of line
* `o` → Insert new line below, enter insert mode
* `O` → Insert new line above, enter insert mode
* `v` → Visual mode (character-wise)
* `V` → Visual line mode
* `Ctrl+v` → Visual block mode
* `R` → Replace mode
* `:q` → Quit
* `:w` → Save
* `:wq` / `:x` → Save & quit
* `:q!` → Quit without saving
* `ZZ` → Save & quit
* `ZQ` → Quit without saving

---

### **Moving Around**

* `h` → Left
* `l` → Right
* `0` → Start of line
* `^` → First non-blank character
* `$` → End of line
* `w` → Next word
* `e` → End of word
* `b` → Beginning of word
* `ge` → End of previous word
* `Ctrl+f` → Page forward
* `Ctrl+b` → Page backward
* `Ctrl+d` → Half-page down
* `Ctrl+u` → Half-page up
* `gg` → Beginning of file
* `G` → End of file
* `{` → Beginning of paragraph
* `}` → End of paragraph
* `H` → Top of screen
* `M` → Middle of screen
* `L` → Bottom of screen
* `zt` → Current line to top
* `zz` → Current line to middle
* `zb` → Current line to bottom

---

### **Editing**

* `x` → Delete character
* `X` → Delete before cursor
* `dw` → Delete word
* `dd` → Delete line
* `D` → Delete from cursor to end of line
* `u` → Undo
* `Ctrl+r` → Redo
* `yy` → Yank (copy) line
* `yw` → Yank word
* `p` → Paste after cursor
* `P` → Paste before cursor
* `cw` → Change word
* `cc` → Change whole line
* `C` → Change to end of line
* `r<char>` → Replace one character
* `~` → Toggle case
* `J` → Join next line

---

### **Search & Replace**

* `/text` → Search forward for “text”
* `?text` → Search backward for “text”
* `n` → Repeat search in same direction
* `N` → Repeat search in opposite direction
* `*` → Search for word under cursor forward
* `#` → Search for word under cursor backward
* `:%s/old/new/g` → Replace all in file
* `:s/old/new/g` → Replace in current line

---

### **Visual Mode Operations**

* `y` → Yank
* `d` → Delete
* `c` → Change
* `>` → Indent right
* `<` → Indent left
* `=` → Auto-indent
* `~` → Toggle case

---

### **Buffers, Windows, Tabs**

* `:e filename` → Open file
* `:bn` → Next buffer
* `:bp` → Previous buffer
* `:bd` → Delete buffer
* `:sp filename` → Split window horizontally
* `:vsp filename` → Split window vertically
* `Ctrl+w h/j/k/l` → Switch between splits
* `Ctrl+w c` → Close window
* `Ctrl+w o` → Close all other windows
* `:tabnew` → New tab
* `:tabn` → Next tab
* `:tabp` → Previous tab
* `:tabc` → Close tab

---

### **Marks & Jumps**

* `m[a-z]` → Set mark
* `` `[a-z]`` → Jump to mark
* `''` → Jump back to last line
* ```→ Jump back to last exact position
  ```
* `Ctrl+o` → Jump older in jump list
* `Ctrl+i` → Jump newer in jump list

---

### **Macros**

* `q[a-z]` → Start recording into register
* `q` → Stop recording
* `@[a-z]` → Play macro
* `@@` → Repeat last macro

---

### **Ex Commands**

* `:!command` → Run shell command
* `:r filename` → Read file into buffer
* `:w filename` → Save as filename
* `:set number` → Show line numbers
* `:set nonumber` → Hide line numbers
* `:syntax on` → Enable syntax highlighting
* `:syntax off` → Disable syntax highlighting

---

This covers **the majority of Vim shortcuts** you’ll use daily.

👉 Do you want me to also give you a **one-page Vim cheat sheet style table (compact and printable)**, or a **very detailed “every single key combination” list** (which is massive and hard to memorize)?

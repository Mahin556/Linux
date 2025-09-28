### **Control Sequences**

* **Definition**: Special strings of characters (starting with an escape character) that **tell the terminal to do something other than just print text**.
* **Why they exist**:

  * Normal characters → show up as text.
  * Control sequences → control the terminal (move cursor, change color, clear screen, reset, etc.).

---

### **Structure of a Control Sequence**

* Most follow **ANSI escape sequence** format:

  * Begins with **ESC** (`\033` or `0x1B`).
  * Followed by `[` (called CSI = Control Sequence Introducer).
  * Then parameters + command letter.

Example:

```
\033[31m   → set text to red
\033[0m    → reset color
\033[2J    → clear the screen
\033c      → full reset
```

---

### **Types of Control Sequences**

1. **Cursor movement**

   * `\033[A` → move cursor up
   * `\033[H` → move cursor to top-left

2. **Screen control**

   * `\033[2J` → clear entire screen
   * `\033[K` → clear to end of line

3. **Text style and colors**

   * `\033[1m` → bold text
   * `\033[31m` → red text
   * `\033[44m` → blue background

4. **Reset / Initialization**

   * `\033c` → full terminal reset

---

### **Where Control Sequences Come From**

* **terminfo**: Maps higher-level commands (like `tput clear`) to the correct control sequences for your terminal.
* **xterm** (and others): Define which control sequences they understand.
* **tput / clear / reset**: Use terminfo → send control sequences to terminal.

---

### **In Plain Words**

* Think of control sequences as **hidden “instructions” inside the text stream**.
* Instead of showing a character, they **control the behavior** of the terminal.
* Example:

  ```bash
  echo -e "Hello\033[31m RED \033[0m World"
  ```

  * Prints `Hello RED World`, with **RED** in red color.

---

## Components

### **1. terminfo**

* **Definition**: A database that describes how different terminals work.
* **Purpose**: Since not all terminals (xterm, vt100, screen, tmux, etc.) understand the same control sequences, `terminfo` provides a translation.
* **Location**: Usually stored in `/usr/share/terminfo/`.
* **Usage**: Commands like `clear`, `tput`, and `reset` read `$TERM` (your terminal type) and use `terminfo` to figure out what sequences to send.

Example:

```bash
echo $TERM
# might output: xterm-256color
```

---

### **2. xterm**

* **Definition**: A terminal emulator for the X Window System (graphical Linux/Unix).
* **Role**: Provides the window where shell runs.
* **Why important**: Many modern terminals (like GNOME Terminal, Konsole, Alacritty) are compatible with **xterm** control sequences.
* **Variants**:

  * `xterm` → basic terminal
  * `xterm-256color` → supports 256 colors
  * `xterm-direct` → supports “true color” (24-bit)

---

### **3. tput reset**

* **`tput`** = a command that uses `terminfo` to send control sequences.
* `tput reset` = uses the `reset` capability from the terminfo database.
* Effect: Same as `reset`, but more portable (works across various terminal types).

Example:

```bash
tput clear   # just clears screen
tput reset   # resets terminal fully
```

---

### **4. ANSI Escape Code**

* **Definition**: Special character sequences that control the terminal (cursor movement, colors, clearing, etc.).
* **Format**: Starts with `\033` (ESC) followed by `[` and codes.
* Examples:

  * `\033c` → full reset (hard reset)
  * `\033[2J` → clear screen
  * `\033[31m` → set text color red
* Many tools (like `echo -e`, `printf`) can send these codes directly.

---

### **5. Sane Terminal**

* **Definition**: A terminal in a usable, standard state.
* **Symptoms of “insane” terminal**:

  * Keys not working (Backspace, Enter).
  * Echo disabled (you type but nothing appears).
  * Colors/modes scrambled.
* **Why it happens**: Running a binary file, wrong escape codes, or software crashes that mess with terminal settings.

---

### **6. Sane Terminal Settings**

* Restored by:

  * `stty sane` → resets basic terminal modes.
  * Fixes things like:

    * Echo (characters show as you type).
    * Canonical mode (line editing enabled).
    * Proper signal handling (Ctrl+C, Ctrl+Z).

Example:

```bash
stty sane
```

Good when terminal is broken but you don’t want to **fully reset**.

---

### **7. Fully Resetting (via `reset` or `printf '\033c'`)**

* **Meaning**: Bringing the terminal back to initial power-on state.
* Actions performed:

  * Clears screen + scrollback.
  * Resets colors and fonts.
  * Restores echo, line discipline, signals.
  * Re-applies `$TERM` settings from `terminfo`.
* Use case: When your terminal is **completely unusable or scrambled**.

---

✅ **Summary in One Line Each**

* **terminfo** → database of terminal capabilities.
* **xterm** → popular terminal emulator (and compatibility standard).
* **tput reset** → reset via terminfo (portable).
* **ANSI escape code** → low-level sequences that control terminal.
* **sane terminal** → working state of terminal.
* **sane settings** → basic usable configuration (fix keys, echo).
* **fully resetting** → wipe everything and reinitialize terminal.

---

## Working

### **1. Terminal = Just a Text Interpreter**

* Your shell (`bash`, `zsh`, etc.) runs inside a **terminal emulator** (like xterm, gnome-terminal, tmux).
* The terminal receives a stream of **characters** from programs.

  * Normal letters → displayed as text.
  * Special **control sequences** → change how the terminal behaves (move cursor, change colors, clear screen).

---

### **2. ANSI Escape Codes = Raw Instructions**

* Example:

  ```bash
  echo -e "\033[31mHello\033[0m"
  ```

  * `\033` = ESC character.
  * `[31m` = set text to **red**.
  * `[0m` = reset color.
* The terminal reads this sequence and instead of showing “`[31m`”, it **changes color mode** internally.

---

### **3. terminfo = Translator**

* Problem: Not all terminals understand the same codes.

  * `xterm`, `vt100`, `linux console` → may differ.
* **terminfo database** maps capabilities (like "clear screen") to the right escape sequence for each terminal.
* Example:

  * `clear` command → asks terminfo for "clear-screen" capability of `$TERM`.
  * terminfo says:

    * for `xterm`: use `\033[H\033[2J`
    * for `vt100`: use `\032` (different code)
  * `clear` sends the right one.

---

### **4. tput = Portable Interface**

* `tput` is a command that queries **terminfo**.
* Example:

  ```bash
  tput clear
  ```

  * Looks up "clear" in terminfo.
  * Prints the correct ANSI escape sequence.
  * Terminal receives it → screen clears.

So `tput` is like a **universal remote** that always sends the correct “signal” for your terminal.

---

### **5. reset = Full Reinitialization**

* `reset` uses terminfo’s “reset” capability.
* Sends sequences that:

  * Clear screen.
  * Reset colors and font modes.
  * Restore keyboard echo, line wrapping, Ctrl+C handling, etc.
* If your terminal got “corrupted” (after printing binary data), `reset` **restores it to a clean usable state**.

---

### **6. stty sane = Minimal Fix**

* `stty` works at **line discipline level** (kernel terminal driver).
* `stty sane` resets basic things:

  * Echo on (you see what you type).
  * Newline works correctly.
  * Signals like Ctrl+C enabled.
* Doesn’t redraw the screen — just fixes keyboard I/O behavior.

---

### **7. The Flow (Step by Step)**

1. You type `clear`.
2. Shell finds `/usr/bin/clear`.
3. `clear` → asks **terminfo**: “What’s the code for clear-screen for `$TERM`?”
4. terminfo returns escape sequence (e.g., `\033[H\033[2J`).
5. `clear` writes this sequence to STDOUT.
6. Terminal emulator receives it and **executes it** → screen clears.

---

✅ **In one line**:

* Programs like `clear`, `reset`, `tput` → ask `terminfo` → get escape codes → terminal interprets them → changes its display/behavior.

### References:
- https://www.gnu.org/software/screen/manual/html_node/Control-Sequences.html
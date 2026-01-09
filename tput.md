```
======================== TPUT COMMAND – COMPLETE DETAILED GUIDE ========================

WHAT IS tput
tput is a command-line utility used to control terminal display capabilities.
It interacts with the terminfo database to send the correct control sequences
for the current terminal type.

Instead of hardcoding ANSI escape sequences, tput queries terminal capabilities,
making scripts portable across different terminals.

tput is part of the ncurses/terminfo system.

----------------------------------------------------------------------------------

WHY tput IS IMPORTANT
- Portable across terminal types
- Safer than hardcoding ANSI codes
- Works with xterm, gnome-terminal, tmux, screen, ssh
- Ideal for professional shell scripts and CLI tools

----------------------------------------------------------------------------------

HOW tput WORKS
1. Reads terminal type from $TERM
2. Looks up capabilities in terminfo database
3. Outputs correct escape sequence
4. Terminal interprets and applies it

----------------------------------------------------------------------------------

BASIC SYNTAX
tput [options] capability [parameters]

----------------------------------------------------------------------------------

COMMONLY USED tput CAPABILITIES

CLEAR SCREEN
tput clear

RESET TERMINAL
tput reset
tput sgr0        # reset text attributes only

----------------------------------------------------------------------------------

TEXT FORMATTING

Bold text:
tput bold

Underline text:
tput smul

Disable underline:
tput rmul

Reverse video (swap fg/bg):
tput rev

----------------------------------------------------------------------------------

FOREGROUND COLORS (setaf)

Syntax:
tput setaf N

Common color values:
0 → Black
1 → Red
2 → Green
3 → Yellow
4 → Blue
5 → Magenta
6 → Cyan
7 → White

Example:
tput setaf 2
echo "Green Text"
tput sgr0

----------------------------------------------------------------------------------

BACKGROUND COLORS (setab)

Syntax:
tput setab N

Example:
tput setab 4
echo "Blue Background"
tput sgr0

----------------------------------------------------------------------------------

256 COLORS SUPPORT

Foreground:
tput setaf 0–255

Background:
tput setab 0–255

Example:
tput setaf 196
tput setab 232
echo "Bright Red on Dark Background"
tput sgr0

----------------------------------------------------------------------------------

CURSOR MOVEMENT

Move cursor to row, column:
tput cup ROW COL

Example:
tput cup 10 20
echo "Text at position"

Save cursor position:
tput sc

Restore cursor position:
tput rc

----------------------------------------------------------------------------------

TERMINAL SIZE

Number of columns:
tput cols

Number of lines:
tput lines

----------------------------------------------------------------------------------

ERASING CONTENT

Clear current line:
tput el

Clear screen:
tput clear

----------------------------------------------------------------------------------

COMBINING tput WITH echo / printf

Example:
tput setaf 3
tput bold
echo "Bold Yellow Text"
tput sgr0

----------------------------------------------------------------------------------

USING tput IN SCRIPTS (BEST PRACTICE)

#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

printf "%sSuccess%s\n" "$GREEN" "$RESET"
printf "%sError%s\n" "$RED" "$RESET"

----------------------------------------------------------------------------------

OPTIONS

-S   Read commands from stdin
-T   Use specified terminal type instead of $TERM
-V   Print ncurses version
-x   Do not clear scrollback

----------------------------------------------------------------------------------

EXIT STATUS

0 → Successful execution
1 → General error
2 → Unsupported or invalid capability

----------------------------------------------------------------------------------

COMMON MISTAKES

- Forgetting to reset colors (sgr0)
- Using tput in non-interactive output (logs)
- Assuming terminal supports colors

----------------------------------------------------------------------------------

WHEN TO USE tput VS ANSI CODES

Use tput when:
- Writing production scripts
- Supporting multiple terminal types
- Building CLI tools

Use ANSI codes when:
- Quick testing
- One-liners
- Learning purposes

----------------------------------------------------------------------------------

CHECK TERMINAL COLOR SUPPORT

Number of colors supported:
tput colors

----------------------------------------------------------------------------------

SUMMARY

- tput controls terminal appearance
- Uses terminfo database
- Portable and reliable
- Supports colors, cursor movement, screen clearing
- Preferred for professional shell scripts

======================== END OF TPUT COMMAND GUIDE ========================
```

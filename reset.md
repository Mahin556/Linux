- `reset` is used to reinitialize the terminal.
- Unlike `clear` (which only clears the screen), `reset` restores the terminal to a sane working state if it gets messed up (e.g., when binary/garbage data is displayed, or the screen looks corrupted).
- It re-reads terminal settings from `terminfo` and resets the terminal according to the `$TERM` environment variable.
```bash
reset #Clear and Resets terminal modes (like line wrapping, echoing, etc.).
reset -T xterm #Force terminal type instead of using $TERM.
reset -V #Print version of ncurses.
reset -I #Not clear just reinitialize
printf '\033c' #Sending ANSI escape code (hard reset):
tput reset #Uses terminfo to reset terminal.
```

### When to Use reset
- When the terminal shows garbled output (like weird characters after running a binary).
- When Backspace or Enter stops working correctly.
- When terminal colors or prompts are broken.
- When you accidentally cat a binary file and it messes up your terminal.
- If you want a fresh terminal environment, not just a clean screen.
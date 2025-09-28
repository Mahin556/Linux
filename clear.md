```bash
clear #This clears the terminal screen.
clear -T xterm #Force the terminal type to type (instead of using $TERM environment variable).
clear -v #-v or --version
clear -x #Do not attempt to clear scrollback buffer (only clears the visible screen).
printf "\ec"
```

### Environment Variables that Affect clear
- $TERM → tells clear what type of terminal you are using.
- If $TERM is not set, clear might not work properly.

### Keyboard shortcuts:
```bash
ctrl+L → same as clear in most terminals.
```

### References:
- https://man7.org/linux/man-pages/man1/clear.1.html
- https://www.geeksforgeeks.org/linux-unix/clear-command-in-linux-with-examples/
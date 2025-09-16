### What is Tmux?
```How to Use 'Tmux Terminal' to Access Multiple Terminals ...Tmux is an open-source command-line utility called a "terminal multiplexer" for Unix-like operating systems that allows you to manage multiple terminal sessions, windows, and panes within a single terminal window. Its core function is to create, split, and manage multiple terminal "sessions," which can then be "detached" (left running in the background) and "reattached" later, even on a different terminal or after a network disconnection. This makes it invaluable for developers and system administrators to run long processes, work on remote servers, and organize complex workflows without losing work.```

### Key features and benefits:
```
Multitasking: Run multiple programs or commands side-by-side in different panes or windows within a single terminal. 
Session management: Create and name sessions for different projects or tasks, allowing you to switch between them quickly. 
Detaching and reattaching: Keep processes running in the background even if you close the terminal or lose your network connection. You can then reattach to the session later to pick up where you left off. 
Remote session stability: Ideal for working on remote servers via SSH. If your connection drops, your tmux sessions continue to run on the server, and you can simply re-log in and reattach to them. 
Increased productivity: By keeping all your work organized and accessible in one place, tmux helps reduce the need to switch between separate windows or applications. 
Organization: Sessions, windows, and panes serve as building blocks to organize your work into logical units. 
```

### How it works (basics):
```
Session: The primary container for multiple windows. 
Window: A single "tab" or screen within a session where you can run programs. 
Pane: A subdivision of a window that creates a separate, independent terminal within that window. 
```

## Commands

```
apt-get install tmux
tmux #to create a new session
tmux new -s bob #to create a named session
ctrl+b then d #to detach from the tmux session
tmux a or attach #to attach to the latest tmux session
tmux ls #to list all the session
tmux attach -t <name_of_session> #to attach to the session by name
tmux kill-session -t <name_of_session> #to kill a session
ctrl+b ---> prefix key
  d ---> detatch
  % ---> pane
  
```


By default, `Ctrl+b` is the **prefix key** before most commands. (You can change it in your config.)

---

### **1. Session Management**

* `tmux` → Start a new session
* `tmux new -s <name>` → Start a new session with a name
* `tmux ls` or `tmux list-sessions` → List sessions
* `tmux attach -t <name>` or `tmux a -t <name>` → Attach to a session
* `tmux detach` (`prefix d`) → Detach from current session
* `tmux kill-session -t <name>` → Kill a session
* `tmux kill-server` → Kill all sessions
* `tmux rename-session <new-name>` (`prefix $`) → Rename current session
* `tmux switch -t <name>` → Switch to another session

---

### **2. Window Management**

* `prefix c` → Create a new window
* `prefix ,` → Rename current window
* `prefix w` → List windows and choose
* `prefix n` → Next window
* `prefix p` → Previous window
* `prefix 0–9` → Switch to window by number
* `prefix &` → Kill current window
* `tmux kill-window -t <target>` → Kill specific window
* `tmux list-windows` → List windows in current session

---

### **3. Pane Management**

* `prefix %` → Split vertically (left/right)
* `prefix "` → Split horizontally (top/bottom)
* `prefix o` → Switch to next pane
* `prefix q` → Show pane numbers
* `prefix {` → Swap current pane with previous
* `prefix }` → Swap current pane with next
* `prefix x` → Kill current pane
* `prefix !` → Break pane into a new window
* `prefix Ctrl+o` → Rotate panes
* `tmux split-window -h` → Split horizontally (command)
* `tmux split-window -v` → Split vertically (command)

---

### **4. Pane Resizing**

* `prefix : resize-pane -U <n>` → Resize up
* `prefix : resize-pane -D <n>` → Resize down
* `prefix : resize-pane -L <n>` → Resize left
* `prefix : resize-pane -R <n>` → Resize right
* `prefix Alt+↑/↓/←/→` (if enabled) → Resize with arrow keys

---

### **5. Copy & Scroll Mode**

* `prefix [` → Enter copy mode
* `prefix ]` → Paste buffer
* In copy mode:

  * Arrow keys / PgUp / PgDn → Scroll
  * `Space` → Start selection
  * `Enter` → Copy selection
  * `q` → Quit copy mode

---

### **6. Synchronize Panes**

* `prefix : setw synchronize-panes on` → Send input to all panes
* `prefix : setw synchronize-panes off` → Disable

---

### **7. Buffers & Clipboard**

* `tmux list-buffers` → Show copy buffers
* `tmux show-buffer` → Show last buffer
* `tmux save-buffer <file>` → Save buffer to file
* `tmux load-buffer <file>` → Load buffer from file
* `tmux paste-buffer` → Paste last buffer

---

### **8. Miscellaneous**

* `prefix t` → Show clock
* `prefix ?` → Show key bindings
* `prefix :` → Enter command mode
* `prefix r` → Reload configuration file (after editing `~/.tmux.conf`)
* `tmux source-file ~/.tmux.conf` → Reload config from shell
* `prefix Ctrl+z` → Suspend tmux (return with `fg`)

---

### **9. Useful Commands for Config**

* `set -g mouse on` → Enable mouse support
* `set -g history-limit 10000` → Increase scrollback buffer
* `bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"` → Reload config shortcut





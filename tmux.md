### What is Tmux?
```
- Tmux is an open-source command-line utility called a "terminal multiplexer" for Unix-like operating systems that allows you to manage multiple terminal sessions, windows, and panes within a single terminal window.
- It lets you run and manage multiple terminal sessions inside a single terminal window.
- You can split windows into panes, run different commands in each pane, and switch between them.
- You can detach from a session (keep it running in the background) and reattach later.
- Very useful for remote sessions and long-running tasks because it continues even if the connection drops.
- Provides customization, session sharing, and plugin support to boost productivity.
```

### Key features and benefits:
```
Multitasking: Run multiple programs or commands side-by-side in different panes or windows within a single terminal.

Session management: Create and manage sessions for different projects or tasks, allowing you to switch between them quickly.

Detaching and reattaching: Keep processes running in the background even if you close the terminal or lose your network connection. You can then reattach to the session later to pick up where you left off.

Window Management → Split windows (horizontally/vertically), rename them, and move between them.

Configuration → Customize tmux behavior via ~/.tmux.conf.

Remote session stability: Ideal for working on remote servers via SSH. If your connection drops, your tmux sessions continue to run on the server, and you can simply re-log in and reattach to them.

Increased productivity: By keeping all your work organized and accessible in one place, tmux helps reduce the need to switch between separate windows or applications.

Organization: Sessions, windows, and panes serve as building blocks to organize your work into logical units. 

Integration → Works smoothly with tools like Vim, SSH, etc.

Plugins → Extend functionality using third-party plugins.
```

### Key Features of Tmux
```
- Sessions → Multiple independent sessions, detachable & reattachable.
- Windows → Each session can have multiple windows (like tabs).
- Panes → Split windows into multiple resizable panes for multitasking.
- Customization → Change key bindings, status bar, and behavior.
```

tmux ---> session ----> windows ---> pane

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
* `prefix d` → Detach from current session
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
* `prefix q` → Show pane numbers `prefix q 0` `prefix q 1` `prefix q 2` `prefix q 3` `prefix q 4`
* `prefix {` → Swap current pane with previous
* `prefix }` → Swap current pane with next
* `prefix x` → Kill current pane
* `prefix !` → Break pane into a new window
* `prefix Ctrl+o` → Rotate panes
* `tmux split-window -h` → Split horizontally (command)
* `tmux split-window -v` → Split vertically (command)
* `prefix Arrow Key` -> (Left, Right, Up, Down) — Move between panes

---

### **4. Pane Resizing**

* `prefix : resize-pane -U <n>` → Resize up
* `prefix : resize-pane -D <n>` → Resize down
* `prefix : resize-pane -L <n>` → Resize left
* `prefix : resize-pane -R <n>` → Resize right
* `prefix Alt+↑/↓/←/→` (if enabled) → Resize with arrow keys
* `prefix Alt+1/2/3/4/5` control the layout

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

* `set -g mouse on` → Enable mouse support `tmux set -g mouse on` `Ctrl + b  then  [`
* `set -g history-limit 10000` → Increase scrollback buffer
* `bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"` → Reload config shortcut

---

### 📄 Example `~/.tmux.conf`

```bash
# Use Ctrl+a as prefix instead of default Ctrl+b
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Enable mouse support (scroll, resize panes, switch windows)
set -g mouse on

# Split panes with | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Switch panes easily with Alt+arrow keys
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Resize panes with Ctrl+arrow keys
bind -n C-Left resize-pane -L 3
bind -n C-Right resize-pane -R 3
bind -n C-Up resize-pane -U 1
bind -n C-Down resize-pane -D 1

# Start windows and panes at 1 (not 0)
set -g base-index 1
setw -g pane-base-index 1

# Better status bar
set -g status-bg black
set -g status-fg white
set -g status-interval 5
set -g status-left-length 30
set -g status-right-length 90

#Make mouse scrolling permanent
set -g mouse on


# Show session, window, and pane numbers
set -g status-left '#[fg=green][#S] '
set -g status-right '#[fg=yellow]%Y-%m-%d #[fg=cyan]%H:%M #[fg=magenta]#(whoami)'

# Vi-style key bindings for copy mode
setw -g mode-keys vi
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-selection-and-cancel
bind -T copy-mode-vi r send -X rectangle-toggle

# Reload config quickly with prefix+r
bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"
```

---

### 🚀 How to use

1. Save the config:

   ```bash
   nano ~/.tmux.conf
   ```

   (paste the content, then save).
2. Reload without restarting tmux:

   ```bash
   tmux source-file ~/.tmux.conf
   ```

   or press **Prefix + r** (with the above config).

---

### 🔥 Features in this setup

* Prefix key = **Ctrl+a** (like GNU screen).
* Mouse support (click to switch, drag to resize, scroll).
* Easy pane splitting with `|` and `-`.
* Intuitive navigation/resizing with arrow keys.
* Status bar with date, time, user, and session.
* Vi-style copy mode with **v/y/r**.
* Reload config without killing tmux.



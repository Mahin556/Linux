# `figlet` — ASCII Art Text Generator

---

## Basic Usage

```bash
figlet Hello World
```
```
 _   _      _ _        __        __         _     _
| | | | ___| | | ___   \ \      / /__  _ __| | __| |
| |_| |/ _ \ | |/ _ \   \ \ /\ / / _ \| '__| |/ _` |
|  _  |  __/ | | (_) |   \ V  V / (_) | |  | | (_| |
|_| |_|\___|_|_|\___/     \_/\_/ \___/|_|  |_|\__,_|
```

---

## Fonts

```bash
showfigfonts                              # Preview all available fonts
find /usr/share/figlet -name "*.flf" | sort   # List font file names only
```

```bash
figlet -f slant Hello World
```
```
    __  __     ____         _       __           __    __
   / / / /__  / / /___     | |     / /___  _____/ /___/ /
  / /_/ / _ \/ / / __ \    | | /| / / __ \/ ___/ / __  /
 / __  /  __/ / / /_/ /    | |/ |/ / /_/ / /  / / /_/ /
/_/ /_/\___/_/_/\____/     |__/|__/\____/_/  /_/\__,_/
```

```bash
figlet -f big Hello
```
```
 _   _      _ _
| | | | ___| | | ___
| |_| |/ _ \ | |/ _ \
|  _  |  __/ | | (_) |
|_| |_|\___|_|_|\___/
```

```bash
figlet -f standard Hello         # Default font (same as no -f flag)
```

---

## Width

```bash
figlet -w 50 "Narrow Text"
```
```
 _   _
| \ | | __ _ _ __ _ __ _____      __
|  \| |/ _` | '__| '__/ _ \ \ /\ / /
| |\  | (_| | |  | | | (_) \ V  V /
|_| \_|\__,_|_|  |_|  \___/ \_/\_/

 _____         _
|_   _|____  _| |_
  | |/ _ \ \/ / __|
  | |  __/>  <| |_
  |_|\___/_/\_\\__|
```

```bash
figlet -w 80 "Wide Text Example"
```
```
__        ___     _        _____         _
\ \      / (_) __| | ___  |_   _|____  _| |_
 \ \ /\ / /| |/ _` |/ _ \   | |/ _ \ \/ / __|
  \ V  V / | | (_| |  __/   | |  __/>  <| |_
   \_/\_/  |_|\__,_|\___|   |_|\___/_/\_\\__|

 _____                           _
| ____|_  ____ _ _ __ ___  _ __ | | ___
|  _| \ \/ / _` | '_ ` _ \| '_ \| |/ _ \
| |___ >  < (_| | | | | | | |_) | |  __/
|_____/_/\_\__,_|_| |_| |_| .__/|_|\___|
                           |_|
```

```bash
figlet -w $(tput cols) "Auto Width"    # Match current terminal width
```

---

## Alignment

```bash
figlet -c "Centered Text"             # Center align
figlet -c -f slant "Center Slant"
```
```
             ______           __               _____ __            __
            / ____/__  ____  / /____  _____   / ___// /___ _____  / /_
           / /   / _ \/ __ \/ __/ _ \/ ___/   \__ \/ / __ `/ __ \/ __/
          / /___/  __/ / / / /_/  __/ /      ___/ / / /_/ / / / / /_
          \____/\___/_/ /_/\__/\___/_/      /____/_/\__,_/_/ /_/\__/
```

---

## Text Direction

```bash
figlet -R "Right to Left"
```
```
 _          __ _     _          ____  _       _     _
| |    ___ / _| |_  | |_ ___   |  _ \(_) __ _| |__ | |_
| |   / _ \ |_| __| | __/ _ \  | |_) | |/ _` | '_ \| __|
| |__|  __/  _| |_  | || (_) | |  _ <| | (_| | | | | |_
|_____\___|_|  \__|  \__\___/  |_| \_\_|\__, |_| |_|\__|
                                         |___/
```

```bash
figlet -L "Left to Right"              # Default direction
```

---

## Help

```bash
figlet -h                              # Show all options
```

---

## Terminal Banner Script

```bash
nano ~/banner.sh
```

**Basic banner** (`~/banner.sh`):
```bash
#!/bin/bash
figlet -f slant "Welcome to Linux"
echo "Today is $(date)"
echo "----------------"
echo ""
```

**Personalized banner** (`~/banner.sh`):
```bash
#!/bin/bash
figlet -f slant "Hello, $(whoami)!"
echo "Welcome to Linux - $(date +%A), $(date +%B) $(date +%d)"
echo "----------------"
echo "System: $(uname -s) $(uname -r)"
echo ""
```

```bash
chmod +x ~/banner.sh          # Make executable
~/banner.sh                   # Run it
```

**Output:**
```
 _       __     __                             __
| |     / /__  / /________  ____ ___  ___     / /_____
| | /| / / _ \/ / ___/ __ \/ __ `__ \/ _ \   / __/ __ \
| |/ |/ /  __/ / /__/ /_/ / / / / / /  __/  / /_/ /_/ /
|__/|__/\___/_/\___/\____/_/ /_/ /_/\___/   \__/\____/

Today is Thu Mar  6 10:44:55 CST 2025
----------------
```

**Auto-run on terminal open** — add to `~/.zshrc` or `~/.bashrc`:
```bash
echo '~/banner.sh' >> ~/.zshrc
source ~/.zshrc
```

---

## Quick Reference

| Option | Description |
|---|---|
| `-f <font>` | Use a specific font |
| `-w <cols>` | Set output width |
| `-c` | Center align output |
| `-R` | Right-to-left text |
| `-L` | Left-to-right text (default) |
| `-h` | Show help |

---

**Related tools:** `toilet` (color version of figlet) · `cowsay` · `lolcat` (rainbow colors)
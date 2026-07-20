# Systemd Targets

A systemd target is a special type of unit file (ending in `.target`) that groups other systemd units together and serves as a synchronization point during system bootup, shutdown, or state changes. Instead of executing processes directly, targets establish broad operational states—such as a command-line server environment or a desktop GUI—by acting as a dependency anchor for multiple services, sockets, and mount points.

---

## Target Units vs. Legacy SysV Runlevels

In older Linux distributions using SysVinit, system states were strictly restricted to numbered "runlevels" (e.g., Runlevel 3 for CLI, Runlevel 5 for GUI). While systemd targets provide backward compatibility and map directly to these concepts, they are significantly more flexible:

- **Simultaneous States:** Multiple targets can be active at the same time.
- **Tree Dependencies:** Targets are organized in a flexible, free-form dependency tree rather than a strict 0–6 sequence.
- **Descriptive Names:** They use meaningful names (like `bluetooth.target` or `network.target`) instead of abstract numbers.

---

## Common Predefined Targets

According to the official [freedesktop.org systemd.special documentation](https://www.freedesktop.org/software/systemd/man/systemd.special.html), Linux systems rely on several standardized targets:

| Target Name | SysV Runlevel | Operational State |
|---|---|---|
| `poweroff.target` | Runlevel 0 | Shuts down and completely powers off the machine. |
| `rescue.target` | Runlevel 1 | Launches a single-user rescue shell with minimal services. |
| `multi-user.target` | Runlevel 3 | Fully booted multi-user console environment with networking (typical for servers). |
| `graphical.target` | Runlevel 5 | Fully booted system including a graphical desktop/display manager. |
| `reboot.target` | Runlevel 6 | Shuts down, terminates processes, and reboots the machine. |
| `default.target` | N/A | A symbolic link pointing to whichever target the system boots into by default. |

---

## Essential Management Commands

You can interact with targets using `systemctl`.

**View Active Targets:**
```bash
systemctl list-units --type=target
```

**Check the Default Boot Target:**
```bash
systemctl get-default
```

**Change the Default Boot Target:**

To force your computer to boot directly to the command-line interface instead of the desktop interface:
```bash
sudo systemctl set-default multi-user.target
```

**Switch States Immediately (Without Rebooting):**

Use the `isolate` command to stop all current services and spin up only the dependencies of the new target:
```bash
sudo systemctl isolate graphical.target
```

**Inspect Target Dependencies:**

To see every service or sub-target that a specific target relies on:
```bash
systemctl list-dependencies multi-user.target
```

---

If you are trying to solve a specific issue, tell me:

- What Linux distribution you are running?
- Are you trying to fix a boot issue, change the login environment, or create a custom startup service?

I can provide the exact configuration files or debugging steps you need.
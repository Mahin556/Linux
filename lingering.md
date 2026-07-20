No, a **systemd service does not stop when a user logs out**, provided it is running as a **system service**.

### System Service (`/etc/systemd/system/`)

These services are managed by the system-wide systemd instance (PID 1).

Example:

```bash
sudo systemctl start nginx
```

Even if the user who started it logs out:

```bash
logout
```

The service continues running because it is managed by the system, not by the user's session.

Check:

```bash
systemctl status nginx
```

---

### User Service (`~/.config/systemd/user/`)

Services started with:

```bash
systemctl --user start myservice
```

are tied to the user's systemd instance.

By default, when the user logs out, the user systemd instance may stop, causing the service to stop as well.

Check status:

```bash
systemctl --user status myservice
```

---

### Keep User Services Running After Logout

Enable **lingering**:

```bash
sudo loginctl enable-linger username
```

Verify:

```bash
loginctl show-user username | grep Linger
```

Output:

```text
Linger=yes
```

Now user services can continue running even after logout.

---

### Interview Answer

> System services managed by systemd (`systemctl`) continue running after a user logs out because they are controlled by the system-wide systemd process (PID 1). However, user services started with `systemctl --user` are associated with the user's session and may stop when the user logs out unless user lingering is enabled using `loginctl enable-linger`.

- current user name
```bash
whoami
```
- help
```bash
whoami --help
```
- version
```bash
whoami --version
```
- check user name after `sudo`
```bash
sudo whoami
```
- Print Current User in a Script
```bash
echo "This script is running as $(whoami)"
```
- Check User for Conditional Logic
```bash
if [ "$(whoami)" != "root" ]; then
  echo "You must be root to run this script."
  exit 1
fi
```

- Verify User in Remote SSH Session
```bash
ssh user@remotehost whoami
```

- Debugging with Environment Variables
    You can compare whoami with $USER:
```bash
echo $USER
whoami
```
$USER shows the original login name.
whoami shows the effective username, which may differ if sudo or su was used.

---
### References
- https://www.geeksforgeeks.org/linux-unix/whoami-command-linux-example/
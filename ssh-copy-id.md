* ssh-copy-id is a tool used to copy your public SSH key to a remote Linux server’s:
```bash
~/.ssh/authorized_keys
```
* This enables passwordless SSH login using your private key.

```bash
ssh-copy-id user@server #You will be prompted for the password one last time.
```
* Security Checks Performed by ssh-copy-id
  * Connects using SSH with password
  * Creates `~/.ssh` on remote server (if missing)
  * Appends your public key (id_rsa.pub or id_ed25519.pub) into:
    ```bash
    /home/user/.ssh/authorized_keys
    ```
  * Sets correct permissions:
    ```bash
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_rsa
    chmod 644 ~/.ssh/id_rsa.pub
    chmod 600 ~/.ssh/authorized_keys
    ```
  * Remote account ownership is correct
  * Ensures no duplicate key entries
  * Enables passwordless login afterwards
  * This prevents:
    * MITM attacks
    * SSH refusing connections due to bad permissions

* Always prefer Ed25519 keys
* Disable password authentication after setup
* Use ssh-agent
* Never copy keys manually using copy-paste unless necessary
* Avoid root login—use sudo

| Option      | Description                      |
| ----------- | -------------------------------- |
| `-i <file>` | Specify public key to install    |
| `-p <port>` | SSH port                         |
| `-v`        | Verbose mode                     |
| `-n`        | Dry-run (show what would happen) |
| `-o`        | Pass SSH options                 |
| `-f`        | Force, append even if duplicate  |


```bash
ssh-copy-id -i ~/.ssh/mykey.pub user@server #copy specific key
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server

ssh-copy-id -p 2222 user@server #use non default port

ssh-copy-id -o ProxyJump=bastion@bastion-host user@internal-server #Copy Key to a Server Behind a Bastion Host

ssh-copy-id -n user@server #Not copy --> dry run --> Show what key would be copy

ssh-copy-id -v user@server

cat ~/.ssh/id_rsa.pub | ssh user@server-ip "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"


ssh user@server "sed -i '/YOUR_PUBLIC_KEY_CONTENT/d' ~/.ssh/authorized_keys" #Remove Your Key from Remote Server

```
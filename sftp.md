* SFTP = SSH File Transfer Protocol
* It uses the same encryption and authentication as SSH.
* Encrypted file transfer over SSH
* Uses port 22
* Works with SSH keys
* Highly secure
* Supports resume, mkdir, rm, mget, mput
* No Port 21

| Command          | Meaning                   |
| ---------------- | ------------------------- |
| `ls`             | list files on remote      |
| `lls`            | list files local          |
| `cd`             | change remote directory   |
| `lcd`            | change local directory    |
| `get file`       | download file             |
| `put file`       | upload file               |
| `mget *.log`     | download multiple         |
| `mput *.jpg`     | upload multiple           |
| `mkdir folder`   | make directory (remote)   |
| `chmod 755 file` | change remote permissions |
| `rm file`        | remove remote             |
| `exit`           | quit                      |


```bash
sftp user@server

sftp -i ~/.ssh/id_ed25519 user@server

sftp user@server 
put file.txt #Upload a file
get file.txt ##Download a file

put -r folder/ #Upload Directory (recursive)
get -r backups/ #Download Directory

#Non-Interactive One-Liners
sftp user@server:/backup <<< $'put file.txt' #upload
sftp user@server:/data <<< $'get file.txt' #Download
```
```bash
reget file.iso #Resume Download
reput file.iso #Resume Upload

sftp -P 2222 user@server #use diff port

sftp myserver #user .ssh/config

sftp -o ProxyJump=bastion private #SFTP Through Bastion
```
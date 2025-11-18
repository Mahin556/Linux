```bash
scp file.txt user@server:/home/user/

scp user@server:/home/user/file.txt .

scp -r myfolder user@server:/home/user/ #scp -r user@server:/var/www /tmp/

scp -r user@server:/var/www /tmp/

scp -i ~/.ssh/id_ed25519 file.txt user@server:/home/user/

scp -P 2222 file.txt user@server:/home/user/

scp -v file.txt user@server:/home/user/ #Copy with Progress Bar & Verbose

scp user1@server1:/path/file.txt  user2@server2:/path/ #Copy Between Two Remote Servers (LOCAL MACHINE DOES NOT HANDLE DATA), local machine only to authenticate.

scp -l 1000 file.iso user@server:/home/user/ #Limit Bandwidth (Slow network or avoid server overload)

scp -p file.sh user@server:/home/user/ #Preserve Permissions & Ownership

#Resume Interrupted Transfer (No SCP native support)
rsync -avP file.iso user@server:/home/user/ #SCP cannot resume, BUT we use rsync over SSH, This resumes automatically.

scp -o ProxyJump=bastion file.txt user@private:/path/ #SCP through Bastion

scp -r .config user@server:/home/user/

scp -r .*  user@server:/backup/

scp *.log user@server:/home/user/logs/

scp *.jpg user@server:/var/www/img/

scp file.txt user@server:/home/user/newname.txt #Copy as a specific filename

scp file.sh root@server:/root/

scp file.txt prod:/home/ubuntu/

#Copy Kubernetes config to laptop
scp ubuntu@master:/etc/kubernetes/admin.conf ~/.kube/config

#Move website files to server:
scp -r site/* ubuntu@server:/var/www/html/

#Transfer backups:
scp backup.tar.gz root@server:/backup/

#Sync large datasets:
rsync -avP dataset/ user@server:/data/
```

| Option | Meaning                |
| ------ | ---------------------- |
| `-r`   | recursive (folders)    |
| `-i`   | specify identity file  |
| `-v`   | verbose                |
| `-P`   | port                   |
| `-l`   | limit bandwidth        |
| `-p`   | preserve permissions   |
| `-q`   | quiet                  |
| `-C`   | compression            |
| `-c`   | cipher (AES, ChaCha20) |
| `-o`   | pass SSH options       |


| Tool      | Best For                           |
| --------- | ---------------------------------- |
| **SCP**   | Quick copy, simple transfers       |
| **SFTP**  | Interactive file transfer          |
| **RSYNC** | Huge files, resuming, syncing dirs |

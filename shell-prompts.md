* Prompt is controlled by variable: PS1                                      
* Temporary change → affects current shell only                              
* Permanent change → put PS1 in `~/.bashrc`                                    
* Apply changes → source `~/.bashrc`     


* Common PS1 escape codes                                                    
    ```bash
    • \u  → username                                                             
    • \h  → hostname (short)                                                     
    • \H  → hostname (full)                                                      
    • \w  → full working directory                                               
    • \W  → current directory only                                               
    • \~  → home as ~                                                            
    • \$  → $ (user) or # (root)                                                 
    • \t  → time (HH:MM:SS)                                                      
    • \d  → date                                                                 
    ```

```bash
$
PS1='$ '
```
```bash
#
PS1='# '
```
```bash
user@host$
PS1='\u@\h$ '
```
```bash
[user@host ~]$
PS1='[\u@\h \w]\$ '
```
```bash
user@host:/home/user$
PS1='\u@\h:\w\$ '
```
```bash
root@host:/root#
PS1='\u@\h:\w# '
```
```bash
(env) user@host$
PS1='(env) \u@\h\$ '
```
```bash
(base) user@host$
PS1='(base) \u@\h\$ '
```
```bash
[env] user@host:~$
PS1='[env] \u@\h:\w\$ '
```
```bash
user@host ~/project$
PS1='\u@\h \W\$ '
```
```bash
user@192.168.1.10:/data$
PS1='\u@\H:\w\$ '
```
```bash
[14:32][user@host ~]$
PS1='[\t][\u@\h \w]\$ '
```
```bash
[user@host][OK]$
PS1='[\u@\h][OK]\$ '
```
```bash
[user@host][ERROR]$
PS1='[\u@\h][ERROR]\$ '
```
```bash
user@host (job:12345)$
PS1='\u@\h (job:$SLURM_JOB_ID)\$ '
```
```bash
user@node01 (gpu:1)$
PS1='\u@\h (gpu:1)\$ '
```
```bash
container-id:/#
PS1='\h:\w# '
```
```bash
container-id:/app$
PS1='\h:\w\$ '
```
```bash
chroot:/#
PS1='chroot:\w# '
```
```bash
➜  ~
PS1='➜  \W '
```
```bash
❯
PS1='❯ '
```
```bash
user@host >>>
PS1='\u@\h >>> '
```
```bash
user@host λ
PS1='\u@\h λ '
```
```bash
user@host ⚡
PS1='\u@\h ⚡ '
```
```bash
root@host !
PS1='\u@\h ! '
```
```bash
[user@host][venv][git][time]$
PS1='[\u@\h][venv][git][\t]\$ '
```
```bash
user$
PS1='\u$ '
```
```bash
host$
PS1='\h$ '
```
```bash
user@full-hostname$
PS1='\u@\H$ '
```
```bash
user@host$
PS1='\u@\h$ '
```
```bash
[user@host]$
PS1='[\u@\h]\$ '
```
```bash
[user@host /path]$
PS1='[\u@\h \w]\$ '
```
```bash
user@host:/path$
PS1='\u@\h:\w\$ '
```
```bash
root@host:/root#
PS1='\u@\h:\w# '
```
```bash
user@host ~$
PS1='\u@\h \~\$ '
```
```bash
user@host dir$
PS1='\u@\h \W\$ '
```
```bash
user@host /var/log$
PS1='\u@\h \w\$ '
```
```bash
[14:32]$
PS1='[\t]\$ '
```
```bash
[Mon Sep 16]$
PS1='[\d]\$ '
```
```bash
[Mon Sep 16 14:32]$
PS1='[\d \t]\$ '
```
```bash
[user@host 14:32]$
PS1='[\u@\h \t]\$ '
```
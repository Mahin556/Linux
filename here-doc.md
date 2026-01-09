* https://tldp.org/LDP/abs/html/here-docs.html

---

• **Basic multiline input (most common)**

```
cat << EOF
Hello
World
EOF
```

• **HereDoc without a command (redirects to stdin consumer)**

```
<< EOF
Hello
World
EOF
```

• **Variable expansion (default behavior)**

```
name="Linux"
cat << EOF
Welcome to $name
Current dir: $PWD
EOF
```

• **Command substitution**

```
cat << EOF
User: $(whoami)
Date: $(date)
EOF

cat << EOF
`pwd`
`ls`
EOF

host=$(hostname)
cat << EOF
Hostname: $host
EOF

```

• **Disable variable and command expansion (quoted delimiter)**

```
cat << "EOF"
$(whoami)
$PWD
EOF
```

• **Disable expansion using escaped delimiter**

```
cat << \EOF
$USER
$(date)
EOF
```

• **Write HereDoc to a file (overwrite)**

```
cat << EOF > file.txt
Hello
World
EOF
```

• **Append HereDoc to a file**

```
cat << EOF >> file.txt
Another line
EOF
```

• **Use HereDoc with sudo**

```
sudo tee /etc/example.conf << EOF
option=true
path=/data
EOF
```

• **Tab suppression (`<<-`)**

```
cat <<- EOF
        Hello
        World
EOF
```

• **HereDoc inside `if` statement**

```
if true; then
        cat <<- EOF
        Condition met
        EOF
fi
```

• **HereDoc inside `for` loop**

```
for i in 1 2; do
        cat <<- EOF
        Iteration $i
        EOF
done
```

• **Multiline comment using null command**

```
: << 'EOF'
This is a block comment
Nothing runs here
EOF
```

• **Pipe HereDoc output to another command**

```
cat << EOF | wc -l
one
two
three
EOF
```

• **Redirect HereDoc into a command**

```
grep root << EOF
root:x:0:0:root:/root:/bin/bash
user:x:1000:1000:user:/home/user:/bin/bash
EOF
```

• **Base64 decode example**

```
cat << EOF | base64 -d
SGVsbG8gV29ybGQK
EOF
```

• **HereDoc with function input**

```
readData() {
    read a
    read b
}

readData << EOF
Hello
World
EOF

echo $a
echo $b
```

• **HereDoc with SSH (local + remote variable demo)**

```
ssh user@host << EOF
echo "Local user: $USER"
echo "Remote user: \$USER"
EOF
```

• **HereDoc with SFTP**

```
sftp user@host << EOF
put file.txt
ls
bye
EOF
```

• **HereDoc with MySQL**

```
mysql -u root -p << EOF
SHOW DATABASES;
EXIT;
EOF
```

• **HereDoc with MongoDB**

```
mongosh << EOF
use test
db.users.find()
EOF
```

• **HereDoc with Docker exec**

```
docker exec -i container_name sh << EOF
echo "Inside container"
uname -a
EOF
```

• **HereDoc with kubectl exec**

```
kubectl exec -i pod-name -- sh << EOF
ls /
whoami
EOF
```

• **HereDoc to generate config files**

```
cat << EOF > nginx.conf
server {
    listen 80;
    root /usr/share/nginx/html;
}
EOF
```

• **HereDoc with crontab**

```
crontab << EOF
*/5 * * * * echo "Hello"
EOF
```

• **HereDoc with awk**

```
awk '{print $1}' << EOF
one two
three four
EOF
```

• **HereDoc vs Here String (single-line)**

```
cat <<< "Hello World"
```

• **Sending email content**
```
sendmail user@example.com << EOF
Subject: Test
Hello
EOF
```

• **Using HereDoc with curl**
```
curl -X POST http://example.com -d @- << EOF
{"key":"value"}
EOF
```

• **Using HereDoc with zip**
```
zip files.zip -@ << EOF
a.txt
b.txt
EOF
```

• **Using HereDoc with SSH**
```
ssh user@host << EOF
whoami
hostname
EOF
```


• **Using HereDoc with FTP**
```
ftp -n << EOF
open server
user user pass
put file.txt
quit
EOF
```

• **Using HereDoc with MySQL**
```
mysql -u user -p << EOF
USE db;
SELECT * FROM table;
EOF
```

• **Using HereDoc with sed**
```
sed 's/old/new/' << EOF
old value
EOF
```

• **Using HereDoc with awk**

```
awk '{print $1}' << EOF
one two
three four
EOF
```

• **Using HereDoc with bc**

```
bc << EOF
10 * 5
EOF
```

• **Using HereDoc with bash**

```
bash << EOF
echo Hello
ls
EOF
```

* **Pipe + redirect together**
```
cat << EOF | grep apple > apples.txt
apple
banana
EOF
```
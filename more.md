* The `more` command in Linux is a terminal pager — it lets you view the contents of a text file one screen (page) at a time.

* Unlike `cat`, which dumps all text at once, more pauses after each screenful, waiting for you to press a key before continuing.

To view long text files or command outputs page by page.

To navigate within large files without opening an editor.

Useful for reading logs, configs, or command outputs.

* Navigation

| Key          | Action                                                     |
| ------------ | ---------------------------------------------------------- |
| **Spacebar** | Display next screen                                        |
| **Enter**    | Display next line                                          |
| **b**        | Go back one page (only if file is local)                   |
| **q**        | Quit (exit `more`)                                         |
| **h**        | Display help screen                                        |
| **=**        | Show current line number                                   |
| **/pattern** | Search forward for “pattern”                               |
| **n**        | Repeat last search                                         |
| **v**        | Open the current file in the default editor (usually `vi`) |
| **!command** | Execute a shell command while inside `more`                |
| **Ctrl+L**   | Redraw the screen                                          |


| Option      | Description                                                                    | Example                |
| ----------- | ------------------------------------------------------------------------------ | ---------------------- |
| `-d`        | Shows help at the bottom (“[Press space to continue, 'q' to quit.]”)           | `more -d /etc/passwd`  |
| `-c`        | Clears the screen before displaying the next page                              | `more -c file.txt`     |
| `-s`        | Squeezes multiple blank lines into one                                         | `more -s longfile.txt` |
| `-f`        | Counts logical lines instead of screen lines (useful for long lines that wrap) | `more -f file.txt`     |
| `-p`        | Displays each page by clearing the screen (like `less -c`)                     | `more -p bigfile.txt`  |
| `-n`        | Specifies number of lines per screen                                           | `more -n 20 file.txt`  |
| `+number`   | Starts displaying from a specific line number                                  | `more +100 file.txt`   |
| `+/pattern` | Starts displaying from the first match of the given pattern                    | `more +/error log.txt` |


```bash
ubuntu:~$ more +/mail /etc/nginx/nginx.conf 

...skipping


#mail {
#       # See sample authentication script at:
#       # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
#
#       # auth_http localhost/auth.php;
#       # pop3_capabilities "TOP" "USER";
#       # imap_capabilities "IMAP4rev1" "UIDPLUS";
#
#       server {
#               listen     localhost:110;
#               protocol   pop3;
#               proxy      on;
#       }
#
#       server {
#               listen     localhost:143;
#               protocol   imap;
#               proxy      on;
#       }
#}
```

```bash
ubuntu:~$ more +50 /etc/nginx/nginx.conf 
        # gzip_comp_level 6;
        # gzip_buffers 16 8k;
        # gzip_http_version 1.1;
        # gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

        ##
        # Virtual Host Configs
        ##

        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
}


#mail {
#       # See sample authentication script at:
#       # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
#
#       # auth_http localhost/auth.php;
#       # pop3_capabilities "TOP" "USER";
#       # imap_capabilities "IMAP4rev1" "UIDPLUS";
#
#       server {
#               listen     localhost:110;
#               protocol   pop3;
#               proxy      on;
#       }
#
#       server {
#               listen     localhost:143;
#               protocol   imap;
#               proxy      on;
#       }
#}
```

```bash
cat a.txt | more

more /var/log/syslog

ls -l /etc | more

ps aux | more

grep "error" /var/log/syslog | more

history | more

more +50 logfile.txt

more +/error logfile.txt

more -s file.txt

find / -type f | more

more file1.txt file2.txt file3.txt

echo "Displaying system info..." 
lscpu | more

dmesg | more

crontab -l | more

./generate_report.sh | more

systemctl status apache2 | more

ssh user@remote "cat /etc/ssh/sshd_config | more" #When viewing remote files over SSH where GUI editors aren’t available
```
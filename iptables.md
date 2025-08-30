   ``` 8  sudo iptables -A INPUT -s 192.168.29.80 -j LOG --log-prefix "Dropped: "
    9  sudo iptables -A INPUT -s 192.168.29.80 -j DROP
   10  dmesg | grep "Dropped"
   11  dmesg --help
   12  dmesg -C
   13  dmesg | grep "Dropped"
   14  tail -f /var/log/syslog | grep "Dropped packet"
   15  ls /var/log/
   16* ls -ltr /var/log/messages
   17  tail -f /var/log/messages | grep "Dropped packet"
   18  tail -f /var/log/messages | grep "Dropped"
   19  cat /var/log/messages | grep "Dropped"
   20  tail -f /var/log/messages | grep "Dropped"
```

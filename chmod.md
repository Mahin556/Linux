- Change the access mode of a file/directory.

| Permission | Symbol | Effect                                                     |
| ---------- | ------ | ---------------------------------------------------------- |
| Read       | `r`    | View file contents or list directory                       |
| Write      | `w`    | Modify file contents or create/delete files in a directory |
| Execute    | `x`    | Execute a file or access a directory                       |


| Class  | Symbol | Meaning                   |
| ------ | ------ | ------------------------- |
| Owner  | `u`    | File owner                |
| Group  | `g`    | Users in the file’s group |
| Others | `o`    | Everyone else             |
| All    | `a`    | u+g+o                     |

| Octal | Permission | Binary |
| ----- | ---------- | ------ |
| 0     | ---        | 000    |
| 1     | --x        | 001    |
| 2     | -w-        | 010    |
| 3     | -wx        | 011    |
| 4     | r--        | 100    |
| 5     | r-x        | 101    |
| 6     | rw-        | 110    |
| 7     | rwx        | 111    |


```bash
ls -l
-rwxr-xr--

chmod u=rwx,g=rwx,o=rwx [file_name]

chmod u=rw,g=r,o=r test.txt

chmod 644 test.txt

chmod +r sample.txt

chmod +rwx filename #Give complete permission

chmod -rwx directoryname #Remove all permission

chmod +x filename #give execure permission to all

chmod -wx filename #Removes write and execute rights

chmod u+x script.sh 

chmod g-w data.txt

chmod o=r file.txt

chmod ug+rwx file.txt

chmod a-x file.txt

chmod u+s file / chmod 4755 file #Set SUID

chmod g+s dir / chmod 2777 /tmp #Set SGID

chmod +t dir / chmod 1777 /tmp #Set Sticky bit

chmod a+x *.sh

chmod -v 644 file.txt #verbose (show changes)

chmod -v 644 file.txt #report only when changes are made

chmod --reference=example.txt file.txt #set permissions same as another file

chmod -R permissions directory

chmod -R 755 /var/www/html

chmod -R 755 /path/to/directory
chmod -R 644 /path/to/file

# Remove sticky bit
chmod -t /path/to/directory

```

### References:
- https://phoenixnap.com/kb/linux-file-permissions
- https://www.geeksforgeeks.org/linux-unix/set-file-permissions-linux/
- https://www.geeksforgeeks.org/linux-unix/advance-file-permissions-in-linux/
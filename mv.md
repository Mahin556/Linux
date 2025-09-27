- The mv command is used to move or rename files and directories.
```bash
mv --version
mv --help
man mv

mv oldname.txt newname.txt #Rename a File

mv report.pdf final_report.pdf

mv file1.txt file2.txt /tmp/ #Move moultiple file to directory

mv mydir /home/user/ #Move directory

mv olddir newdir #Rename directory

mv -i file.txt backup/ #Interactive mode-> Asks: mv: overwrite 'backup/file.txt'?

mv -f file.txt backup/ #Force Move (No Prompt)

mv -n file.txt backup/ #No Overwrite (Safe Mode)-> If file.txt already exists in backup/, it won’t overwrite.

mv -v file.txt backup/ #Verbose Mode-> renamed 'file.txt' -> 'backup/file.txt'

mv *.txt /tmp/ #Move Files Using Wildcards -> Moves all .txt files to /tmp/.

mv --backup file.txt backup/ #Backup While Moving -> If file.txt exists in backup/, it creates file.txt~ before moving.

mv --backup --suffix=.old file.txt backup/ #Custom suffix
mv -S .bak -b name1 test-dir/name1

mv -u file.txt backup/ #Move Only If Source Is Newer

mv file1.txt file2.txt --target-directory=/tmp/ #Target Directory Option

mv dir1/* dir2/ #Move Directory Contents

mv -v -i --backup file.txt /tmp/ #Combine Options
```
* Batch Rename file
```bash
for file in *; do mv "$file" "test_$file"; done
```

### References:
- https://phoenixnap.com/kb/mv-command-linux
- https://www.geeksforgeeks.org/linux-unix/mv-command-linux-examples/
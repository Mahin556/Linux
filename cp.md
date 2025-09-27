The cp command stands for copy. It is used to copy files and directories from one location to another.
```bash
cp file.txt backup.txt #Copies file.txt to backup.txt in the current directory.

cp file.txt /home/user/backup/ #Copy a File into a Directory

cp file1.txt file2.txt /tmp/ #Copy Multiple Files

cp -r dir1 dir2 #Copy a Directory (Recursive)-> (-R, -r, --recursive)

cp -p file.txt backup/ #Copy While Preserving Attributes->Keeps original permissions, ownership, and timestamps.

cp -i file.txt backup/ #Interactive Copy (Ask Before Overwriting)

cp -f file.txt backup/ #Force Copy

cp -n file.txt backup/ #No Overwrite(-n, --no-clobber)

cp -u file.txt backup/ #Copy Only If Newer

cp -v file1.txt file2.txt backup/ #Verbose Copy

cp -a project backup/ #Copy Entire Directory with Attributes->Equivalent to -dR --preserve=all.Preserves symlinks, permissions, ownership, and timestamps( creation date).

cp -b file.txt backup/ #Backup While Copying->Create backups for destination files. The backup file has the (~) suffix unless --suffix is used.

cp -b --suffix=.old file.txt backup/ #Provide a custom suffix for the backup file(-S, --suffix=)

cp -v -b -S .bak file-1.txt test-dir

cp --parents src/dir/file.txt /backup/ #Copy with Directory Structure->Creates /backup/src/dir/file.txt.

cp -l file.txt file_hardlink.txt #Create hard links instead of new files. The destination file will have the same inode attribute as the source.

cp -s file.txt file_symlink.txt #Create Symbolic Links Instead of Copies

cp --reflink=always bigfile.img newfile.img #Copy with Copy-on-Write (Efficient)->Works on Btrfs/XFS → instant copy, no extra disk space.

cp -v *.txt backup/

cp *.txt Folder1

cp file-* test-dir
```
* Combine Options
```bash
cp -avu file.txt /backup/
```
- Archive mode (-a)
- Verbose (-v)
- Update only (-u)

* Archive mode (recursive + preserve all attributes, links).
```bash
cp -a dir1 dir2
```

* Remove existing destination before copying.
```bash
cp --remove-destination file.txt backup/
```

* Preserve specific attributes (e.g. mode, ownership)(--preserve=ATTR_LIST)
```bash
cp --preserve=mode,ownership file.txt backup/
```

* `-t, --target-directory=DIR`
```bash
cp -t /backup/ file1.txt file2.txt file3.txt # Equivalent to: cp file1.txt file2.txt file3.txt /backup/
cp -t /backup/ *.log #Copies all .log files into /backup/.



```

### Reference:
- https://www.geeksforgeeks.org/linux-unix/cp-command-linux-examples/
- https://phoenixnap.com/kb/cp-command
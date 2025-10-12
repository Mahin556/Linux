The chgrp (change group) command changes the group ownership of one or more files or directories.
```bash
chgrp [group_name] [file_name/directory]

chgrp groupname file.txt

chgrp geeksforgeeks abc.txt

chgrp developers file1.txt file2.txt file3.txt

chgrp -R geeksforgeeks GFG

chgrp -R --reference=abc.txt GFG

chgrp -c geeksforgeeks f1 #Display info only for files that actually changed group.

chgrp -f geeksforgeeks f2 #Suppress error messages.

chgrp -v geeksforgeeks f1 #Display info for every processed file (changed or not).

chgrp --dereference geeksforgeeks symbolic_link #Change group of the target file pointed to by a symlink.

sudo chgrp --no-dereference geeksforgeeks symbolic_link #Change group of the symlink itself, not its target.

sudo chgrp -c -R devgroup /opt/software

chgrp -R --preserve-root project_team /data/projectA #Changes group for /data/projectA and all subfiles, while protecting the root (/) directory from being modified accidentally.

chgrp -Rv --preserve-root hpc_team /group/hpc/shared

chgrp -h devops linkfile #-h, --no-dereference ---> Affects the symbolic link itself (not what it points to). Only works on systems supporting symlink ownership.

chgrp -R --preserve-root project_team /

find /data/project -type f -name "*.log" -exec chgrp logs {} +

chgrp -Rvc --preserve-root project_group /group/project1

chgrp -R --reference=/srv/template /srv/deploy

chgrp --dereference devteam shortcut_link #Change Symlink Target, Not Link


```

### References:
- https://phoenixnap.com/kb/linux-file-permissions
- https://www.geeksforgeeks.org/linux-unix/chgrp-command-in-linux-with-examples/
- https://phoenixnap.com/kb/chgrp-command
- https://man7.org/linux/man-pages/man1/chgrp.1.html
- https://medium.com/@redswitches/how-to-use-the-chgrp-command-with-5-practical-examples-a753069e62f2
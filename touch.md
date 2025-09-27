- Create empty files.
- Update timestamps of existing files (access and modification time).

* Create an Empty File
```bash
touch file.txt
```
- If file.txt doesn’t exist, it is created.
- If it exists, its modification and access times are updated.

```bash
touch file1.txt file2.txt file3.txt #Create Multiple Empty Files

touch file.txt #Update Timestamp of Existing File->Updates access and modification time to current time.

touch -t 202509281200 file.txt #Set a Specific Timestamp-> Format: [[CC]YY]MMDDhhmm[.ss] -> Example: 202509281200 → 28 Sep 2025, 12:00 PM

touch -a file.txt #Set Access Time Only

touch -m file.txt #Set Modification Time Only

touch -c file.txt #This command is used to check whether a file is created or not. If not created then don't create it. This command avoids creating files.

touch -c-d fileName #This is used to update access and modification time.

touch -r reference.txt file.txt #Use Reference File’s Timestamp->Updates file.txt timestamp to match reference.txt.

touch -v file.txt #Verbose Mode->Shows confirmation of file creation or timestamp update.

touch -c -m -t 202509281200 file.txt #Combine Options->Don’t create if missing (-c),Update modification time only (-m),Set timestamp to 28 Sep 2025, 12:00 (-t).

touch file{1..10}.txt #Create 10 empty files in one command

touch *.log #Update timestamp of all .log files

touch -d "2025-09-28 08:00" file.txt #Use date string

touch -r backup.txt file.txt #Set timestamp from reference file
``` 

### References:
- https://www.w3schools.com/bash/bash_touch.php
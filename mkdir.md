```bash
mkdir --help
mkdir --version
mkdir mydir #Creates a single directory.
```
* Creating a multiple directory
- 
```bash
mkdir dir1 dir2 dir3 #Create Multiple Directories at Once
mkdir {test1,test2,test3} #No spaces should be inside the curly braces.
```
```bash
mkdir dir{1..15} #Creates 15 directories: dir1, dir2, ..., dir15.
mkdir file{A..E}  # Creates: fileA, fileB, fileC, fileD, fileE
mkdir -p project{1..3}/src project{1..3}/docs
```
Creates:
```bash
project1/src
project1/docs
project2/src
project2/docs
project3/src
project3/docs
```
```bash
mkdir dir{A..C}{1..3}
```
Creates:
```bash
dirA1 dirA2 dirA3
dirB1 dirB2 dirB3
dirC1 dirC2 dirC3
```

* Using xargs with mkdir
- Create directories from a list in a file:
```bash
cat dir_list.txt | xargs mkdir
```
Example dir_list.txt contents:
```bash
dir1
dir2
dir3
```
Creates all directories listed in the file.


* Create Nested Directories(-p or --parents)
- -p ensures all missing parent directories are created.
- Avoids errors if directories already exist.
```bash
mkdir -p parent/child/grandchild
```

* Set Permissions While Creating Directory(-m or --mode)
- 700 means owner can read/write/execute, others cannot access.
- You can use any octal permission (like 755, 775).
```bash
mkdir -m a=rwx [directories] #Symbolic
mkdir -m 700 secure_dir #octal
```

* Verbose Mode(-v or --verbose)
```bash
mkdir -v dirname
mkdir -v dir1 dir2
```
- Prints confirmation:
```bash
mkdir: created directory 'dirname'
```

* Combining Options
```bash
mkdir -pv -m 755 parent/child
```

* Creating Directory with SELinux Context
```bash
mkdir -Z mydir
```
- Useful in SELinux-enabled systems.
- Assigns security context.

* Combine with other commands:
```bash
mkdir -p newdir && cd newdir
```

```bash
mkdir $USER
```

* Using seq Command with mkdir
```bash
mkdir dir$(seq -f "%02g" 1 10)
```
- Creates dir01 to dir10.
- %02g adds leading zeros.

* Using Loops in Shell
```bash
for i in {1..5}; do mkdir "project_$i"; done
```
- Creates project_1, project_2, …, project_5.



### References:
- https://www.geeksforgeeks.org/linux-unix/mkdir-command-in-linux-with-examples/
- https://phoenixnap.com/kb/create-directory-linux-mkdir-command
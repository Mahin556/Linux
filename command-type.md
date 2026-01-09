```bash
======================== TYPES OF LINUX COMMANDS – COMPLETE DETAILED GUIDE ========================

Linux commands are instructions given to the shell to perform tasks.
Based on how and where they are implemented, Linux commands are broadly classified into:
1) Internal Commands
2) External Commands

----------------------------------------------------------------------------------

INTERNAL COMMANDS (SHELL BUILT-INS)

Definition:
Internal commands are built directly into the shell itself (such as bash).
They are loaded into RAM when the shell starts.

Key Characteristics:
- Part of the shell binary
- Do NOT exist as separate files on disk
- Execute faster (no disk I/O required)
- Available even if filesystem is not fully mounted
- Mostly used for shell behavior and environment control

Examples of Internal Commands:
cd        # change directory
echo      # print output
pwd       # print working directory
alias     # create command shortcuts
exit      # exit shell
read      # read user input
set       # set shell options
unset     # remove variables
export    # set environment variables
history   # command history

Check if a command is internal:
type echo
# Output:
# echo is a shell builtin

----------------------------------------------------------------------------------

EXTERNAL COMMANDS

Definition:
External commands are standalone executable files stored on disk.
They are provided by installed packages.

Key Characteristics:
- Stored as binaries or scripts on disk
- Loaded into RAM only when executed
- Slightly slower than internal commands
- Located in standard directories
- Depend on filesystem availability

Common Directories for External Commands:
/bin
/usr/bin
/usr/sbin
/sbin
/usr/local/bin

Examples of External Commands:
ls        # list files
cat       # view file contents
grep      # search text
find      # locate files
vim       # editor
tar       # archive
ps        # process status
top       # system monitoring

Check location of external command:
which ls
# Output:
/usr/bin/ls

Check command type:
type cat
# Output:
# cat is /usr/bin/cat

----------------------------------------------------------------------------------

HOW THE SHELL EXECUTES A COMMAND (STEP-BY-STEP)

When you type a command and press Enter, the shell follows this order:

1) Alias Check
   - Is the command an alias?
   - If yes, replace it with the alias definition

2) Internal Command Check
   - Is it a shell builtin?
   - If yes, execute from RAM

3) External Command Check
   - Search directories listed in $PATH
   - Load executable from disk into RAM

4) Command Not Found
   - If not found anywhere, return error

Example:
ll
# Might be an alias for:
ls -l --color=auto

----------------------------------------------------------------------------------

CHECKING COMMAND TYPES

Check command type (recommended):
type <command>

Examples:
type echo
# echo is a shell builtin

type ls
# ls is aliased to `ls --color=auto`

type cat
# cat is /usr/bin/cat

----------------------------------------------------------------------------------

USING `which` COMMAND

Purpose:
- Shows the location of external commands
- Does NOT work for internal commands

Examples:
which ls
/usr/bin/ls

which echo
# (may show nothing or /usr/bin/echo, but builtin is preferred)

----------------------------------------------------------------------------------

PATH ENVIRONMENT VARIABLE

PATH defines where the shell looks for external commands.

View PATH:
echo $PATH

Example output:
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

Search order:
- Shell searches directories from LEFT to RIGHT
- First match is executed

----------------------------------------------------------------------------------

ALIAS VS INTERNAL VS EXTERNAL (SUMMARY)

Alias:
- Shortcut defined in shell
- Example: ll → ls -l

Internal Command:
- Built into shell
- Fast
- No disk access

External Command:
- Binary on disk
- Loaded at runtime
- Depends on PATH

----------------------------------------------------------------------------------

WHY THIS DISTINCTION MATTERS

- Helps in debugging "command not found" issues
- Explains performance differences
- Important for shell scripting
- Helps understand PATH and alias conflicts
- Critical for system recovery scenarios

----------------------------------------------------------------------------------

COMMON INTERVIEW POINTS

- cd is internal because it must change shell environment
- External commands cannot change parent shell state
- which finds binaries, type identifies actual behavior
- PATH affects only external commands

======================== END OF LINUX COMMAND TYPES GUIDE ========================
```
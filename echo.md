- `echo` is a built-in command in most shells (like `bash`, `zsh`, `sh`) and also available as `/bin/echo`
- Its job: print text/strings to standard output (stdout).
- Widely used in:
    - Shell scripting
    - Displaying messages
    - Debugging
    - Printing environment variables
    - Redirecting output into files

```bash
echo -n "hello" #No trailing newline->(No newline at the end, so the next prompt appears on the same line)

echo -e "Line1\nLine2\tTabbed" #Enable interpretation of escape sequences
echo -e "Hello\tWorld\nHi\b!"

echo -E "Hello\nWorld" #Disable escape sequences (default in most shells)

echo * #print all files and folders n current directory

echo $USER

echo "This is the list of directories and files on this system: $(ls)"

echo -n "Enter your name: "

echo rm -rf f* #test dangerous command

echo *.txt

echo "System Information: $(uname -a)"

echo {1..5}

echo "$(date): Something happened!" >> log.txt

echo "Home directory: $HOME"
```

##### Escape Sequences (used with -e)
    \n → New line
    \t → Horizontal tab
    \v → Vertical tab
    \b → Backspace
    \r → Carriage return (moves cursor to beginning of line)
    \a → Alert (bell sound)
    \f → Form feed (page break effect in terminals/printers)
    \\ → Backslash
    \c → Suppress further output

* Environment Variables with echo(Print environment variables by prefixing with `$`)
  ```bash
  echo $HOME
  echo $USER
  echo $PATH
  ```

* Redirecting Output
  ```bash
  echo "Hello World" > file.txt #Save output into a file
  echo "Another Line" >> file.txt #Append to a file
  ```

* Quoting with echo
  ```bash
  echo '$HOME' #Single quotes ' → literal, variables not expanded
  echo "$HOME" #Double quotes " → variables expanded
  ```

* Using echo in Scripts
  ```bash
  #!/bin/bash
  echo "Script started"
  name="Mahin"
  echo "Hello, $name"
  ```

* Special Use Cases
  ```bash
  #Printing colored text (ANSI escape codes):
  echo -e "\e[31mThis is RED text\e[0m"
  echo -e "\e[32mThis is GREEN text\e[0m"
  
  #Debugging scripts
  echo "Value of variable: $var"

  #Creating files quickly
  echo "first line" > myfile.txt
  echo "second line" >> myfile.txt

  #Printing empty lines
  echo

  #Printing multiple strings
  echo Hello World Linux
  ```

* Alternatives: printf vs echo
  ```bash
  printf "Hello %s\n" "World"
  ```
  - `printf` is more consistent across shells.
  - Always recommended in scripting when exact formatting is needed.

```bash
echo -n "Enter your password: "
read -s password
echo -e "\nPassword entered."
```

```bash
echo " _
     / \\
    / _ \\
   | / \\ |
   ||    ||"
```

```bash
echo "Select an option:"
echo "1. Option One"
echo "2. Option Two"
read choice
case $choice in
    1) echo "You chose Option One." ;;
    2) echo "You chose Option Two." ;;
    *) echo "Invalid choice." ;;
esac
```

```bash
file="demo.txt"
if [ -e "$file" ]; then
    echo "The file $file exists."
else
    echo "The file $file does not exist."
fi
```

```bash
echo "Subject: Important Announcement" > email.txt
echo "This is an important announcement. Please read carefully." >> email.txt
mail -s "Important Announcement" user@example.com < email.txt
```

```bash
process_name="firefox"
echo "Information about the $process_name process: $(ps aux | grep $process_name)"
```

```bash
seconds=10
while [ $seconds -gt 0 ]; do
    echo -ne "Countdown: $seconds seconds\033[0K\r"
    sleep 1
    ((seconds--))
done
echo "Countdown complete!"
```




### References:
- https://www.geeksforgeeks.org/linux-unix/echo-command-in-linux-with-examples/
- https://phoenixnap.com/kb/echo-command-linux
- https://kodekloud.com/blog/bash-echo-commands-examples/
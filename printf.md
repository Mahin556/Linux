```bash
======================== PRINTF COMMAND – COMPLETE DETAILED GUIDE ========================

WHAT IS printf
printf is a standard Unix/Linux command used to format and print output.
It is more powerful and predictable than echo.

printf comes from C language formatting style and is available as:
- Shell builtin (bash)
- External command (/usr/bin/printf)

It is widely used in:
- Shell scripting
- Automation
- System scripts
- DevOps tools

----------------------------------------------------------------------------------

WHY printf IS PREFERRED OVER echo
echo:
- Behavior varies between shells
- Escape handling (-e) is inconsistent

printf:
- Portable and consistent
- Precise formatting control
- No unexpected behavior
- Recommended for scripts

----------------------------------------------------------------------------------

BASIC SYNTAX
printf FORMAT [ARGUMENTS...]

FORMAT:
- Defines how output should look
ARGUMENTS:
- Values inserted into FORMAT

----------------------------------------------------------------------------------

SIMPLE EXAMPLES

Print text:
printf "Hello World\n"

Print without newline:
printf "Hello World"

----------------------------------------------------------------------------------

FORMAT SPECIFIERS (MOST IMPORTANT PART)

%s   → string
%d   → integer (decimal)
%f   → floating point number
%c   → single character
%x   → hexadecimal
%o   → octal
%%   → literal %

Example:
printf "Name: %s, Age: %d\n" "Gaurav" 25

----------------------------------------------------------------------------------

NEWLINE AND ESCAPE SEQUENCES

\n   → new line
\t   → tab
\\   → backslash
\"   → double quote

Example:
printf "Name:\t%s\nAge:\t%d\n" "Gaurav" 25

----------------------------------------------------------------------------------

PRINT MULTIPLE VALUES

printf "%s %s %d\n" "Linux" "Version" 9

----------------------------------------------------------------------------------

FLOATING POINT PRECISION

Default:
printf "%f\n" 3.14159
# Output: 3.141590

Control precision:
printf "%.2f\n" 3.14159
# Output: 3.14

----------------------------------------------------------------------------------

WIDTH AND ALIGNMENT

Right aligned (default):
printf "%10s\n" "Linux"

Left aligned:
printf "%-10s\n" "Linux"

Pad numbers with zeros:
printf "%05d\n" 42
# Output: 00042

----------------------------------------------------------------------------------

REPEATED FORMATTING

If more arguments are provided:
printf "%s\n" a b c d

Output:
a
b
c
d

----------------------------------------------------------------------------------

USING printf IN LOOPS

for i in 1 2 3
do
  printf "Iteration: %d\n" "$i"
done

----------------------------------------------------------------------------------

COLORED OUTPUT WITH printf (ANSI CODES)

GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

printf "%bGreen Text%b\n" "$GREEN" "$RESET"
printf "%bError Message%b\n" "$RED" "$RESET"

%b → interprets escape sequences

----------------------------------------------------------------------------------

USING printf WITH VARIABLES

name="Linux"
version=9

printf "OS: %s\nVersion: %d\n" "$name" "$version"

----------------------------------------------------------------------------------

HEX, OCTAL, AND CHAR OUTPUT

printf "Decimal: %d\n" 65
printf "Hex: %x\n" 65
printf "Octal: %o\n" 65
printf "Char: %c\n" 65

----------------------------------------------------------------------------------

printf VS echo (QUICK COMPARISON)

echo:
- Simple
- Unreliable in scripts
- Shell dependent

printf:
- Structured
- Predictable
- Script-friendly
- Industry standard

----------------------------------------------------------------------------------

COMMON MISTAKES

Wrong:
printf "%d\n" "abc"

Correct:
printf "%s\n" "abc"

Forgetting newline:
printf "Hello"
# cursor stays on same line

----------------------------------------------------------------------------------

REAL-WORLD USE CASES

- Logging scripts
- Formatting reports
- Colorized CLI tools
- Automation output
- Parsing command output

----------------------------------------------------------------------------------

EXIT STATUS

0 → success
Non-zero → error in formatting or arguments

----------------------------------------------------------------------------------

BEST PRACTICES

- Use printf instead of echo in scripts
- Always control newlines explicitly
- Use %b for escape sequences
- Quote variables properly

----------------------------------------------------------------------------------

QUICK COMMAND SUMMARY

printf "Hello\n"
printf "%s %d\n" "Linux" 9
printf "%.2f\n" 3.14
printf "%05d\n" 7
printf "%bRed%b\n" "\033[31m" "\033[0m"

======================== END OF PRINTF COMMAND GUIDE ========================
```
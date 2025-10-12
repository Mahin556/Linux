The tac command in Linux is used to display the contents of files in reverse order, line by line.
It’s essentially the opposite of the cat command.

| Option         | Description                                              | Example                 |
| -------------- | -------------------------------------------------------- | ----------------------- |
| `-b`           | Attach separator **before** each record instead of after | `tac -b file.txt`       |
| `-r`           | Treat the separator as a **regular expression**          | `tac -r file.txt`       |
| `-s SEPARATOR` | Use **custom string** as a separator instead of newline  | `tac -s "SEP" file.txt` |
| `--help`       | Display help information                                 | `tac --help`            |
| `--version`    | Show version information                                 | `tac --version`         |


```bash
tac file.txt

tac file1.txt file2.txt

tac -s ";" file.txt

tac -s "," -b file.txt

tac -r -s "[0-9]+" file.txt

echo -e "one\ntwo\nthree" | tac

seq 1 10 | tac

tac logfile | tail -n +10 | head -n 10
```
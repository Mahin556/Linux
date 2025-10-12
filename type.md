The type command in Linux tells you how a given command name would be interpreted by the shell.
It checks whether the command is a shell builtin, user-defined function, alias, or external executable.

It’s especially useful for debugging command behavior and understanding the order of command resolution in Bash and other shells.


| Option        | Description                                                                                  | Example        |
| ------------- | -------------------------------------------------------------------------------------------- | -------------- |
| *(no option)* | Displays how the command name is interpreted                                                 | `type ls`      |
| `-a`          | Shows **all locations** where the command name is found (aliases, builtins, and executables) | `type -a echo` |
| `-t`          | Displays **type keyword only** — “alias”, “keyword”, “function”, “builtin”, or “file”        | `type -t cd`   |
| `-p`          | Shows **path of the external executable** (like `which`)                                     | `type -p bash` |
| `-f`          | Skips aliases and shell functions during lookup                                              | `type -f cd`   |
| `--help`      | Displays help message                                                                        | `type --help`  |


```bash
type ls

ls is aliased to `ls --color=auto`
```

```bash
type cd

cd is a shell builtin
```

```bash
type cat

cat is /bin/cat
```

```bash
type -a echo

echo is a shell builtin
echo is /usr/bin/echo
```

```bash
type -p bash

/usr/bin/bash
```

```bash
type -t alias

builtin
```

```bash
type -f ls
```

```bash
type cd ls pwd cat

cd is a shell builtin
ls is aliased to `ls --color=auto`
pwd is a shell builtin
cat is /bin/cat

```


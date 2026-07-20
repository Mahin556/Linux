Another file, where we can add our alias is `.bash_aliases`. This file should be loaded automatically when `.bashrc` is loaded.

In order to be sure, we need to check if the proper block is defined in `.bashrc`:

Alias definitions.
You may want to put all your additions into a separate file like
`~/.bash_aliases`, instead of adding them here directly.
See `/usr/share/doc/bash-doc/examples` in the bash-doc package.

```bash
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```
* The updatedb command is used to update the database used by the locate command. Since locate searches a pre-built database instead of the live filesystem, updatedb ensures that newly created or removed files are reflected in locate searches.

* Typically run by root to update the system-wide database.

* Without options, it updates the default database (usually `/var/lib/mlocate/mlocate.db`).

##### How It Works
* Scans the filesystem (or specified paths) for files.
* Updates the database with the paths of all files.
* Excluded directories or files (e.g., `/tmp`, `/proc`) are ignored to avoid clutter and speed up indexing.
* `locate` then uses this updated database for fast searches.

| Option               | Description                                         |
| -------------------- | --------------------------------------------------- |
| `--help`             | Display help information                            |
| `--version`          | Show the version of `updatedb`                      |
| `--prunepaths=PATHS` | Exclude directories from indexing (comma-separated) |
| `--output=FILE`      | Save the database to a specific file                |
| `--localpaths=PATHS` | Only index specific directories                     |


```bash
sudo updatedb #Updates /var/lib/mlocate/mlocate.db with all current files.

sudo updatedb --prunepaths="/tmp,/var/tmp,/proc" #Skips /tmp, /var/tmp, and /proc directories while updating.

sudo updatedb --localpaths="/home,/etc" #Only indexes /home and /etc.

sudo updatedb --output=/tmp/mydb.db #Creates a new database at /tmp/mydb.db. Can then be used with locate --database=/tmp/mydb.db.

updatedb -o /home/user/mydb.db -U /home/user #-o → output database file, -U → paths to scan




```
* `xz` is a high-compression, lossless compressor based on the LZMA2 algorithm.
* It’s the successor to lzma and part of the XZ Utils package.
* It produces .xz files, known for their high compression ratio — much better than gzip or bzip2.
* Slower than gzip, but ideal for backups, archives, and packaging.

| Extension           | Description                    |
| ------------------- | ------------------------------ |
| `.xz`               | Standard compressed file       |
| `.tar.xz` or `.txz` | Tar archive compressed with xz |

| **Command / Option**            | **Description**                                    |                                        |
| ------------------------------- | -------------------------------------------------- | -------------------------------------- |
| `xz file.txt`                   | Compress file → replaces with `file.txt.xz`        |                                        |
| `unxz file.txt.xz`              | Decompress file                                    |                                        |
| `xz -d file.txt.xz`             | Decompress (same as `unxz`)                        |                                        |
| `xz -k file.txt`                | Keep original file after compression               |                                        |
| `unxz -k file.txt.xz`           | Keep compressed file after decompression           |                                        |
| `xz -v file.txt`                | Verbose mode → show compression ratio              |                                        |
| `xz -t file.txt.xz`             | Test compressed file integrity                     |                                        |
| `xz -l file.txt.xz`             | Show compression stats (size, ratio, etc.)         |                                        |
| `xz -c file.txt > file.txt.xz`  | Compress and write to stdout (no file replace)     |                                        |
| `xz -dc file.txt.xz > file.txt` | Decompress to stdout                               |                                        |
| `xz -f file.txt`                | Force overwrite existing `.xz` file                |                                        |
| `xz -r /path/to/dir`            | Compress all files in directory recursively        |                                        |
| `xz -0 file`                    | Fastest, least compression                         |                                        |
| `xz -6 file`                    | Default compression (balanced)                     |                                        |
| `xz -9 file`                    | Best compression, slower                           |                                        |
| `xz -9e file`                   | Extreme compression (very slow, best ratio)        |                                        |
| `xz -T4 bigfile.iso`            | Use 4 threads for parallel compression             |                                        |
| `xz -T0 backup.tar`             | Use all CPU cores for parallel compression         |                                        |
| `xz -q file.txt`                | Quiet mode (no messages)                           |                                        |
| `xz -v file.txt`                | Verbose mode (show progress, ratio)                |                                        |
| `xz --fast file.txt`            | Fastest compression mode                           |                                        |
| `xz --best file.txt`            | Best compression mode (same as `-9`)               |                                        |
| `xz --memlimit=512M file.txt`   | Limit memory usage to 512MB                        |                                        |
| `xz --info-memory`              | Show memory usage information                      |                                        |
| `xz --check=crc32`              | Use CRC32 checksum instead of default CRC64        |                                        |
| `xz --ignore-check file.xz`     | Skip checksum verification when decompressing      |                                        |
| `xz --single-stream bigfile.xz` | Process only first stream (skip concatenated ones) |                                        |
| `xz --version`                  | Show `xz` version info                             |                                        |
| `xzcat file.xz`                 | View compressed file contents (to stdout)          |                                        |
| `xzgrep "pattern" file.xz`      | Search text in compressed file                     |                                        |
| `xzless file.xz`                | View compressed file (paged view)                  |                                        |
| `xzmore file.xz`                | View compressed file (paged alternative)           |                                        |
| `tar -cJf backup.tar.xz dir/`   | Create tar archive + xz compress                   |                                        |
| `tar -xJf backup.tar.xz`        | Extract tar.xz archive                             |                                        |
| `tar -tJf backup.tar.xz`        | List contents of tar.xz archive                    |                                        |
| `tar cf - folder                | xz > folder.tar.xz`                                | Create archive and compress (pipeline) |
| `xz -dc folder.tar.xz           | tar xf -`                                          | Decompress and extract (pipeline)      |
| `file backup.tar.xz`            | Identify file type (XZ compressed data)            |                                        |

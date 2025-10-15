* Debian/Ubuntu based package manager
* Resolve dependencies
* A newer end-user tool that consolidates the functionality of both apt-get and apt-cache.
* `apt == apt-get`
* update index(sync the local package list from the remote repos)
* Debian-based distros (Ubuntu, Debian, etc.) use .deb packages.
* Managed with:
    * `apt` — high-level package management
    * `apt-cache` — queries package information
    * `dpkg` — low-level tool for installing/removing .deb directly


```bash
sudo apt update -y
```
* Downloads package information from all the sources/repositories configured on your system (within /etc/apt/sources.list). 

* Install package
```bash
$ apt install [package]=[version]
$ apt install mc -y
$ sudo apt install nginx=1.22.0-1ubuntu1

ubuntu:~$ apt install mc
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following package was automatically installed and is no longer required:
  squashfs-tools
Use 'apt autoremove' to remove it.
The following additional packages will be installed:
  libssh2-1t64 mailcap mc-data
Suggested packages:
  arj catdvi | texlive-binaries dbview djvulibre-bin epub-utils genisoimage gv imagemagick libaspell-dev links | w3m | lynx odt2txt poppler-utils python python-boto python-tz unar
  wimtools xpdf | pdf-viewer zip
The following NEW packages will be installed:
  libssh2-1t64 mailcap mc mc-data
0 upgraded, 4 newly installed, 0 to remove and 43 not upgraded.
Need to get 2099 kB of archives.
After this operation, 8536 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu noble/main amd64 libssh2-1t64 amd64 1.11.0-4.1build2 [120 kB]
Get:2 http://archive.ubuntu.com/ubuntu noble/main amd64 mailcap all 3.70+nmu1ubuntu1 [23.8 kB]
Get:3 http://archive.ubuntu.com/ubuntu noble-updates/universe amd64 mc-data all 3:4.8.30-1ubuntu0.1 [1397 kB]
Get:4 http://archive.ubuntu.com/ubuntu noble-updates/universe amd64 mc amd64 3:4.8.30-1ubuntu0.1 [559 kB]
Fetched 2099 kB in 3s (682 kB/s)
Selecting previously unselected package libssh2-1t64:amd64.
(Reading database ... 82211 files and directories currently installed.)
Preparing to unpack .../libssh2-1t64_1.11.0-4.1build2_amd64.deb ...
Unpacking libssh2-1t64:amd64 (1.11.0-4.1build2) ...
Selecting previously unselected package mailcap.
Preparing to unpack .../mailcap_3.70+nmu1ubuntu1_all.deb ...
Unpacking mailcap (3.70+nmu1ubuntu1) ...
Selecting previously unselected package mc-data.
Preparing to unpack .../mc-data_3%3a4.8.30-1ubuntu0.1_all.deb ...
Unpacking mc-data (3:4.8.30-1ubuntu0.1) ...
Selecting previously unselected package mc.
Preparing to unpack .../mc_3%3a4.8.30-1ubuntu0.1_amd64.deb ...
Unpacking mc (3:4.8.30-1ubuntu0.1) ...
Setting up mc-data (3:4.8.30-1ubuntu0.1) ...
Setting up libssh2-1t64:amd64 (1.11.0-4.1build2) ...
Setting up mailcap (3.70+nmu1ubuntu1) ...
Setting up mc (3:4.8.30-1ubuntu0.1) ...
Processing triggers for man-db (2.12.0-4build2) ...
Processing triggers for libc-bin (2.39-0ubuntu8.5) ...
Scanning processes...                                                                                                                                                                     
Scanning linux images...                                                                                                                                                                  

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.

$ which mc #config the command is available now
```

* reinstlal package
```bash
apt reinstall mc
```

* Install multiple packages
```bash
sudo apt install [package1] [package2]
```

* Automatically confirm installation
```bash
sudo apt install [package] -y
apt install -s package      # Dry run (no changes)
sudo apt install -f         # Fix Broken Dependencies
```

* Download Package (No Install)
```bash
apt download package
```

* Install from .deb File
```bash
sudo dpkg -i file.deb
sudo apt install -f        # Fix missing deps
```

* remove package
```bash
apt remove mc
```

* Remove a package and its configuration files(Useful for a clean uninstall)
```bash
sudo apt purge [package]
sudo apt-get purge docker-ce docker-ce-cli containerd.io
```

* APT Cache
    * When you install or upgrade packages, apt downloads .deb package files from repositories and stores them locally in:
        ```bash
        /var/cache/apt/archives/
        ```
        and temporarily (for incomplete downloads) in:  
        ```bash
        /var/cache/apt/archives/partial/
        ```
    * These .deb files are kept so that:
        * You can reinstall a package later without re-downloading it.
        * They provide a cache for offline installs or quick reinstalls.
        * But over time, these cached packages can consume hundreds of megabytes or even gigabytes of disk space — especially after system upgrades.

* Remove downloaded package files
    * Deletes all .deb package files in /var/cache/apt/archives/ and /var/cache/apt/archives/partial/
        ```bash
        sudo apt clean
        ```
    * Effectively does:
        ```bash
        rm -rf /var/cache/apt/archives/*.deb
        rm -rf /var/cache/apt/archives/partial/*
        ```
    * Completely clears the local package cache.
    * Frees up disk space.
    * Forces APT to re-download packages again next time you install or upgrade.
    * After a major system upgrade when you don’t need those old .deb files anymore.
    * When cleaning up a system image (like a Docker base image or VM template).


* Remove partial packages(Keeps your /var/cache/apt/archives/ clean)
    ```bash
    sudo apt autoclean
    ```
    * Removes only outdated package files that can no longer be downloaded or installed (because they’ve been replaced by newer versions in the repository).
    * `.deb` files for currently available or installable versions.
    * Removes `.deb` files for packages that have been superseded or no longer exist in any repo.
    * Keeps your cache folder tidy without deleting useful packages.
    * Maintains a small cache of installable .deb files.

    ```bash
    $ du -sh /var/cache/apt/archives/
    450M    /var/cache/apt/archives/

    $ sudo apt autoclean
    $ du -sh /var/cache/apt/archives/
    150M    /var/cache/apt/archives/

    $ sudo apt clean
    $ du -sh /var/cache/apt/archives/
    0M      /var/cache/apt/archives/
    ```

* remove unused dependencies that are not required any more
    * Removes packages no longer needed, such as old kernels, orphaned dependencies, or libraries.
    * Keeps your system clean and saves disk space.
```bash
apt autoremove
sudo apt --purge autoremove
```

* update the available package to the lates version
```bash
apt upgrade
```

* Show Dependencies
```bash
apt-cache depends package
apt-cache rdepends package
```

* List all the available package
```bash
apt list
```

* list all the installed package
```bash
apt list --installed
dpkg -l

#Filter Installed Packages
dpkg -l pattern*
dpkg --get-selections
dpkg --get-selections | awk '$2 ~ /^install/'
```

* List Files in Package
```bash
dpkg -L package
```

* Find Which Package Owns a File
```bash
dpkg -S /path/to/file
```



* To see available version of package
```bash
apt-cache policy package    # Show available versions
```


* search package(give package list related to provided keyword)
```bash
apt search apache #keyword
apt-cache search name
apt search --full nginx #To get detailed descriptions
```

* Info about package
```bash
apt show mc
```
    * name
    * maintainers
    * dependencies
    * recommends
    * description

* Lists all packages that have updates available.
```bash
ubuntu:~$ apt list --upgradable #Shows current version → available version.
Listing... Done
cloud-init/noble-updates 25.2-0ubuntu1~24.04.1 all [upgradable from: 25.1.4-0ubuntu0~24.04.1]
containerd/noble-updates 1.7.28-0ubuntu1~24.04.1 amd64 [upgradable from: 1.7.27-0ubuntu1~24.04.1]

```

* Upgrade a Specific Package
    * Only upgrades an existing package, does not install new packages.
    * Use this if you want controlled upgrades instead of upgrading everything.
```bash
sudo apt install --only-upgrade curl
```

* Full Upgrade (Dist Upgrade)
    * Equivalent to apt-get dist-upgrade.
    * Upgrades all packages, can install or remove packages as needed to resolve dependencies.
    * Use with caution — may remove older packages or kernels.
```bash
sudo apt full-upgrade

sudo apt update          # Refresh package index (cache)
sudo apt upgrade         # Upgrade existing packages (no removals)
sudo apt full-upgrade    # Upgrade, allowing removals/replacements
```

```bash
sudo apt update && sudo apt upgrade
```

* Exporting & Importing Package Lists
    * Export Installed Package List
        ```bash
        dpkg --get-selections > ~/packagelist.txt
        cp -R /etc/apt/sources.list* ~/sources/
        apt-key exportall > ~/trusted_keys.txt
        ```
    * Import on Another System
        ```bash
        sudo apt-key add ~/trusted_keys.txt
        sudo cp -R ~/sources/* /etc/apt/
        sudo dpkg --clear-selections
        sudo dpkg --set-selections < packagelist.txt
        sudo apt dselect-upgrade
        ```

* Adding Repositories(sources) & PPAs
    ```bash
    sudo add-apt-repository ppa:user/ppa-name
    sudo apt update
    ```
    * Add Custom Repo Manually
        ```bash
        $ sudo nano /etc/apt/sources.list.d/custom.list
        #ADD --> deb or deb-src  URL  distribution  components --> deb http://archive.ubuntu.com/ubuntu focal main restricted universe multiverse

        deb [arch=amd64] http://repo.url/ubuntu focal main

        $ sudo apt update
        $ sudo apt install package
        ```
        ```bash
        sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu focal main universe"
        ```
        For example, to add the graphics-drivers PPA:
        ```bash
        sudo add-apt-repository ppa:graphics-drivers/ppa
        ```

* Removing Repositories
```bash
sudo add-apt-repository --remove ppa:deadsnakes/ppa
```
    


* Key Maintenance
    * Add or Export GPG Keys
        ```bash
        apt-key list
        apt-key add keyfile
        apt-key exportall > ~/trusted_keys.txt
        ```

| File                             | Description                |
| -------------------------------- | -------------------------- |
| `/etc/apt/sources.list`          | Main repository list       |
| `/etc/apt/sources.list.d/*.list` | Additional repo files      |
| `/etc/apt/apt.conf.d/`           | APT configuration snippets |
| `/var/lib/apt/lists/`            | Cached repo metadata       |
| `/var/cache/apt/archives/`       | Cached `.deb` packages     |

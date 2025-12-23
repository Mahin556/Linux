* DNF = Dandified Yum
* It is the next-generation package manager used in:
    * RHEL 8 / 9
    * CentOS 8
    * Rocky Linux
    * AlmaLinux
    * Fedora
    * Amazon Linux 2023
* It replaces YUM
* DNF is fully backwards compatible with YUM:
    ```bash
    yum install httpd
    dnf install httpd
    ```
* Both work, but yum is just a wrapper for dnf.

| Command          | Description                     |
| ---------------- | ------------------------------- |
| install          | Install package                 |
| update / upgrade | Update pkgs                     |
| downgrade        | Install older version           |
| remove / erase   | Remove package                  |
| reinstall        | Reinstall                       |
| autoremove       | Remove unused deps              |
| distro-sync      | Sync system to repo             |
| module           | Manage modular packages         |
| history          | View transaction logs           |
| group            | Install package groups          |
| mark             | Mark packages as user-installed |
| copr             | Manage COPR repositories        |
| repoquery        | Query repo metadata             |
| provides         | Which pkg provides a file       |
| makecache        | Refresh metadata                |
| clean            | Clear cache                     |
| swap             | Replace one pkg with another    |

```bash
-y                 auto yes
--noplugins        disable plugins
--nogpgcheck       disable GPG
--enablerepo=<id>  enable repo
--disablerepo=<id> disable repo
--allowerasing     erase conflicting pkgs
--best             try best dependency match
--refresh          refresh metadata
--setopt=<key>     override config
-C                 cache only
-q                 quiet
-v                 verbose
--repo=<id>        use specific repo
--downloadonly     only download pkgs
--downloaddir=<dir> download location
--security          security updates only
--bugfix            bugfix updates only
--advisory=<ID>     apply only advisory patches
--skip-broken       skip dep issues
--debuglevel=<0-10> debugging output
```

```bash
dnf install httpd
dnf install git wget vim

dnf remove httpd
dnf erase httpd

dnf update httpd

dnf update -y
dnf upgrade -y

dnf search nginx
dnf search all python

dnf info nginx

dnf list installed
dnf list available
dnf list --all

dnf repolist
dnf repolist all
dnf repolist enabled

dnf install nginx --enablerepo=epel #Enable repo (temporary)

dnf update --disablerepo=epel #Disable repo (temporary)

#Permanently enable/disable
vi /etc/yum.repos.d/epel.repo
enabled=1
enabled=0

#Repo synchronization
dnf makecache
dnf clean metadata
dnf repolist

#DNF MODULES (New Feature)
#Modular packages allow multiple versions, streams, profiles.
dnf module list
dnf module info nodejs
dnf module install nodejs:14
dnf module enable php:8.0
dnf module disable python36
dnf module reset mysql

#DNF GROUPS (Complete)
#Groups = collections of packages.
dnf group list
dnf group info "Development Tools"
dnf group install "Development Tools"
dnf group remove "Web Server"

#DNF HISTORY (Everything)
#Shows every install/update/remove ever performed.
dnf history
dnf history info 12
dnf history undo 12
dnf history redo 12
dnf history rollback 12

dnf clean metadata
dnf makecache

rm -f /var/lib/rpm/__db*
rpm --rebuilddb

dnf install --nogpgcheck package.rpm

dnf install --skip-broken
dnf update --best --allowerasing

dnf update --security #Apply only security fixes

#Mirror repositories locally
dnf reposync -p /repo/
createrepo /repo/

```

* DNF CONFIGURATION FILES 
  * `/etc/dnf/dnf.conf`
    ```bash
    [main]
    gpgcheck=1
    installonly_limit=5
    clean_requirements_on_remove=True
    best=True
    fastestmirror=True
    max_parallel_downloads=10
    skip_if_unavailable=True
    keepcache=False
    ```

  * `/etc/yum.repos.d/*.repo`
    ```bash
    [appstream]
    name=RHEL AppStream
    baseurl=https://...
    enabled=1
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY
    ```


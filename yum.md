* YUM = Yellowdog Updater Modified
* It is a package manager used in RHEL/CentOS/Amazon Linux.
* Repositories: `/etc/yum.repos.d/*.repo`
* Metadata: `/var/cache/dnf/`
* Yum Plugins: `/usr/lib/yum-plugins/`
* Config: `/etc/yum/pluginconf.d/`
* RPM Database: `/var/lib/rpm/`
* Package Files (.rpm) -> `downloaded to cache directory`

```bash
yum [options] [command] [package...]

Main options:
  -y                         auto answer yes
  --assumeno                 answer no
  --noplugins                disable plugins
  --skip-broken              skip packages with dependency errors
  --enablerepo=<repoid>      enable repo
  --disablerepo=<repoid>     disable repo
  --setopt=<key=value>       override repo config
  --downloadonly             only download
  --downloaddir=<dir>        download dir
  --security                 only security updates
  --bugfix                   only bugfix updates
  --advisory=<ID>            specific advisory
  --obsoletes                include obsoletes
  --cacheonly                use cache only
  --nogpgcheck               disable GPG validation
  --allowerasing             allow replacing old pkgs
  -q                         quiet mode
  -v                         verbose
  -C                         use cache only
```

```bash
yum install <package>
yum install httpd
yum install git vim wget

yum remove <package>
yum erase <package>

yum update <package>
yum update httpd

#update the whole system 
yum update -y
yum upgrade

#Package info
yum info httpd

yum list httpd
yum list installed nginx
yum list installed httpd
yum list available httpd

[ec2-user@ip-172-31-0-106 ~]$ yum list httpd
Amazon Linux 2023 repository                                   70 MB/s |  49 MB     00:00    
Amazon Linux 2023 Kernel Livepatch repository                 276 kB/s |  29 kB     00:00    
Available Packages
httpd.x86_64                         2.4.65-1.amzn2023.0.2                         amazonlinux[ec2-user@ip-172-31-0-106 ~]$ yum list nginx
Last metadata expiration check: 0:00:07 ago on Thu Nov 27 15:06:32 2025.
Installed Packages
nginx.x86_64                       1:1.28.0-1.amzn2023.0.2                        @amazonlinux

[ec2-user@ip-172-31-0-106 ~]$ yum list installed nginx
Installed Packages
nginx.x86_64                       1:1.28.0-1.amzn2023.0.2                        @amazonlinux[ec2-user@ip-172-31-0-106 ~]$ yum list installed httpd
Error: No matching Packages to list

[ec2-user@ip-172-31-0-106 ~]$ yum list available httpd
Last metadata expiration check: 0:01:05 ago on Thu Nov 27 15:06:32 2025.
Available Packages
httpd.x86_64                         2.4.65-1.amzn2023.0.2                         amazonlinux[ec2-user@ip-172-31-0-106 ~]$ yum list available nginx
Last metadata expiration check: 0:01:09 ago on Thu Nov 27 15:06:32 2025.
Error: No matching Packages to list

#Search a package
yum search docker
yum search all python

#Show list dependencies
yum deplist nginx

#Only download RPM file not install
yum install --downloadonly --downloaddir=/tmp httpd

[ec2-user@ip-172-31-0-106 ~]$ sudo systemctl start httpd
Failed to start httpd.service: Unit httpd.service not found.
[ec2-user@ip-172-31-0-106 ~]$ ls /tmp/httpd-*
/tmp/httpd-2.4.65-1.amzn2023.0.2.x86_64.rpm
/tmp/httpd-core-2.4.65-1.amzn2023.0.2.x86_64.rpm
/tmp/httpd-filesystem-2.4.65-1.amzn2023.0.2.noarch.rpm
/tmp/httpd-tools-2.4.65-1.amzn2023.0.2.x86_64.rpm

yum clean all #cleans everything (recommended)
yum clean metadata #removes repo metadata
yum clean packages #removes cached RPMs
yum clean expire-cache #force metadata refresh
yum clean dbcache #removes yum DB cache

yum install -y --nogpgcheck package.rpm #if face problem with gpg key error

yum install --skip-broken
yum update --allowerasing

#RPM DB corruption
rm -f /var/lib/rpm/__db*
rpm --rebuilddb
yum clean all

ansible all -m yum -a "name=* state=latest"


```

| Command      | Description                      |
| ------------ | -------------------------------- |
| install      | Install packages                 |
| remove       | Remove packages                  |
| update       | Update packages                  |
| upgrade      | Update all packages              |
| downgrade    | Install old version              |
| check-update | Check updates                    |
| list         | List pkgs                        |
| info         | Package info                     |
| search       | Search package                   |
| provides     | Find which package contains file |
| history      | Full transaction history         |
| clean        | Clean cache                      |
| repolist     | List repos                       |
| deplist      | Package dependencies             |
| check        | Verify system problems           |
| makecache    | Force metadata sync              |
| localinstall | Install local RPM                |
| localupdate  | Update using local RPM           |
| reinstall    | Reinstall pkg                    |
| swap         | Swap one pkg for another         |
| version      | Compare pkg versions             |

### Repo structure
`/etc/yum.repos.d/*.repo`
```bash
[reponame]
name=Repository name
baseurl=https://...
mirrorlist=https://...
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY
```

### If using DVD drive
```bash
sudo mkdir -p /etc/yum.repos.d/
sudo mkdir /mnt/pkgs
```
```bash
mount /dev/cdrom /mnt/pkgs
or 
mount /dev/sr1 /mnt/pkgs
```
```bash
cat << EOF > /etc/yum.repos.d/baseos.repo
[BaseOS]
name=Red Hat Enterprise Linux $releasever - BaseOS
baseurl=file:///mnt/pkgs/BaseOS
enabled=1
gpgcheck=0
EOF
```
```bash
cat << EOF > /etc/yum.repos.d/appstream.repo
[AppStream]
name=Red Hat Enterprise Linux $releasever - AppStream
baseurl=file:///mnt/pkgs/AppStream
enabled=1
gpgcheck=0
EOF
```

---
### If using Red Hat CDN (requires subscription)
* `/etc/yum.repos.d/redhat.repo` is automatically created by RHSM.
* But you can create manual repo:
* **BaseOS**
    ```bash
    [BaseOS]
    name=RHEL BaseOS
    baseurl=https://cdn.redhat.com/content/dist/rhel8/$releasever/$basearch/baseos/os
    enabled=1
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
    sslverify=1
    sslcacert=/etc/rhsm/ca/redhat-uep.pem
    ```
* **AppStream**
    ```bash
    [AppStream]
    name=RHEL AppStream
    baseurl=https://cdn.redhat.com/content/dist/rhel8/$releasever/$basearch/appstream/os
    enabled=1
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
    sslverify=1
    sslcacert=/etc/rhsm/ca/redhat-uep.pem
    ```

### Dockerfile
```dockerfile
FROM centos:7
RUN yum clean all && yum install -y httpd && yum clean all
```
```dockerfile
RUN yum install -y nginx \
    && yum clean all \
    && rm -rf /var/cache/yum
```

### Adding a Repos

**METHOD 1 — Add Repo Using `.repo` File (Most Common)**
    ```
    # --------------------------------------------------------
    # MANUAL .repo FILE — MOST COMMON & PRODUCTION STANDARD
    # Location: /etc/yum.repos.d/<name>.repo
    # --------------------------------------------------------

    sudo vi /etc/yum.repos.d/myrepo.repo

    [myrepo]
    name=My Custom Repository
    baseurl=http://192.168.1.10/repo/
    enabled=1           # 1 = enable, 0 = disable
    gpgcheck=1          # verify package signatures
    gpgkey=http://192.168.1.10/repo/RPM-GPG-KEY
    ```

    ```
    # Refresh repo cache
    dnf clean all
    dnf repolist
    ```

---

# 🟦 **METHOD 2 — Add Repo Using yum-config-manager / dnf config-manager**

```
# --------------------------------------------------------
# CONFIG-MANAGER — Automatically creates .repo files
# Requires yum-utils (RHEL7) or dnf-plugins-core (RHEL8+)
# --------------------------------------------------------

# Install plugin
# RHEL 7:
yum install -y yum-utils

# RHEL 8+:
dnf install -y dnf-plugins-core
```

### Add Repo URL:

```
dnf config-manager --add-repo http://192.168.1.10/repo/
```

### Add Repo With Custom Name:

```
dnf config-manager --add-repo=http://server/app/ --setopt=name=apprepo
```

---

# 🟦 **METHOD 3 — Enable / Disable Repositories**

```
# --------------------------------------------------------
# ENABLE OR DISABLE EXISTING REPOSITORIES
# Useful for AppStream/BaseOS, Docker, Kubernetes repos
# --------------------------------------------------------

dnf config-manager --enable myrepo
dnf config-manager --disable myrepo
```

---

# 🟦 **METHOD 4 — Add Local Directory / ISO Repository**

```
# --------------------------------------------------------
# LOCAL DIRECTORY REPO — file:// based
# Used for ISO mounts, USB repositories, offline machines
# --------------------------------------------------------

# Mount ISO
mount /dev/sr0 /mnt

# Create repo file
vi /etc/yum.repos.d/local.repo

[local]
name=Local ISO Repository
baseurl=file:///mnt
enabled=1
gpgcheck=0          # ISO metadata is already trusted
```

```
dnf clean all
dnf repolist
```

---

# 🟦 **METHOD 5 — Add NFS Repository**

```
# --------------------------------------------------------
# NFS REPOSITORY — Used in enterprise networks
# --------------------------------------------------------

[nfsrepo]
name=Internal NFS Repo
baseurl=nfs://10.0.0.5:/exports/repo
enabled=1
gpgcheck=0
```

---

# 🟦 **METHOD 6 — HTTPS Repository With Certificates**

```
# --------------------------------------------------------
# SECURE HTTPS REPO — Requires corporate CA certificate
# Common in banks, telecom, enterprise environments
# --------------------------------------------------------

[secure-repo]
name=Company Secure Repo
baseurl=https://repo.company.com/rhel8/
enabled=1
gpgcheck=1
sslverify=1
sslcacert=/etc/pki/tls/certs/internal-ca.crt
```

---

# 🟦 **METHOD 7 — baseurl vs mirrorlist Based Repo**

```
# --------------------------------------------------------
# BASEURL — Direct repo server
# --------------------------------------------------------

baseurl=http://repo.server/rhel8/
```

```
# --------------------------------------------------------
# MIRRORLIST — Server gives best mirror dynamically
# Used in CentOS/Fedora official repos
# --------------------------------------------------------

mirrorlist=http://mirrorlist.centos.org/?release=8&arch=x86_64

# NOTE: DO NOT USE baseurl and mirrorlist together
```

---

# 🟦 **METHOD 8 — Import GPG Keys for Trusted Repos**

```
# --------------------------------------------------------
# GPG KEYS — Required when gpgcheck=1
# Ensures package authenticity
# --------------------------------------------------------

rpm --import http://server/repo/RPM-GPG-KEY
```

Or:

```
dnf install https://server/repo/RPM-GPG-KEY
```

---

# 🟦 **METHOD 9 — Add Official RHEL Repos (Subscription Manager)**

```
# --------------------------------------------------------
# RHEL ONLY — subscription-manager controls Red Hat repos
# --------------------------------------------------------

# Enable repo
subscription-manager repos --enable=rhel-8-for-x86_64-appstream-rpms

# Disable repo
subscription-manager repos --disable=rhel-8-for-x86_64-baseos-rpms
```

---

# 🟦 **METHOD 10 — Docker, Kubernetes, etc. Repos**

### Docker CE repo:

```
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
```

### Kubernetes repo:

```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes Repository
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
EOF
```

### Node Exporter repo example:

```
[exporter]
name=Prometheus Node Exporter
baseurl=https://packagecloud.io/prometheus-rpm/release/el/8/x86_64
enabled=1
gpgcheck=0
```

---

# 🟦 **METHOD 11 — Adding Your OWN Local Repo (from your Server)**

```
# --------------------------------------------------------
# HOST YOUR OWN REPO THROUGH NGINX / APACHE (Detailed Guide)
# --------------------------------------------------------
# Ask: "Give full local repo creation guide"
# and I will provide the complete Reposync + Createrepo guide
```

---

# 🟦 **HOW TO VERIFY A REPO**

```
dnf repolist
dnf list available
dnf info httpd
```

---

# 🟦 **CLEAR CACHE After Adding Repo**

```
dnf clean metadata
```

or:

```
yum clean all
```

---

### Ansible

**SECTION 1 — Ansible Modules for YUM/DNF**
    ```
    # --------------------------------------------------------
    # SECTION 1 — AVAILABLE MODULES FOR PACKAGE MGMT
    # --------------------------------------------------------
    # yum:          Use for RHEL/CentOS 7
    # dnf:          Use for RHEL8+, Rocky, Alma, Fedora
    # package:      Universal abstraction that auto-selects yum/dnf
    # yum_repository: Create / modify repo config files
    # rpm_key:      Import GPG keys
    # --------------------------------------------------------
    # RECOMMENDATION:
    # Use 'package:' for maximum portability.
    # --------------------------------------------------------
    ```

**SECTION 2 — Install Packages (All Patterns)**
    ```
    # --------------------------------------------------------
    # INSTALL LATEST VERSION
    # --------------------------------------------------------
    - name: Install nginx
    package:
        name: nginx
        state: present     # or latest
    ```

    ```
    # --------------------------------------------------------
    # INSTALL SPECIFIC VERSION
    # --------------------------------------------------------
    - name: Install httpd version
    yum:
        name: httpd-2.4.6-97.el7
        state: present
    ```

    ```
    # --------------------------------------------------------
    # INSTALL MULTIPLE PACKAGES
    # --------------------------------------------------------
    - name: Install basic tools
    package:
        name:
        - git
        - unzip
        - httpd
        state: present
    ```

**SECTION 3 — Remove Packages**
    ```
    # --------------------------------------------------------
    # REMOVE PACKAGES
    # --------------------------------------------------------
    - name: Remove nginx
    package:
        name: nginx
        state: absent
    ```

**SECTION 4 — Updating Packages**
    ```
    # --------------------------------------------------------
    # UPDATE ONE PACKAGE
    # --------------------------------------------------------
    - name: Update httpd
    yum:
        name: httpd
        state: latest
    ```

    ```
    # --------------------------------------------------------
    # UPDATE ALL PACKAGES (SAFE FULL SYSTEM UPGRADE)
    # --------------------------------------------------------
    - name: Update entire system
    yum:
        name: '*'
        state: latest
    ```

    ```
    # RHEL8+ (DNF)
    - name: Full system update (DNF)
    dnf:
        name: "*"
        state: latest
    ```

**SECTION 5 — Check Available Updates**
    ```
    # --------------------------------------------------------
    # LIST AVAILABLE UPDATES
    # Useful for conditional patching, reporting, etc.
    # --------------------------------------------------------

    - name: Check updates
    yum:
        list: updates
    register: updates
    ```

    ```
    - debug:
        var: updates
    ```

**SECTION 6 — Repo Management Using Ansible**
### Add repository:
    ```
    # --------------------------------------------------------
    # ADD CUSTOM REPOSITORY (.repo file automation)
    # --------------------------------------------------------
    - name: Add custom repo
    yum_repository:
        name: myrepo
        description: Internal Repo
        baseurl: http://10.0.0.1/repo/
        enabled: yes
        gpgcheck: yes
        gpgkey: http://10.0.0.1/repo/RPM-GPG-KEY
    ```

### Remove repo:
    ```
    # --------------------------------------------------------
    # REMOVE A REPOSITORY
    # --------------------------------------------------------
    - name: Remove repo
    yum_repository:
        name: myrepo
        state: absent
    ```

### Add multiple repos:
    ```
    # --------------------------------------------------------
    # ADD MULTIPLE REPOS USING LOOP
    # --------------------------------------------------------
    - name: Add multi repos
    yum_repository:
        name: "{{ item.name }}"
        baseurl: "{{ item.url }}"
        enabled: 1
        gpgcheck: 0
    loop:
        - { name: repo1, url: "http://10.0.0.1/repo1/" }
        - { name: repo2, url: "http://10.0.0.1/repo2/" }
    ```

**SECTION 7 — GPG Key Import Using Ansible**
    ```
    # --------------------------------------------------------
    # GPG KEY IMPORT — Required when gpgcheck=1
    # --------------------------------------------------------
    - name: Import repo key
    rpm_key:
        key: http://10.0.0.1/repo/RPM-GPG-KEY
        state: present
    ```

**SECTION 8 — Install Package Groups (@group)**
    ```
    # --------------------------------------------------------
    # INSTALL GROUPS — Equivalent to yum groupinstall
    # --------------------------------------------------------

    - name: Install Developer Tools
    yum:
        name: "@Development Tools"
        state: present
    ```

    ```
    # DNF group example
    - name: Install virtualization group
    dnf:
        name: "@virtualization"
        state: present
    ```

**SECTION 9 — Version Locking (Prevent Updates)**
    ```
    # --------------------------------------------------------
    # VERSION LOCKING (RHEL7 - yum-plugin-versionlock)
    # Prevents auto-updating critical pkgs like httpd, kernel.
    # --------------------------------------------------------

    - name: Install versionlock plugin
    yum:
        name: yum-plugin-versionlock
        state: present
    ```

    ```
    - name: Lock httpd version
    command: yum versionlock add httpd*
    ```

    ```
    # RHEL8+ (DNF versionlock)
    dnf versionlock add httpd-2.4.6*
    ```

**SECTION 10 — Rolling Updates (Zero Downtime)**
    ```
    # --------------------------------------------------------
    # SERIAL UPDATES → Updates servers one-by-one.
    # Prevents full downtime. Used in production fleets.
    # --------------------------------------------------------

    - hosts: webservers
    serial: 1        # apply tasks to only 1 node at a time
    tasks:
        - name: Patch system
        yum:
            name: "*"
            state: latest

        - name: Restart service
        service:
            name: httpd
            state: restarted
    ```

**SECTION 11 — Kernel Update + Conditional Reboot**
    ```
    # --------------------------------------------------------
    # INSTALL NEW KERNEL
    # --------------------------------------------------------
    - name: Install latest kernel
    yum:
        name: kernel
        state: latest
    ```

    ```
    # --------------------------------------------------------
    # CONDITIONAL REBOOT (only if kernel changed)
    # --------------------------------------------------------
    - name: Reboot if needed
    reboot:
        msg: "Reboot after kernel patch"
    ```

**SECTION 12 — Security-Only Patching**
    ```
    # --------------------------------------------------------
    # SECURITY PATCHES ONLY (YUM)
    # --------------------------------------------------------
    - name: Security patches
    yum:
        security: yes
        state: latest
    ```

    ```
    # DNF version
    - name: DNF security updates
    dnf:
        security: yes
        state: latest
    ```

**SECTION 13 — Running Yum/DNF Inside Docker Containers**
    ```
    # --------------------------------------------------------
    # USING ANSIBLE TO MANAGE PACKAGES INSIDE CONTAINERS
    # --------------------------------------------------------

    - name: Install vim inside Docker container
    command: docker exec web1 yum -y install vim
    ```

**SECTION 14 — Yum/DNF for Kubernetes Nodes**
    ```
    # --------------------------------------------------------
    # TYPICAL KUBERNETES NODE SETUP
    # --------------------------------------------------------
    - hosts: k8s_nodes
    tasks:
        - name: Install kubelet + CRI-O runtime
        yum:
            name:
            - kubelet
            - cri-o
            state: present
    ```


**SECTION 15 — FULL ENTERPRISE PLAYBOOK (END-TO-END)**
    ```
    # --------------------------------------------------------
    # FULL PRODUCTION-GRADE PACKAGE MGMT WORKFLOW
    # --------------------------------------------------------

    - hosts: all
    become: yes

    tasks:

        - name: Add internal repo
        yum_repository:
            name: internal
            baseurl: http://repo.infra.local/rhel8/
            enabled: 1

        - name: Import GPG key
        rpm_key:
            key: http://repo.infra.local/GPG-KEY
            state: present

        - name: Update system packages
        yum:
            name: "*"
            state: latest

        - name: Install base utilities
        package:
            name:
            - vim
            - net-tools
            - lsof
            - unzip
            state: present

        - name: Remove insecure tools
        package:
            name:
            - telnet
            - rsh
            state: absent

        - name: Security patches
        yum:
            security: yes
            state: latest

        - name: Reboot if kernel changed
        reboot:
    ```

---


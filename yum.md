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
* RPM = Red Hat Package Manager
* Used in:
    * RHEL
    * CentOS
    * Rocky Linux
    * AlmaLinux
    * Fedora
    * Amazon Linux 2023
* YUM/DNF are just front-end tools.
* RPM is the actual low-level package manager.

```bash
-q       query
-qa      query all installed packages
-ql      list package files
-qi      show package info
-qf      find which package owns a file
-qR      list requires (dependencies)
-q --whatprovides <file>
```
```bash
-V     verify installed package
-Va    verify all installed packages
-Vp    verify rpm file
--nomd5
--noscripts
--nodigest
```
```bash
--checksig
--import
--addsign
--delsign
```
```bash
--initdb
--rebuilddb
--verifydb
```

```bash
rpm -ivh package.rpm #Install,Verbose,Hash progress bar
rpm -ivh package.rpm #Update,Verbose,Hash progress bar
rpm -e package_name #Erase,Verbose,Hash progress bar

rpm -q httpd #Package installed or not
rpm -qi httpd #Show package details
rpm -ql httpd #List files installed by a package
rpm -qf /usr/bin/python3 #Which package owns this file
rpm -qpi nginx.rpm #Query an RPM file (without installing)

rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release #Import GPG key (required to verify signed packages)
rpm --checksig nginx.rpm #Check digital signature
rpm -qa gpg-pubkey* #List installed keys

#RPM database is stored at:
/var/lib/rpm/

#Rebuild rpmdb (if corrupted)
rm -f /var/lib/rpm/__db*
rpm --rebuilddb
```

### dockerfile
```dockerfile
FROM rockylinux:9
COPY nginx.rpm /tmp/
RUN rpm -ivh /tmp/nginx.rpm --nodeps \
    && rm -rf /var/lib/rpm/__db* && rpm --rebuilddb
```

### Ways to create Repository

**1️⃣ LOCAL REPOSITORY CREATION (Directory-Based)**
    ```
    # -----------------------------------------------
    # LOCAL REPO (file://) → For offline / local folders
    # -----------------------------------------------

    # Create directory for repo
    mkdir -p /opt/localrepo

    # Copy RPM packages
    cp *.rpm /opt/localrepo/

    # Generate metadata
    createrepo /opt/localrepo

    # Create repo file
    cat <<EOF > /etc/yum.repos.d/local.repo
    [localrepo]
    name=Local RPM Repository
    baseurl=file:///opt/localrepo
    enabled=1
    gpgcheck=0
    EOF

    # Clean cache and verify
    dnf clean all
    dnf repolist
    ```

**2️⃣ REMOTE REPOSITORY USING NGINX (HTTP Repo)**
    ```
    # ---------------------------------------------------------
    # HTTP REPO (Nginx) → Used to serve RPMs over HTTP locally
    # ---------------------------------------------------------

    # Install and start nginx
    dnf install -y nginx
    systemctl enable --now nginx

    # Create remote repo directory
    mkdir -p /usr/share/nginx/html/repo
    cp *.rpm /usr/share/nginx/html/repo/

    # Create metadata
    createrepo /usr/share/nginx/html/repo/

    # Enable autoindex listing
    sed -i 's/autoindex off/autoindex on/' /etc/nginx/nginx.conf
    systemctl reload nginx

    # Example repo URL: http://<server-ip>/repo/

    # Client-side repo file
    cat <<EOF > /etc/yum.repos.d/myrepo.repo
    [myrepo]
    name=My Nginx Repo
    baseurl=http://<server-ip>/repo/
    enabled=1
    gpgcheck=0
    EOF
    ```

**3️⃣ REMOTE REPOSITORY USING APACHE (httpd)**
    ```
    # ---------------------------------------------------------
    # HTTP REPO (Apache) → Alternative to Nginx, enterprise use
    # ---------------------------------------------------------

    # Install Apache
    dnf install -y httpd
    systemctl enable --now httpd

    # Create repo directory
    mkdir -p /var/www/html/repo
    cp *.rpm /var/www/html/repo/

    # Generate metadata
    createrepo /var/www/html/repo/

    # Fix permissions
    chown -R apache:apache /var/www/html/repo

    # Access URL: http://<ip>/repo/

    # Create repo file on client
    cat <<EOF > /etc/yum.repos.d/apache.repo
    [apache-repo]
    name=Apache Hosted Repo
    baseurl=http://<server-ip>/repo/
    enabled=1
    gpgcheck=0
    EOF
    ```


**4️⃣ REPOSYNC MIRROR + CREATEREPO (AIR-GAPPED MIRROR)**
    ```
    # ---------------------------------------------------------------
    # MIRROR OFFICIAL REPOS (reposync) → Used in offline datacenters
    # ---------------------------------------------------------------

    # Install required tools
    dnf install -y yum-utils createrepo

    # Download BaseOS and AppStream
    reposync --repoid=baseos --download-path=/mirror --download-metadata
    reposync --repoid=appstream --download-path=/mirror --download-metadata

    # Fix metadata (optional)
    createrepo --update /mirror/baseos
    createrepo --update /mirror/appstream

    # Transfer directory to offline server (USB/DVD/rsync)

    # Offline server repo file
    cat <<EOF > /etc/yum.repos.d/offline.repo
    [offline-baseos]
    name=Offline BaseOS Repo
    baseurl=file:///mirror/baseos
    enabled=1
    gpgcheck=0
    EOF
    ```


**5️⃣ AMAZON S3 STATIC REPOSITORY + CLOUDFRONT**
    ```
    # ----------------------------------------------------
    # S3 REPO → Public or private cloud-based RPM hosting
    # ----------------------------------------------------

    # Create S3 bucket: mycompany-rpm-repo

    # Upload RPMs and repodata/ to S3
    aws s3 sync /repo/ s3://mycompany-rpm-repo/

    # Ensure S3 bucket has public-read/static hosting enabled

    # Optional: Add CloudFront CDN distribution

    # Repo file for S3
    cat <<EOF > /etc/yum.repos.d/s3.repo
    [s3repo]
    name=S3 RPM Repository
    baseurl=https://mycompany-rpm-repo.s3.amazonaws.com/
    enabled=1
    gpgcheck=0
    EOF
    ```


**6️⃣ LOCAL ISO-BASED REPOSITORY**
    ```
    # ----------------------------------------------------
    # ISO REPO → Mount ISO and use it as a BaseOS repo
    # ----------------------------------------------------

    # Mount RHEL/Rocky/Alma ISO
    mount -o loop /path/Rocky-9.iso /mnt

    # Create repo file
    cat <<EOF > /etc/yum.repos.d/iso.repo
    [iso-repo]
    name=ISO Mounted Repo
    baseurl=file:///mnt
    enabled=1
    gpgcheck=0
    EOF

    # Test repo
    dnf repolist
    ```


**7️⃣ REPO WITH GPG SIGNING**
    ```
    # --------------------------------------------------------
    # GPG SIGNING → Required in production to ensure integrity
    # --------------------------------------------------------

    # Generate GPG key
    gpg --full-generate-key   # Select RSA + RSA, 4096 bits

    # Export public key
    gpg --export -a KEYID > RPM-GPG-KEY-MYREPO

    # Put the key inside your repo
    cp RPM-GPG-KEY-MYREPO /var/www/html/repo/

    # Sign all RPM packages
    rpm --addsign /var/www/html/repo/*.rpm

    # Rebuild repo metadata
    createrepo --update /var/www/html/repo/

    # Update client repo file
    cat <<EOF > /etc/yum.repos.d/signed.repo
    [signed-repo]
    name=Signed Repo
    baseurl=http://<ip>/repo/
    enabled=1
    gpgcheck=1
    gpgkey=http://<ip>/repo/RPM-GPG-KEY-MYREPO
    EOF
    ```


**8️⃣ DOCKER CONTAINER THAT SERVES A REPOSITORY**
    ```
    # ---------------------------------------------------------------
    # DOCKER REPO → Portable RPM repo packaged inside a container
    # ---------------------------------------------------------------

    # Create Dockerfile
    cat <<EOF > Dockerfile
    FROM rockylinux:9
    RUN mkdir -p /repo
    COPY *.rpm /repo/
    RUN createrepo /repo
    WORKDIR /repo
    CMD ["python3", "-m", "http.server", "80"]
    EOF

    # Build container
    docker build -t mylocalrepo .

    # Run container on port 8080
    docker run -d -p 8080:80 mylocalrepo

    # Repo URL: http://localhost:8080/

    # Create repo file for clients
    cat <<EOF > /etc/yum.repos.d/docker.repo
    [docker-repo]
    name=Docker Hosted Repo
    baseurl=http://<server-ip>:8080/
    enabled=1
    gpgcheck=0
    EOF
    ```


**9️⃣ NFS-BASED REPO**
    ```
    # ---------------------------------------------
    # NFS REPO → Used in internal enterprise LAN
    # ---------------------------------------------

    # On NFS Server
    dnf install -y nfs-utils
    mkdir -p /export/repo
    cp *.rpm /export/repo/
    createrepo /export/repo

    echo "/export/repo *(ro)" >> /etc/exports
    exportfs -r
    systemctl enable --now nfs-server

    # On NFS Client
    mkdir -p /mnt/nfsrepo
    mount server:/export/repo /mnt/nfsrepo

    # Repo file
    cat <<EOF > /etc/yum.repos.d/nfs.repo
    [nfsrepo]
    name=NFS Repo
    baseurl=nfs://server:/export/repo
    enabled=1
    gpgcheck=0
    EOF
    ```

**🔟 HOW TO UPDATE REPO When Adding/Removing RPMs**
    ```
    # -------------------------------------------
    # Update metadata after adding new RPMs
    # -------------------------------------------

    cp new.rpm /repo/
    createrepo --update /repo/

    # -------------------------------------------
    # After deleting RPMs rebuild fully
    # -------------------------------------------

    rm -rf /repo/repodata/
    createrepo /repo/
    ```


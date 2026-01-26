* File share over the network on linux to linux / linux to unix machines

```bash
yum install nfs-utils -y #rhel

apt update #ubuntu
apt install nfs-kernel-server -y

mkdir -p /k8s-data
chmod 777 /k8s-data

vi /etc/exports
/k8s-data *(rw,sync,no_root_squash,no_subtree_check)
/k8s-data 192.168.1.0/24(rw,sync,no_root_squash)
/k8s-data 192.168.1.0/24(rw,sync,no_root_squash,no_subtree_check,no_all_squash,insecure)

exportfs -rav
exportfs -r
exportfs -a
exportfs -v

systemctl enable --now nfs-server #rhel
systemctl enable --now nfs-kernel-server #ubuntu
systemctl status nfs-server

firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --reload

showmount -e #How summary of export file on NFS server
showmount -e localhost
showmount -e <ip/hostname>

showmount -d <ip/hostname> #show all dir and subdirectories in the share export from the NFS server

df -h -F nfs #show size of nfs share in human readable form
df -k -F nfs #show size of nfs share in KBs
df -m -F nfs #show size of nfs share in MBs

showmount -a #ON SERVER(<IP>:<dir>) ---> show  which device use nfs server and which dir are mount 

nfsstat -s #SERVER --> show load on server
nfsstat -c #CLIENT --> show how much request client initiated

mount

mount 192.168.29.106:/demo /mnt
mount -t nfs <server-ip>:/k8s-data /mnt/nfs
mount -t nfs 192.168.29.106:/k8s-data /mnt/nfs
mount -t nfs -o vers=4 192.168.0.15:/srv/nfs/kubedata /mnt
mount -t nfs -o vers=3 192.168.0.15:/srv/nfs/kubedata /mnt

lsmod | grep nfs
modprobe nfs


vi /etc/fstab
10.0.0.99:/k8s-data /mnt/nfs nfs defaults 0 0
mount -a


mount -t nfs
mount -t nfs3
mount -t nfs4

yum install nfs-utils -y #rhel client
apt install nfs-common -y #ubuntu client

ss -tulnp | grep nfs

mount --move /mnt /newmnt

findmnt
findmnt -t ext4
findmnt -t nfs4
findmnt /mnt; echo $?
```

### Shared mount point

```bash
mkdir /mnt/mount1
mkdir /mnt/mount2

mount --bind /mnt/mount1 /mnt/mount1
mount --make-shared /mnt/mount1
mount --bind /mnt/mount1 /mnt/mount2

touch /mnt/mount2/file1
ll /mnt/mount1/

mount -t nfs 10.0.0.99:/k8s-data /mnt/mount2
findmnt /mnt/mount2; echo $?
ll /mnt/mount1/
```

### Slave Mounts

```bash
mkdir /mnt/mount1
mkdir /mnt/mount2

mount --bind /mnt/mount1 /mnt/mount1
mount --make-shared /mnt/mount1
mount --bind /mnt/mount1 /mnt/mount2
mount --make-slave /mnt/mount2

touch /mnt/mount2/file1
ll /mnt/mount1/

mount -t nfs 10.0.0.99:/k8s-data /mnt/mount2
findmnt /mnt/mount2; echo $?
ll /mnt/mount1/
```

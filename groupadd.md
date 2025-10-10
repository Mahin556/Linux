```bash
sudo groupadd developers  #Create a simple group

sudo groupadd -f developers  #Force creation (ignore if already exists)

sudo groupadd -g 1050 developers  #Create with specific GID

sudo groupadd -f -g 1050 developers  #Force + GID (ignores duplicate GID if exists)

sudo groupadd -o -g 1000 sharedgroup  #Allow non-unique GID

sudo groupadd -r sysadmins  #Create system group

sudo groupadd -K GID_MIN=500 -K GID_MAX=700 testers  #Override defaults (/etc/login.defs)

sudo groupadd -R /mnt/chroot developers  #Use chroot environment

sudo groupadd -r -g 800 syslogs  #System group + custom GID

sudo groupadd -f -o -g 1000 -p $(openssl passwd -crypt mypass) devops  #Force, non-unique, and password

sudo groupadd -r -K GID_MIN=200 -K GID_MAX=300 servicegroup  #Override defaults + system group

sudo groupadd -R /mnt/chroot -g 1200 staging_group  #Chroot + GID
```

- Create group with encrypted password Must use openssl or crypt to generate encrypted password.
```bash
# Generate encrypted password:
openssl passwd -crypt mypass
# Example output: abcd1234

# Use it in groupadd:
sudo groupadd -p abcd1234 finance
```

- Verify Group Creation
```bash
getent group developers
tail -n 5 /etc/group
```

- https://www.geeksforgeeks.org/linux-unix/groupadd-command-in-linux-with-examples/


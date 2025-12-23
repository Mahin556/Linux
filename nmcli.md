### References:-
- https://www.geeksforgeeks.org/linux-unix/nmcli-command-in-linux-with-examples/

---

### Network manager

• NetworkManager is the default Linux networking service
• It manages Ethernet, Wi-Fi, VPN, VLAN, Bond, Bridge, Mobile broadband
• Runs as a systemd service
• Provides persistent networking
• Used by nmcli (CLI), nmtui (TUI), and GUI tools
• Default on RHEL, CentOS, Rocky, AlmaLinux, Fedora, Ubuntu

```bash
systemctl status NetworkManager
systemctl start NetworkManager
systemctl stop NetworkManager
systemctl restart NetworkManager
systemctl enable NetworkManager
```
Core components
    • NetworkManager → main daemon
    • nmcli → command-line interface
    • nmtui → text UI (menu based)
    • nm-connection-editor → GUI
    • systemd-networkd → alternative (not used together)

Why NetworkManager exists
    • Old method: manual config files (ifcfg-*, /etc/network/interfaces)
    • Problems:
    • Not dynamic
    • Hard to manage laptops, Wi-Fi, VPN
    • NetworkManager solves:
    • Automatic connection handling
    • Multiple profiles per interface
    • Hot-plug devices
    • Seamless switching (Wi-Fi ↔ Ethernet)

• Important concept: Device vs Connection
    • Device
        • Physical or virtual interface
        • Example: eth0, ens33, wlan0
    • Connection
        • Profile/configuration
        • Stored settings: IP, DNS, gateway
        • One device can have multiple connections
        • Only one connection active per device

• Connection storage
    • Location:
        • /etc/NetworkManager/system-connections/   
    • Files are:
        • Keyfile format
        • Root readable only
        • Changes via nmcli update these files

```bash

# ===============================
# GLOBAL NETWORKING SWITCH
# ===============================
nmcli networking                      # check networking state
nmcli networking on                   # enable all networking
nmcli networking off                  # disable all networking


# ===============================
# GENERAL NETWORKMANAGER INFO
# ===============================
nmcli general status                  # overall NM status
nmcli general hostname                # show hostname
nmcli general hostname new-hostname   # set hostname
nmcli general reload                  # reload NM config
nmcli general permissions             # user permissions
nmcli general logging                 # show logging level


# ===============================
# DEVICE MANAGEMENT
# ===============================
nmcli device status                   # list devices
nmcli device show                     # full device info
nmcli device show eth0                # show specific device
nmcli device set eth0 managed yes     # make device managed
nmcli device disconnect eth0          # disconnect device
nmcli device connect eth0             # reconnect device
nmcli device reapply eth0             # apply changes without down/up


# ===============================
# CONNECTION (PROFILE) MANAGEMENT
# ===============================
nmcli connection show                 # list all connections
nmcli connection show --active        # active connections
nmcli connection show eth0            # show profile details
nmcli connection up eth0              # activate connection
nmcli connection down eth0            # deactivate connection
nmcli connection reload               # reload profiles from disk
nmcli connection delete eth0          # delete profile
nmcli connection clone eth0 eth0-bak  # clone profile

# ===============================
# CREATE ETHERNET CONNECTION
# ===============================
nmcli connection add type ethernet ifname eth0 con-name eth0-dhcp

nmcli connection add type ethernet ifname eth0 con-name eth0-static ip4 192.168.1.10/24 gw4 192.168.1.1

nmcli con modify custeth1 ipv4.method manual ipv4.address 10.0.0.10/8 ipv4.gateway 10.10.10.1

# ===============================
# IP CONFIGURATION (IPv4)
# ===============================
nmcli connection modify eth0 ipv4.method manual
#IP addressing methods
# • auto → DHCP
# • manual → Static IP
# • disabled → No IP
nmcli connection modify eth0 ipv4.method auto
nmcli connection modify eth0 ipv4.method manual
nmcli connection modify eth0 ipv4.method disabled

nmcli connection modify eth0 ipv4.addresses 192.168.1.20/24
nmcli connection modify eth0 ipv4.gateway 192.168.1.1
nmcli connection modify eth0 ipv4.dns "8.8.8.8 8.8.4.4"
nmcli connection modify eth0 ipv4.ignore-auto-dns yes

nmcli connection modify eth0 +ipv4.addresses 192.168.1.21/24
nmcli connection modify eth0 -ipv4.addresses 192.168.1.21/24

#HOW TO ADJUST CONNECTION SETTINGS USING nmcli
#Syntax:
#nmcli connection modify <connection_name> <setting_name> <setting_value>
#Example:
nmcli connection modify my_eth_connection \
ipv4.addresses 192.168.1.2/24 \
ipv4.gateway 192.168.1.1
#Apply changes:
nmcli connection down my_eth_connection
nmcli connection up my_eth_connection

# ===============================
# IPv6 CONFIGURATION
# ===============================
nmcli connection modify eth0 ipv6.method auto
nmcli connection modify eth0 ipv6.method manual
nmcli connection modify eth0 ipv6.method disabled
nmcli connection modify eth0 ipv6.addresses 2001:db8::10/64


# ===============================
# AUTOCONNECT & PRIORITY
# ===============================
nmcli connection modify eth0 connection.autoconnect yes
nmcli connection modify eth0 connection.autoconnect no
nmcli connection modify eth0 connection.autoconnect-priority 100


# ===============================
# ROUTES
# ===============================
nmcli connection modify eth0 +ipv4.routes "10.0.0.0/24 192.168.1.254"
nmcli connection modify eth0 -ipv4.routes "10.0.0.0/24 192.168.1.254"


# ===============================
# MTU & MAC
# ===============================
nmcli connection modify eth0 ethernet.mtu 1500
nmcli connection modify eth0 ethernet.cloned-mac-address XX:XX:XX:XX:XX:XX


# ===============================
# VLAN
# ===============================
nmcli connection add type vlan ifname eth0.100 dev eth0 id 100
nmcli connection modify vlan100 ipv4.addresses 192.168.100.10/24

# ===============================
# BONDING
# ===============================
nmcli connection add type bond ifname bond0 mode active-backup
nmcli connection add type ethernet ifname eth1 master bond0
nmcli connection add type ethernet ifname eth2 master bond0


# ===============================
# BRIDGE
# ===============================
nmcli connection add type bridge ifname br0
nmcli connection add type ethernet ifname eth0 master br0


# ===============================
# VPN (GENERIC)
# ===============================
nmcli connection import type openvpn file client.ovpn
nmcli connection up vpn-name
nmcli connection down vpn-name


# ===============================
# PROXY
# ===============================
nmcli connection modify eth0 proxy.method manual
nmcli connection modify eth0 proxy.http http://proxy:8080


# ===============================
# MONITORING
# ===============================
nmcli monitor                        # live network events
nmcli monitor eth0                   # monitor device


# ===============================
# SCRIPTING / FILTERING
# ===============================
nmcli -t device status
nmcli -f DEVICE,STATE device
nmcli -g IP4.ADDRESS device show eth0


# ===============================
# LOGGING / DEBUG
# ===============================
journalctl -u NetworkManager
nmcli general logging level DEBUG domains ALL


#nmcli OUTPUT OPTIONS (SIMPLE)
#-t , --terse        -> Short output (best for scripts)
#Example:
nmcli -t device status

#-p , --pretty       -> Clean, readable output
#Example:
nmcli -p device status

#-m , --mode         -> Output format
# tabular   (default)
# multiline
# Example:
nmcli -m multiline device show eth0

#-f , --fields       -> Show selected fields only
#Example:
nmcli -f DEVICE,STATE device status
nmcli -f all device show eth0
nmcli -f common device show

#-e , --escape       -> Escape special characters

#-v , --version      -> Show nmcli version
#Example:
nmcli -v

#-h , --help         -> Show help
#Example:
nmcli --help
nmcli connection --help
```
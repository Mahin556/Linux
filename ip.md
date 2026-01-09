```bash
ip link show #Displays all network interfaces (both up and down).

ip link show dev eth0 #Shows details only for a specific device.

ip -br link
ip -br link show #Shows interfaces in a brief (one-line) format — great for quick overviews.

ip link show type veth

ip -br link show type veth up

ip link del vethA

ip link set eth0 up #Activates (enables) the network interface.
ip link set eth0 doown #Deactivates (disables) the interface.

ip link set eth0 name ens33 #Renames the interface (requires the interface to be down).

ip link set eth0 mtu 1400 #Changes the MTU (Maximum Transmission Unit) size.

ip link set eth0 address 00:11:22:33:44:55 #Changes the MAC address of the interface.

ip link set eth0 txqueuelen 1000 #Changes the transmit queue length.

ip link set eth0 netns mynamespace #Moves interface eth0 into another network namespace.

ip link set eth0 promisc on #Enables promiscuous mode (interface receives all packets), Useful for sniffers like Wireshark/tcpdump.

ip link set eth0 promisc off #Disables promiscuous mode.

ip link show lo #Show info about loopback interface

ip link set lo up #Brings up the loopback interface (usually always up).

ip link add veth0 type veth peer name veth1 #Creates a pair of connected virtual Ethernet interfaces (like a cable), Used heavily in containers and namespaces.

ip link delete veth0 #Deletes a veth interface (automatically deletes its peer).

ip link add link eth0 name eth0.10 type vlan id 10 #Creates a VLAN interface on top of eth0 with VLAN ID 10.

ip link add link eth0 name gre1 type gre remote 192.168.1.1 local 192.168.1.2 #Creates a GRE tunnel interface.

ip link delete eth0.10 #Deletes the VLAN interface.

ip link add name br0 type bridge #Creates a bridge interface.

ip link set eth0 master br0 #Adds eth0 as a port to the bridge br0.

ip link set eth0 nomaster #Removes eth0 from its bridge or bond master.

ip link add bond0 type bond #Creates a bonding interface (used for link aggregation).

ip link delete bond0 #Deletes the bonding interface.

ip -s link show #Displays interfaces with statistics (RX/TX packets, errors, drops).

ip -s link show dev eth0 #Shows detailed statistics for one device.

ip link set dev eth0 arp off #Disables ARP on interface.

ip link set dev eth0 arp on #Re-enables ARP.

ip link set dev eth0 group 1 #Assigns interface to group ID 1.
ip link set group 1 up #Later, you can manage all interfaces in a group at once:

ip link set dev eth0 vf 0 mac 00:11:22:33:44:55 #Sets the MAC address for a virtual function (SR-IOV).

ip link delete dev veth0 #Deletes a network interface.

ip link set eth0 down && ip link set eth0 up #Reset an interface

ip -br link show up #Show only active (UP) interfaces
```
`ip link` can manage all kinds of interfaces — both physical and virtual.
When you specify `type`, you’re telling Linux what kind of virtual device you want to create.
```bash
ip link add <name> type <interface-type> [options]
```
| Interface Type       | Layer | Used For                                 | Example                                                        |
| -------------------- | ----- | ---------------------------------------- | -------------------------------------------------------------- |
| **veth**             | L2    | Connect namespaces (Pods)                | `ip link add v1 type veth peer name v2`                        |
| **bridge**           | L2    | Switch-like device                       | `ip link add br0 type bridge`                                  |
| **bond**             | L2    | Link aggregation                         | `ip link add bond0 type bond`                                  |
| **vlan**             | L2    | VLAN tagging (802.1Q)                    | `ip link add link eth0 name eth0.10 type vlan id 10`           |
| **vxlan**            | L2    | Overlay networks                         | `ip link add vxlan100 type vxlan id 100`                       |
| **macvlan**          | L2    | Multiple MACs per NIC                    | `ip link add link eth0 name macvlan0 type macvlan mode bridge` |
| **ipvlan**           | L3    | Multiple IPs per NIC                     | `ip link add link eth0 name ipvlan0 type ipvlan mode l2`       |
| **gre / ipip / sit** | L3    | IP tunneling                             | `ip link add gre1 type gre local 1.1.1.1 remote 2.2.2.2`       |
| **dummy**            | L2    | Virtual interface (no hardware)          | `ip link add dummy0 type dummy`                                |
| **team**             | L2    | Similar to bonding, newer kernel feature | `ip link add team0 type team`                                  |
| **geneve**           | L2    | Advanced overlay tunneling               | `ip link add gnv0 type geneve id 200`                          |
| **can**              | L2    | Controller Area Network                  | `ip link add can0 type can`                                    |

```bash
#Create a Virtual Ethernet Pair (veth)
ip link add veth0 type veth peer name veth1
ip link set veth0 up
ip link set veth1 up

#Create a Bridge
ip link add br0 type bridge
ip link set br0 up
ip link set eth0 master br0
ip link set veth0 master br0

#Create a VLAN Interface
ip link add link eth0 name eth0.10 type vlan id 10
ip link set eth0.10 up

#Create a VXLAN Interface
ip link add vxlan100 type vxlan id 100 dev eth0 dstport 4789
ip link set vxlan100 up

#Create a Bond (Link Aggregation)
ip link add bond0 type bond
ip link set bond0 up
ip link set eth0 master bond0
ip link set eth1 master bond0
echo 802.3ad > /sys/class/net/bond0/bonding/mode

#Create a Dummy Interface
ip link add dummy0 type dummy
ip link set dummy0 up
ip addr add 10.0.0.1/32 dev dummy0

#Create a MACVLAN Interface
ip link add link eth0 name macvlan0 type macvlan mode bridge
ip link set macvlan0 up

#Create an IPIP Tunnel
ip link add tun0 type ipip local 192.168.1.10 remote 192.168.2.10
ip link set tun0 up

#Create a GENEVE Interface
ip link add geneve0 type geneve id 300 dev eth0 dstport 6081
ip link set geneve0 up

#Create an IPVLAN Interface
ip link add link eth0 name ipvlan0 type ipvlan mode l2
ip link set ipvlan0 up

#Create a Team Interface
ip link add team0 type team
ip link set team0 up

#Delete Any Virtual Interface
ip link del <interface-name>
# Example:
ip link del veth0
ip link del br0
ip link del vxlan100

#Verify Interfaces
ip link show
# or in brief format:
ip -br link

ip -s link show (interface)
```
---
```bash
ip a
ip addr
ip addr show
ip address show #Displays all interfaces and their assigned IP addresses.

ip addr show dev eth0 #Show addresses for a specific interface.

ip -br addr show #Shows addresses in brief format (clean, one-line view).
ip -br addr show dev eth0

ip addr add 192.168.1.0/24 dev eth0 #Assigns a new IPv4 address to eth0.
ip addr add 122.168.1.0/24 dev eth0 #Assigns multiple ip to interface
ip addr add 2001:db8::1/64 dev eth0 #Add IPv6

ip addr del 192.168.1.10/24 dev eth0
ip addr del 2001:db8::1/64 dev eth0

ip addr replace 192.168.1.10/24 dev eth0 #Adds the address if it doesn’t exist, or replaces it if it does, • Useful in automation scripts.

ip addr add 192.168.1.10/24 dev eth0 label eth0:home #Adds an IP with a label (like an alias), Useful when one interface handles multiple networks.

ip addr flush dev eth0 #Remove all ip from eth0

ip addr flush label eth0:1 #Removes all addresses with the label eth0:1.

ip addr flush scope global #Removes all globally scoped addresses (keeps local/loopback).

#Reset and Reassign
ip addr flush dev eth0
ip addr add 10.0.0.5/24 dev eth0
ip link set eth0 up

ip link show         # Interface state and MAC
ip addr show         # IP addresses
ip route show        # Routing table
```
| Scope    | Meaning                                      |
| -------- | -------------------------------------------- |
| `global` | Reachable globally (normal IPs)              |
| `link`   | Valid only on local link (e.g., IPv6 fe80::) |
| `host`   | Valid only within the host                   |
| `site`   | Obsolete; used in older IPv6 deployments     |

* All ip addr changes are temporary (until reboot or interface reset).
    * To make them permanent, you must:
        * Use /etc/sysconfig/network-scripts/ifcfg-* on RHEL/CentOS, or
        * Add configuration in /etc/netplan on Ubuntu, or
        * Use NetworkManager / systemd-networkd.

```bash
ip route
#Displays, adds, deletes, and modifies routes in the Linux kernel routing table.
#Replaces old commands like route -n and netstat -r.
#Used by Kubernetes CNIs, Docker, and Linux bridges for container traffic routing.

ip route [ show | add | del | change | replace | flush ] [ options ]

ip route show #Displays the main routing table.
ip route 

ip -br route #Shows routing table in brief format.

ip route show table all #Shows all routing tables, not just the main one (useful in VRFs, policy routing, or Kubernetes pods).

ip route get 8.8.8.8 #Shows which route will be used to reach a given destination.
8.8.8.8 via 192.168.1.1 dev eth0 src 192.168.1.10 uid 1000

ip route add default via 192.168.1.1 dev eth0 #Sets the default gateway (for any destination not in the routing table).

ip route replace default via 10.0.0.1 dev eth1 #Replaces existing default route.

ip route del default #Deletes the default route.

ip route add 10.0.0.0/24 via 192.168.1.1 dev eth0 #Adds a route to network 10.0.0.0/24 through gateway 192.168.1.1.

ip route add 192.168.2.0/24 dev eth1 #Directly connected network (no gateway needed).

ip route add 10.0.2.0/24 dev veth0 #Commonly used inside containers/namespaces.

ip route add 10.0.0.5 via 192.168.1.1 dev eth0 #Adds a route to a single host.

ip route add 192.168.10.10 dev eth1 #Route for one IP via a local interface.

ip route del 10.0.0.0/24 #Deletes a specific route.

ip route del default #Deletes the default route.

ip route replace 10.0.0.0/24 via 192.168.1.254 dev eth0 #ip route change default via 10.1.1.1 dev eth1

ip route flush dev eth0 #Removes all routes associated with eth0.

ip route flush table main #Flushes the main routing table.

ip route add 10.0.0.0/24 via 192.168.1.1 src 192.168.1.10 #Forces packets going to 10.0.0.0/24 to use source IP 192.168.1.10.

ip route add default via 192.168.1.1 dev eth0 metric 100 #Adds a route with a metric (lower = higher priority).

ip route add default via 192.168.1.2 dev eth1 metric 200 #Secondary backup route (used if first fails).

ip route add default nexthop via 192.168.1.1 dev eth0 weight 1 nexthop via 192.168.1.2 dev eth1 weight 1 #This creates a multi-path (ECMP: Equal-Cost Multi-Path) route a single default route that uses multiple gateways for load balancing and redundancy.
#With multiple nexthops, Linux installs multiple routes into the kernel’s routing table, all with equal “costs”.
#Linux kernel will balance outgoing packets between these gateways using per-flow or per-packet load balancing (depending on configuration).
#weight 1 means equal share.
#You can use different weights for unequal distribution.

ip route add default \
  nexthop via 192.168.1.1 dev eth0 weight 2 \
  nexthop via 192.168.1.2 dev eth1 weight 1
ip route show
    default
        nexthop via 192.168.1.1 dev eth0 weight 1
        nexthop via 192.168.1.2 dev eth1 weight 1

ip route add local 192.168.1.10 dev lo #Adds a route that stays local to the host.

ip route add broadcast 192.168.1.255 dev eth0 #Broadcast route.

ip route add unreachable 10.10.10.0/24 #Marks the route as unreachable (useful for testing or blocking).

ip route add prohibit 172.16.0.0/16 #Blocks traffic to that network and returns “administratively prohibited”.
```
* Routing Tables (Policy Routing)
    Linux supports multiple routing tables (main, local, custom).
    Each can be used for different routing policies.
    ```bash
    cat /etc/iproute2/rt_tables #Show all routing tables
    255 local
    254 main
    253 default
    100 custom1

    ip route add 10.0.0.0/24 dev eth1 table custom1 #Add route to a specific table

    ip route show table custom1 #Show routes from a specific table

    ip route del 10.0.0.0/24 table custom1 #Delete route from table

    ip route flush table custom1 #Flush table
    ```
    
* `ip neigh`
    * ip neigh (or ip neighbor) is used to view, add, modify, or delete neighbor entries — that is, mappings between IP addresses and MAC addresses.
    * Linux caches neighbor info for faster communication.
    ```bash
    ip neigh [ show | add | del | change | replace | flush ] [ options ]

    ip neigh show
    Example output (IPv4):
    192.168.1.1 dev eth0 lladdr 00:11:22:33:44:55 REACHABLE
    192.168.1.20 dev eth0 lladdr 00:11:22:33:44:66 STALE
    192.168.1.21 dev eth0  FAILED
    Example output (IPv6):
    fe80::a00:27ff:fe8b:dc7b dev eth0 lladdr 08:00:27:8b:dc:7b router STALE
    ```
    * Neighbor States

        | State        | Meaning                                      |
        | ------------ | -------------------------------------------- |
        | `INCOMPLETE` | ARP request sent, waiting for reply          |
        | `REACHABLE`  | Recently confirmed reachable                 |
        | `STALE`      | No recent confirmation, but still usable     |
        | `DELAY`      | Waiting before probe                         |
        | `PROBE`      | Actively probing (sending ARP request)       |
        | `FAILED`     | No response after multiple attempts          |
        | `PERMANENT`  | Static entry (never expires)                 |
        | `NOARP`      | No ARP required (e.g., point-to-point links) |

    ```bash
    ip neigh show dev eth0 #Shows entries only for eth0.

    ip neigh add 192.168.1.100 lladdr 00:11:22:33:44:99 dev eth0 nud permanent #Static permanent route

    ip neigh del 192.168.1.100 dev eth0

    ip neigh replace 192.168.1.100 lladdr 00:11:22:33:44:AA dev eth0 nud reachable

    ip neigh flush all

    ip neigh flush dev eth0

    ip -6 neigh #IPv6 doesn’t use ARP; it uses NDP (Neighbor Discovery Protocol).

    ip neigh show | grep FAILED
    ```

* **Example: ARP Lifecycle**
    * When you ping a new host:
        ```bash
        ping 192.168.1.5
        ```
    * The kernel:
        * Sends ARP request: “Who has 192.168.1.5?”
        * Target responds with its MAC address.
        * Kernel stores it in neighbor table:
            * 192.168.1.5 dev eth0 lladdr 00:50:56:e5:23:7b REACHABLE
            * If unused for a while, it becomes STALE.
            * When next used, kernel probes again to refresh.
        * You can see it evolve live using:
            ```bash
            watch -n1 ip neigh show dev eth0
            ```
    
* **In Kubernetes / CNI Context**
    * Each pod has its own neighbor table, isolated in its network namespace.
    * The CNI plugin (e.g., Flannel, Calico) sets up veth pairs so that:
        * The pod-side veth learns the bridge MAC as its neighbor (for gateway).
        * The host bridge learns the pod veth MAC as its neighbor.
        * That’s how the kernel forwards packets at Layer 2 between pods and the bridge.

    
* **Network Namespace**
* A network namespace (or netns) is an isolated copy of the Linux network stack.
* Each namespace has its own:
    * Network interfaces
    * Routing tables
    * ARP/neighbor tables
    * iptables/firewall rules
    * Sockets and connections
* Processes inside one namespace cannot see or affect another namespace’s network environment — just like containers or pods.
* Think of it as a mini-network inside your Linux system.

```bash
ip netns [ add | del | list | exec | identify | set | monitor ]

ip netns list #List Existing Network Namespaces
ip netns

ip netns add testns #Creates a namespace called testns. ---> /var/run/netns/testns

ip netns exec testns ip addr #This runs ip addr inside the testns namespace.
ip netns exec testns ip link set lo up

ip netns del testns

ip netns identify <pid> #You can check which namespace a process belongs to
ls -l /proc/<pid>/ns/net #directly --> Each unique inode number = a unique namespace

ip netns exec testns bash #You can attach a running process to a namespace-->Everything you run (ping, curl, ip addr) happens inside that isolated network stack.

ip netns monitor #Shows when namespaces are created or deleted in real time.
```
```bash
ip link add veth0 type veth peer name veth1 #Create a veth Pair to Connect Namespaces and host
ip link set veth1 netns testns #Move one end to the namespace:

ip addr add 10.0.0.1/24 dev veth0
ip link set veth0 up
ip netns exec testns ip addr add 10.0.0.2/24 dev veth1
ip netns exec testns ip link set veth1 up
ip netns exec testns ping 10.0.0.1

ip netns exec testns ip route add default via 10.0.0.1
```
* Two Namespaces Communicating
```bash
ip netns add red
ip netns add blue

ip link add veth-red type veth peer name veth-blue
ip link set veth-red netns red
ip link set veth-blue netns blue

ip netns exec red ip addr add 10.1.1.1/24 dev veth-red
ip netns exec blue ip addr add 10.1.1.2/24 dev veth-blue

ip netns exec red ip link set veth-red up
ip netns exec blue ip link set veth-blue up
ip netns exec red ip link set lo up
ip netns exec blue ip link set lo up

ip netns exec red ping 10.1.1.2
```

* **Integration with Kubernetes and Docker**
    * Every pod in Kubernetes runs inside its own network namespace.
    * The CNI plugin creates:
        * A veth pair (one end in pod namespace, one in host namespace).
        * A bridge interface (like cni0) on the host.
        * Routes and IPs using ip addr, ip route, and ip neigh.
    * Example (Kubernetes pod internals):
        Pod namespace:
            eth0 (10.244.1.5/24) <--> Host namespace vethXYZ
        Host:
            vethXYZ (part of cni0 bridge)
            cni0 (10.244.1.1/24)
    * Communication flows through veth pair → bridge → host routes.

* **Brief Mode**
```bash
ip -br link
ip -br addr
ip -br route
```

```bash
========================= LINUX ip COMMAND — PRACTICAL GUIDE =========================
              VIEW • CONFIGURE • TROUBLESHOOT NETWORKING (MODERN WAY)
=====================================================================================

WHAT IS `ip` COMMAND?
* `ip` is the modern Linux networking command
* It REPLACES older tools like:
  - ifconfig
  - route
  - netstat
* It is faster, more powerful, and actively maintained
* Used heavily by DevOps, Cloud, Kubernetes, and Networking teams

-------------------------------------------------------------------------------------
VIEW IP ADDRESSES (VERY FIRST CHECK ON ANY MACHINE)
-------------------------------------------------------------------------------------

Command:
ip a

What happens internally:
* Lists all network interfaces
* Shows:
  - Interface name (eth0, ens33, lo)
  - IP addresses (IPv4 + IPv6)
  - Interface state (UP / DOWN)

Use case:
* Verify machine IP
* Check if interface is UP
* Debug “service not reachable” issues

-------------------------------------------------------------------------------------
ADD OR REMOVE IP ADDRESS (TEMPORARY)
-------------------------------------------------------------------------------------

Add IP:
ip addr add 192.168.1.100/24 dev eth0

Remove IP:
ip addr del 192.168.1.100/24 dev eth0

Behind the scenes:
* IP is added to kernel networking stack
* Change is TEMPORARY (lost after reboot)

Use cases:
* Testing applications on new IP
* Adding secondary IPs
* Debugging routing issues

-------------------------------------------------------------------------------------
ENABLE OR DISABLE NETWORK INTERFACE
-------------------------------------------------------------------------------------

Bring interface UP:
ip link set eth0 up

Bring interface DOWN:
ip link set eth0 down

What actually happens:
* Kernel enables/disables NIC
* Traffic immediately stops/starts

Use cases:
* Reset network issues
* Simulate network failure
* Troubleshoot connectivity problems

-------------------------------------------------------------------------------------
VIEW ROUTING TABLE (EXTREMELY IMPORTANT)
-------------------------------------------------------------------------------------

Command:
ip r

What it shows:
* Default gateway
* Network routes
* Which path traffic will take

Example output meaning:
default via 192.168.1.1 dev eth0
→ All unknown traffic goes via 192.168.1.1

-------------------------------------------------------------------------------------
ADD A ROUTE (ADVANCED / REAL-WORLD)
-------------------------------------------------------------------------------------

Command:
ip route add 10.0.0.0/24 via 192.168.1.1

Behind the scenes:
* Kernel routing table updated
* Traffic to 10.0.0.0/24 is forwarded via gateway

Use cases:
* Multi-network environments
* VPN routing
* Kubernetes / cloud networking

-------------------------------------------------------------------------------------
WHY `ip` COMMAND IS IMPORTANT
-------------------------------------------------------------------------------------

* Single tool for:
  - IP address management
  - Interface control
  - Routing
  - Network troubleshooting
* Faster than legacy tools
* Required skill for:
  - Linux Admin
  - DevOps Engineer
  - Cloud Engineer
  - Kubernetes Engineer

-------------------------------------------------------------------------------------
OLD COMMANDS vs ip (INTERVIEW FAVORITE)
-------------------------------------------------------------------------------------

ifconfig  → ip a
route     → ip r
netstat   → ss
arp       → ip neigh

-------------------------------------------------------------------------------------
KEY TAKEAWAYS
-------------------------------------------------------------------------------------

* Always use `ip` instead of deprecated commands
* First commands to run on any server:
  - ip a
  - ip r
* Mastering `ip` = strong networking fundamentals

-------------------------------------------------------------------------------------
ONE-LINE INTERVIEW ANSWER
-------------------------------------------------------------------------------------

"`ip` is the modern Linux networking command that replaces ifconfig, route, and netstat,
allowing full control of interfaces, IPs, and routing from a single tool."

```
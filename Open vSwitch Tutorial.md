# Open vSwitch Tutorial 

![OVS Internal]
from [architecture](http://habrahabr.ru/company/webzilla/blog/124310/)

![OVS Architecture]
![DB schema]

[OVS Internal]:http://habrastorage.org/getpro/habr/post_images/36e/0d4/a75/36e0d4a750bc21203d31d71df85f0891.jpg

[OVS Architecture]:http://note.io/1Fu7iRQ
[DB schema]:https://virtualandy.files.wordpress.com/2013/04/vswitch-schema.png

## Tutorial - Lab (using sdnhub vm, OVS 2.3.90)

### Create and Configure Bridge and Network

* Before adding bridge

```
ubuntu@sdnhubvm:~[20:45]$ ifconfig
eth0      Link encap:Ethernet  HWaddr 08:00:27:a8:3a:91  
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fea8:3a91/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:347 errors:0 dropped:0 overruns:0 frame:0
          TX packets:267 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:249619 (249.6 KB)  TX bytes:25645 (25.6 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```

Add a bridge `sudo ovs-vsctl add-br mybridge`, it has a default port, named as bridge name: mybridge.

```
ubuntu@sdnhubvm:~[20:46]$ sudo ovs-vsctl add-br mybridge
ubuntu@sdnhubvm:~[20:47]$ sudo ovs-vsctl show
873c293e-912d-4067-82ad-d1116d2ad39f
    Bridge mybridge
        Port mybridge
            Interface mybridge
                type: internal
    ovs_version: "2.3.90"
ubuntu@sdnhubvm:~[20:47]$ sudo ifconfig mybridge up
ubuntu@sdnhubvm:~[20:49]$ ifconfig
eth0      Link encap:Ethernet  HWaddr 08:00:27:a8:3a:91  
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fea8:3a91/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:347 errors:0 dropped:0 overruns:0 frame:0
          TX packets:267 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:249619 (249.6 KB)  TX bytes:25645 (25.6 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

mybridge  Link encap:Ethernet  HWaddr 12:4a:c5:3d:ed:46  
          inet6 addr: fe80::104a:c5ff:fe3d:ed46/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:648 (648.0 B)

ubuntu@sdnhubvm:~[20:49]$ 
```

This creates a bridge without connecting to outside yet.
![a bridge without port](http://note.io/1ChTB7y)

Add port (eth0) to the bridge,

```
ubuntu@sdnhubvm:~[20:49]$ sudo ovs-vsctl add-port mybridge eth0
ubuntu@sdnhubvm:~[21:47]$ sudo ovs-vsctl show
873c293e-912d-4067-82ad-d1116d2ad39f
    Bridge mybridge
        Port mybridge
            Interface mybridge
                type: internal
        Port "eth0"
            Interface "eth0"
    ovs_version: "2.3.90"
ubuntu@sdnhubvm:~[21:48]$ 
```
We cannot reach internet yet.

```
ubuntu@sdnhubvm:~[00:15]$ ping google.com
ping: unknown host google.com
ubuntu@sdnhubvm:~[00:16]$ ping 8.8.8.8 -c2
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
From 10.0.2.15 icmp_seq=1 Destination Host Unreachable
From 10.0.2.15 icmp_seq=2 Destination Host Unreachable

--- 8.8.8.8 ping statistics ---
2 packets transmitted, 0 received, +2 errors, 100% packet loss, time 999ms
pipe 2
ubuntu@sdnhubvm:~[00:16]$ 
```

Our current routing table

```
ubuntu@sdnhubvm:~[00:16]$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.0.2.2        0.0.0.0         UG    0      0        0 eth0
10.0.2.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
ubuntu@sdnhubvm:~[00:22]$ 
```

To fix this problem,
* remove ifconfig of eth0 `ifconfig eth0 0`
We show before and after below,

```
ubuntu@sdnhubvm:~[00:34]$ ifconfig   # <<<<before
eth0      Link encap:Ethernet  HWaddr 08:00:27:a8:3a:91  
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0  # <<<<remove this
          inet6 addr: fe80::a00:27ff:fea8:3a91/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:397 errors:0 dropped:0 overruns:0 frame:0
          TX packets:317 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:252619 (252.6 KB)  TX bytes:28665 (28.6 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:60 errors:0 dropped:0 overruns:0 frame:0
          TX packets:60 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:6006 (6.0 KB)  TX bytes:6006 (6.0 KB)

mybridge  Link encap:Ethernet  HWaddr 08:00:27:a8:3a:91  
          inet6 addr: fe80::104a:c5ff:fe3d:ed46/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:50 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:3000 (3.0 KB)  TX bytes:648 (648.0 B)

ubuntu@sdnhubvm:~[00:37]$ sudo ifconfig eth0 0
ubuntu@sdnhubvm:~[00:37]$ ifconfig   # after
eth0      Link encap:Ethernet  HWaddr 08:00:27:a8:3a:91  
          inet6 addr: fe80::a00:27ff:fea8:3a91/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:397 errors:0 dropped:0 overruns:0 frame:0
          TX packets:317 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:252619 (252.6 KB)  TX bytes:28665 (28.6 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:60 errors:0 dropped:0 overruns:0 frame:0
          TX packets:60 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:6006 (6.0 KB)  TX bytes:6006 (6.0 KB)

mybridge  Link encap:Ethernet  HWaddr 08:00:27:a8:3a:91  
          inet6 addr: fe80::104a:c5ff:fe3d:ed46/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:50 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:3000 (3.0 KB)  TX bytes:648 (648.0 B)

ubuntu@sdnhubvm:~[00:37]$ 
```

* make mybridge as dhcp-client and use it ipaddress as default gateway. `dhclient mybridge`

```
ubuntu@sdnhubvm:~[00:50]$ sudo dhclient mybridge
ubuntu@sdnhubvm:~[00:51]$ ifconfig
eth0      Link encap:Ethernet  HWaddr 08:00:27:a8:3a:91  
          inet6 addr: fe80::a00:27ff:fea8:3a91/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:399 errors:0 dropped:0 overruns:0 frame:0
          TX packets:319 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:253799 (253.7 KB)  TX bytes:29349 (29.3 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:60 errors:0 dropped:0 overruns:0 frame:0
          TX packets:60 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:6006 (6.0 KB)  TX bytes:6006 (6.0 KB)

mybridge  Link encap:Ethernet  HWaddr 08:00:27:a8:3a:91  
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0    <<<<added this
          inet6 addr: fe80::104a:c5ff:fe3d:ed46/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:52 errors:0 dropped:0 overruns:0 frame:0
          TX packets:10 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:4180 (4.1 KB)  TX bytes:1332 (1.3 KB)
```

Now, we can reach internet. 

```
ubuntu@sdnhubvm:~[01:05]$ ping google.com -c2
PING google.com (74.125.239.133) 56(84) bytes of data.
64 bytes from nuq05s02-in-f5.1e100.net (74.125.239.133): icmp_seq=1 ttl=63 time=46.9 ms
64 bytes from nuq05s02-in-f5.1e100.net (74.125.239.133): icmp_seq=2 ttl=63 time=29.0 ms

--- google.com ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 29.076/38.000/46.925/8.926 ms
ubuntu@sdnhubvm:~[01:06]$ 
```

We can check our configuration too. The default router is set to mybridge.

```
ubuntu@sdnhubvm:~[01:06]$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.0.2.2        0.0.0.0         UG    0      0        0 mybridge #<<
10.0.2.0        0.0.0.0         255.255.255.0   U     0      0        0 mybridge
```
Add two vports and turn them up.

```
ubuntu@sdnhubvm:~[01:12]$ sudo ip tuntap add mode tap vport1
ubuntu@sdnhubvm:~[01:23]$ sudo ip tuntap add mode tap vport2
ubuntu@sdnhubvm:~[01:23]$ sudo ifconfig vport1 up
ubuntu@sdnhubvm:~[01:24]$ sudo ifconfig vport2 up
ubuntu@sdnhubvm:~[01:25]$ ifconfig
eth0      Link encap:Ethernet  HWaddr 08:00:27:a8:3a:91  
          inet6 addr: fe80::a00:27ff:fea8:3a91/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:411 errors:0 dropped:0 overruns:0 frame:0
          TX packets:331 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:255312 (255.3 KB)  TX bytes:30407 (30.4 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:60 errors:0 dropped:0 overruns:0 frame:0
          TX packets:60 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:6006 (6.0 KB)  TX bytes:6006 (6.0 KB)

mybridge  Link encap:Ethernet  HWaddr 08:00:27:a8:3a:91  
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          inet6 addr: fe80::104a:c5ff:fe3d:ed46/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:64 errors:0 dropped:0 overruns:0 frame:0
          TX packets:22 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:5693 (5.6 KB)  TX bytes:2372 (2.3 KB)

vport1    Link encap:Ethernet  HWaddr ea:8a:d4:6b:bc:c7  
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:500 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

vport2    Link encap:Ethernet  HWaddr e6:f2:24:db:bb:1b  
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:500 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```

We can add these two ports to mybridge. `sudo ovs-vsctl add-port mybridge vport1 -- add-port mybridge vport2`
and `--` in ovs-vsctl is to allow multiple commands to follow.

```
ubuntu@sdnhubvm:~[01:25]$ sudo ovs-vsctl add-port mybridge vport1 -- add-port mybridge vport2
ubuntu@sdnhubvm:~[01:32]$ sudo ovs-vsctl show
873c293e-912d-4067-82ad-d1116d2ad39f
    Bridge mybridge
        Port mybridge
            Interface mybridge
                type: internal
        Port "eth0"
            Interface "eth0"
        Port "vport2"
            Interface "vport2"
        Port "vport1"
            Interface "vport1"
    ovs_version: "2.3.90"
ubuntu@sdnhubvm:~[01:33]$ 
```
![bridge ports](http://note.io/1GRNpWs)

Port can have multiple interfaces and can be used to create bond. We will connect them to 2 vms. 

**Like the first trial, I did not get this part to work**, it is possible I used wifi, not eth0. After I did more investigation, the bridge is up, but there is no ip address in my exercise. 
**Update** bridge need to be created in VirtualBox Manager and added to VM setting before launching VM. After VM is up, we need to do modify /etc/network/interface file by adding `auto eth1` and eth1 dhclient??.

I will use screenshot as reference.
![connect vm1 vm2](http://note.io/1HTXLCZ)

![bridge with vm1 vm2](http://note.io/1BGfbRi)

### Query Bridge 

#### Flows
To check what is in flow table. This is a default entry. 

```
ubuntu@sdnhubvm:~[01:33]$ sudo ovs-ofctl dump-flows mybridge
NXST_FLOW reply (xid=0x4):
 cookie=0x0, duration=26116.216s, table=0, n_packets=86, n_bytes=8065, idle_age=12335, priority=0 actions=NORMAL
ubuntu@sdnhubvm:~[09:19]$ 
```

#### Tables
To find out what in the database, `ovs-vsctl list table-X`, table-X <- [Bridge|Port|Interface]

```
ubuntu@sdnhubvm:~[09:19]$ sudo ovs-vsctl list Bridge
_uuid               : 3dc54a12-1921-46ed-adca-23695a217709
controller          : []
datapath_id         : "0000080027a83a91"
datapath_type       : ""
datapath_version    : "2.3.90"
external_ids        : {}
fail_mode           : []
flood_vlans         : []
flow_tables         : {}
ipfix               : []
mcast_snooping_enable: false
mirrors             : []
name                : mybridge
netflow             : []
other_config        : {}
ports               : [16125615-046f-4d8a-8cb4-62b880a44cba, 8ee35123-b457-4f6d-b82c-a3868c35f809, ac9a048c-a946-4b63-95a3-ca5e940ef500, e5ceb98e-d51e-4cab-972b-6b0a9c5ea5f9]
protocols           : []
rstp_enable         : false
rstp_status         : {}
sflow               : []
status              : {}
stp_enable          : false
ubuntu@sdnhubvm:~[09:29]$ 
```

About ports, `sudo ovs-vsctl list Port | more`

```
ubuntu@sdnhubvm:~[09:42]$ sudo ovs-vsctl list Port | more
_uuid               : ac9a048c-a946-4b63-95a3-ca5e940ef500
bond_active_slave   : []
bond_downdelay      : 0
bond_fake_iface     : false
bond_mode           : []
bond_updelay        : 0
external_ids        : {}
fake_bridge         : false
interfaces          : [746be08f-55fe-4f53-919c-a74693921602]
lacp                : []
mac                 : []
name                : "vport2"
other_config        : {}
qos                 : []
rstp_statistics     : {}
rstp_status         : {}
statistics          : {}
status              : {}
tag                 : []
trunks              : []
vlan_mode           : []

_uuid               : 16125615-046f-4d8a-8cb4-62b880a44cba
bond_active_slave   : []
...
```
About Interface, `sudo ovs-vsctl list Interface | more`

```
ubuntu@sdnhubvm:~[09:44]$ sudo ovs-vsctl list Interface | more
_uuid               : cd03fd78-97d5-48ac-8fae-88a0f2854aca
admin_state         : up
bfd                 : {}
bfd_status          : {}
cfm_fault           : []
cfm_fault_status    : []
cfm_flap_count      : []
cfm_health          : []
cfm_mpid            : []
cfm_remote_mpids    : []
cfm_remote_opstate  : []
duplex              : full
error               : []
external_ids        : {}
ifindex             : 2
ingress_policing_burst: 0
ingress_policing_rate: 0
lacp_current        : []
link_resets         : 22
link_speed          : 1000000000
link_state          : up
mac                 : []
mac_in_use          : "08:00:27:a8:3a:91"
mtu                 : 1500
name                : "eth0"
ofport              : 1
ofport_request      : []
options             : {}
other_config        : {}
statistics          : {collisions=0, rx_bytes=255312, rx_crc_err=0, rx_dropped=0, rx_errors=0, rx
_frame_err=0, rx_over_err=0, rx_packets=411, tx_bytes=30407, tx_dropped=0, tx_errors=0, tx_packet
s=331}
status              : {driver_name="e1000", driver_version="7.3.21-k8-NAPI", firmware_version=""}
--More--
```

## References
* [http://git.openvswitch.org/cgi-bin/gitweb.cgi?p=openvswitch;a=blob;f=PORTING](http://git.openvswitch.org/cgi-bin/gitweb.cgi?p=openvswitch;a=blob;f=PORTING)


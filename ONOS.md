# ONOS 

- [ONOS for Newcomers](https://wiki.onosproject.org/display/ONOS/ONOS+for+Newcomers)
- [ONOS Webinar](http://onosproject.org/webinars/)
- [ONOS Architecture Overview](https://www.youtube.com/watch?v=n1dvxrCZlgQ) and [Slide](https://docs.google.com/presentation/d/1pPOXPy4_KagPcrwgQOX332uZn7KXKWfMEe7vNfhFDqo/edit#slide=id.g40a2ba0c0_01)
- [ONOS Overview Demo](https://www.youtube.com/watch?v=3lya-MY1cZw)
- [ONOSProject YouTube Channel](https://www.youtube.com/channel/UCTQaOpqno48GTimdwyfytFw)
- [ONOS Docker](https://github.com/sdnhub/onos)

## Architecture
![ONOS Architecture](http://sdnhub.org/wp-content/uploads/2015/01/onos-architecture-1024x673.png)

ONOS is a controller, so its state and function may vary after some apps are installed or configuration changed.

## Preparation and Background
### Mininet
- [Download ONOS vm](https://wiki.onosproject.org/display/ONOS/Downloads) or mininet vm. User/Password for ONOS vm is tutorial1/tutorial1.
- [Mininet Walk-thru](http://mininet.org/walkthrough/)

#### Tutorial
* `sudo mn` starts a default network, 2 hosts (h1 and h2), 1 switch (s1) and 1 controller (c0)
![mininet default topology](http://note.io/1FAMp5d)

We can check the connectivity by `pingall` and ethernet pairs by `net`

```
mininet> pingall
*** Ping: testing ping reachability
h1 -> h2 
h2 -> h1 
*** Results: 0% dropped (2/2 received)
mininet> net
h1 h1-eth0:s1-eth1
h2 h2-eth0:s2-eth1
s1 lo:  s1-eth1:h1-eth0 s1-eth2:s2-eth2
s2 lo:  s2-eth1:h2-eth0 s2-eth2:s1-eth2
c0
```

We can get more details by `dump`

```
mininet> dump
<Host h1: h1-eth0:10.0.0.1 pid=609> 
<Host h2: h2-eth0:10.0.0.2 pid=615> 
<OVSSwitch s1: lo:127.0.0.1,s1-eth1:None,s1-eth2:None pid=622> 
<OVSSwitch s2: lo:127.0.0.1,s2-eth1:None,s2-eth2:None pid=625> 
<RemoteController c0: 127.0.0.1:6633 pid=602> 
```

Each host is one process. 
Start a xterm on h1 host `xterm h1`, then 
ping h2 from xterm, we have to use ipaddress of h2, `ping 10.0.0.2 -c2`

In xterm, we can do `tcpdump -n`
If we use mininet `h1 ping h2`, we can actually see the tcpdump message.

![tcpdump](http://note.io/1arMezV)

In mininet, we can check the performance,

```
mininet> iperf
*** Iperf: testing TCP bandwidth between h1 and h2
*** Results: ['19.6 Gbits/sec', '19.6 Gbits/sec']
mininet> 
```
Exit mn and clean,

```
mininet> exit
*** Stopping 1 controllers
c0 
*** Stopping 3 terms
*** Stopping 2 switches
s1 ..s2 ..
*** Stopping 3 links
*** Stopping 2 hosts
h1 h2 
*** Done
completed in 116582.924 seconds
ubuntu@sdnhubvm:~/onos[17:26] (master)$ sudo mn -c
*** Removing excess controllers/ofprotocols/ofdatapaths/pings/noxes
killall controller ofprotocol ofdatapath ping nox_core lt-nox_core ovs-openflowd ovs-controller udpbwtest mnexec ivs 2> /dev/null
killall -9 controller ofprotocol ofdatapath ping nox_core lt-nox_core ovs-openflowd ovs-controller udpbwtest mnexec ivs 2> /dev/null
pkill -9 -f "sudo mnexec"
*** Removing junk from /tmp
rm -f /tmp/vconn* /tmp/vlogs* /tmp/*.out /tmp/*.log
*** Removing old X11 tunnels
*** Removing excess kernel datapaths
ps ax | egrep -o 'dp[0-9]+' | sed 's/dp/nl:/'
***  Removing OVS datapathsovs-vsctl --timeout=1 list-br
ovs-vsctl --timeout=1 list-br
*** Removing all links of the pattern foo-ethX
ip link show | egrep -o '([-_.[:alnum:]]+-eth[[:digit:]]+)'
*** Killing stale mininet node processes
pkill -9 -f mininet:
*** Shutting down stale tunnels
pkill -9 -f Tunnel=Ethernet
pkill -9 -f .ssh/mn
rm -f ~/.ssh/mn/*
*** Cleanup complete.
ubuntu@sdnhubvm:~/onos[17:26] (master)$ 
```

Add more attributes to the link, it is still a default topology;

```
ubuntu@sdnhubvm:~/onos[17:26] (master)$ sudo mn --link tc,bw=10,delay=10ms
*** Creating network
*** Adding controller
*** Adding hosts:
h1 h2 
*** Adding switches:
s1 
*** Adding links:
(10.00Mbit 10ms delay) (10.00Mbit 10ms delay) (h1, s1) (10.00Mbit 10ms delay) (10.00Mbit 10ms delay) (h2, s1) 
*** Configuring hosts
h1 h2 
*** Starting controller
*** Starting 1 switches
s1 (10.00Mbit 10ms delay) (10.00Mbit 10ms delay) 
*** Starting CLI:
mininet> 
```
--topo=[tree|linear|single]

### Wireshark
#### Tutorial
- [The Ultimate Wireshark Tutorial](https://www.youtube.com/watch?v=Lu05owzpSb8)
- [Wireshark Walkthrough](http://mininet.org/walkthrough/#start-wireshark)

### tcpdump
#### Tutorial


### OpenFlow
#### Tutorial


## ONOS Tutorial
- Open two terminals; one for Mininet, one for ONOS.
- Mininet will create a sample network ![sample network](https://wiki.onosproject.org/download/attachments/1638475/Screen%20Shot%202014-12-02%20at%2015.01.50.png?version=1&modificationDate=1417561471713&api=v2)

```
*** Creating network
*** Adding controller
*** Adding hosts:
h11 h12 h13 h14 h15 h16 h21 h22 h23 h24 h25 h26 h31 h32 h33 h34 h35 h36 h41 h42 h43 h44 h45 h46 
*** Adding switches:
s1 s2 s11 s12 s13 s14 
*** Adding links:
(h11, s11) (h12, s11) (h13, s11) (h14, s11) (h15, s11) (h16, s11) (h21, s12) (h22, s12) (h23, s12) (h24, s12) (h25, s12) (h26, s12) (h31, s13) (h32, s13) (h33, s13) (h34, s13) (h35, s13) (h36, s13) (h41, s14) (h42, s14) (h43, s14) (h44, s14) (h45, s14) (h46, s14) (s1, s2) (s11, s1) (s11, s2) (s12, s1) (s12, s2) (s13, s1) (s13, s2) (s14, s1) (s14, s2) 
*** Configuring hosts
h11 h12 h13 h14 h15 h16 h21 h22 h23 h24 h25 h26 h31 h32 h33 h34 h35 h36 h41 h42 h43 h44 h45 h46 
*** Starting controller
c0 
*** Starting 6 switches
s1 s2 s11 s12 s13 s14 
*** Starting CLI:
```

Try `h11 ping -c3 h41` in Mininet, failed.

```
mininet> h11 ping -c3 h41
PING 10.0.0.19 (10.0.0.19) 56(84) bytes of data.
From 10.0.0.1 icmp_seq=1 Destination Host Unreachable
From 10.0.0.1 icmp_seq=2 Destination Host Unreachable
From 10.0.0.1 icmp_seq=3 Destination Host Unreachable

--- 10.0.0.19 ping statistics ---
3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 1999ms
pipe 3
mininet> 
```

In https://wiki.onosproject.org/display/ONOS/Basic+ONOS+Tutorial

```
onos> apps
id=1, name=org.onosproject.net.intent
onos> hosts
onos> intents
```
I understand, there is no intents listed, but *why there is no list of hosts?* Reset ONOS to start it over.

List applications;

```
onos> list
START LEVEL 100 , List Threshold: 50
 ID | State  | Lvl | Version      | Name                                  
--------------------------------------------------------------------------
 40 | Active |  80 | 2.6          | Commons Lang                          
 41 | Active |  80 | 3.3.2        | Apache Commons Lang                   
 42 | Active |  80 | 18.0.0       | Guava: Google Core Libraries for Java 
 43 | Active |  80 | 3.9.2.Final  | The Netty Project                     
 44 | Active |  80 | 4.0.23.Final | Netty/Common                          
 45 | Active |  80 | 4.0.23.Final | Netty/Buffer                          
 46 | Active |  80 | 4.0.23.Final | Netty/Transport                       
 47 | Active |  80 | 4.0.23.Final | Netty/Handler                         
 48 | Active |  80 | 4.0.23.Final | Netty/Codec                           
 49 | Active |  80 | 4.0.23.Final | Netty/Transport/Native/Epoll          
 50 | Active |  80 | 1.6.0        | Commons Pool                          
 51 | Active |  80 | 2.5          | Joda-Time                             
 52 | Active |  80 | 3.3.2        | hazelcast                             
 53 | Active |  80 | 3.1.0        | Metrics Core                          
 54 | Active |  80 | 3.1.0        | Jackson Integration for Metrics       
 55 | Active |  80 | 0.9.1        | minimal-json                          
 56 | Active |  80 | 3.0.0        | Kryo                                  
 57 | Active |  80 | 1.10.0       | ReflectASM                            
 58 | Active |  80 | 4.2          | ASM                                   
 59 | Active |  80 | 1.3.0        | MinLog                                
 60 | Active |  80 | 2.1.0        | Objenesis                             
 61 | Active |  80 | 1.0.0        | onlab-nio                             
 62 | Active |  80 | 2.4.2        | Jackson-core                          
 63 | Active |  80 | 2.4.2        | Jackson-annotations                   
 64 | Active |  80 | 2.4.2        | jackson-databind                      
 65 | Active |  80 | 1.9.13       | Jackson JSON processor                
 66 | Active |  80 | 1.9.13       | Data mapper for Jackson JSON processor
 67 | Active |  80 | 1.0.0        | onlab-thirdparty                      
 68 | Active |  80 | 1.0.6        | mapdb                                 
 69 | Active |  80 | 1.0.0        | onlab-misc                            
 70 | Active |  80 | 1.0.0        | onlab-osgi                            
 71 | Active |  80 | 1.0.0        | onlab-rest                            
 72 | Active |  80 | 1.0.0        | onos-api                              
106 | Active |  80 | 1.18.1       | jersey-core                           
107 | Active |  80 | 1.18.1       | jersey-server                         
108 | Active |  80 | 1.18.1       | jersey-servlet                        
109 | Active |  80 | 1.0.0        | onos-rest                             
115 | Active |  80 | 1.0.0        | onos-of-api                           
116 | Active |  80 | 1.0.0        | onos-of-drivers                       
117 | Active |  80 | 1.0.0        | onos-of-ctl                           
118 | Active |  80 | 1.0.0        | onos-lldp-provider                    
119 | Active |  80 | 1.0.0        | onos-host-provider                    
120 | Active |  80 | 1.0.0        | onos-of-provider-device               
121 | Active |  80 | 1.0.0        | onos-of-provider-packet               
122 | Active |  80 | 1.0.0        | onos-of-provider-flow                 
135 | Active |  80 | 1.0.0        | onos-cli                              
150 | Active |  80 | 1.0.0        | onos-core-net                         
151 | Active |  80 | 1.0.0        | onos-core-trivial                     
onos> 
```

There is no reactive forwarding application loaded. 
Load app `feature:install onos-app-fwd` in ONOS terminal; then try to ping again in Mininet teminal. It works now.

```
mininet> h11 ping -c3 h41
PING 10.0.0.19 (10.0.0.19) 56(84) bytes of data.
64 bytes from 10.0.0.19: icmp_seq=1 ttl=64 time=47.5 ms
64 bytes from 10.0.0.19: icmp_seq=2 ttl=64 time=2.15 ms
64 bytes from 10.0.0.19: icmp_seq=3 ttl=64 time=0.139 ms

--- 10.0.0.19 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2005ms
rtt min/avg/max/mdev = 0.139/16.628/47.590/21.908 ms
mininet> 
```

We can stop/start an app by `stop onos-app-fwd` or `start onos-app-fwd`.

### command CLI

#### devices command
Switches.

```
onos> devices
id=of:0000000000000001, available=true, role=MASTER, type=SWITCH, mfr=Nicira, Inc., hw=Open vSwitch, sw=2.1.3, serial=None, protocol=OF_10
id=of:0000000000000002, available=true, role=MASTER, type=SWITCH, mfr=Nicira, Inc., hw=Open vSwitch, sw=2.1.3, serial=None, protocol=OF_10
id=of:000000000000000b, available=true, role=MASTER, type=SWITCH, mfr=Nicira, Inc., hw=Open vSwitch, sw=2.1.3, serial=None, protocol=OF_10
id=of:000000000000000c, available=true, role=MASTER, type=SWITCH, mfr=Nicira, Inc., hw=Open vSwitch, sw=2.1.3, serial=None, protocol=OF_10
id=of:000000000000000d, available=true, role=MASTER, type=SWITCH, mfr=Nicira, Inc., hw=Open vSwitch, sw=2.1.3, serial=None, protocol=OF_10
id=of:000000000000000e, available=true, role=MASTER, type=SWITCH, mfr=Nicira, Inc., hw=Open vSwitch, sw=2.1.3, serial=None, protocol=OF_10
```

#### links command
connections; device/port pairs.

```
onos> links
src=of:000000000000000e/1, dst=of:0000000000000001/5, type=DIRECT, state=ACTIVE
src=of:000000000000000d/1, dst=of:0000000000000001/4, type=DIRECT, state=ACTIVE
src=of:000000000000000e/2, dst=of:0000000000000002/5, type=DIRECT, state=ACTIVE
src=of:000000000000000c/1, dst=of:0000000000000001/3, type=DIRECT, state=ACTIVE
src=of:000000000000000d/2, dst=of:0000000000000002/4, type=DIRECT, state=ACTIVE
src=of:000000000000000b/1, dst=of:0000000000000001/2, type=DIRECT, state=ACTIVE
src=of:000000000000000c/2, dst=of:0000000000000002/3, type=DIRECT, state=ACTIVE
src=of:000000000000000b/2, dst=of:0000000000000002/2, type=DIRECT, state=ACTIVE
src=of:0000000000000002/2, dst=of:000000000000000b/2, type=DIRECT, state=ACTIVE
src=of:0000000000000002/3, dst=of:000000000000000c/2, type=DIRECT, state=ACTIVE
src=of:0000000000000001/2, dst=of:000000000000000b/1, type=DIRECT, state=ACTIVE
src=of:0000000000000001/3, dst=of:000000000000000c/1, type=DIRECT, state=ACTIVE
src=of:0000000000000002/4, dst=of:000000000000000d/2, type=DIRECT, state=ACTIVE
src=of:0000000000000001/4, dst=of:000000000000000d/1, type=DIRECT, state=ACTIVE
src=of:0000000000000002/5, dst=of:000000000000000e/2, type=DIRECT, state=ACTIVE
src=of:0000000000000001/5, dst=of:000000000000000e/1, type=DIRECT, state=ACTIVE
src=of:0000000000000002/1, dst=of:0000000000000001/1, type=DIRECT, state=ACTIVE
src=of:0000000000000001/1, dst=of:0000000000000002/1, type=DIRECT, state=ACTIVE
onos> 
```

#### hosts command
 An endpoints;

```
onos> hosts
id=00:00:00:00:00:01/-1, mac=00:00:00:00:00:01, location=of:000000000000000b/3, vlan=-1, ip(s)=[10.0.0.1]
id=00:00:00:00:00:13/-1, mac=00:00:00:00:00:13, location=of:000000000000000e/3, vlan=-1, ip(s)=[10.0.0.19]
onos> 
```

#### flows command
A flow has different states [PENDING_ADD | ADDED | PENDING_REMOVE | REMOVED].

```
onos> flows
deviceId=of:0000000000000001, flowRuleCount=0
deviceId=of:0000000000000002, flowRuleCount=0
deviceId=of:000000000000000b, flowRuleCount=0
deviceId=of:000000000000000c, flowRuleCount=0
deviceId=of:000000000000000d, flowRuleCount=0
deviceId=of:000000000000000e, flowRuleCount=0
```

A more detailed information from ONOS doc:
appID,
selector: matching condition
treatment: action to perform

```
deviceId=of:0000000000000001, flowRuleCount=1
   id=30000b889cb32, state=ADDED, bytes=8722, packets=89, duration=89, priority=10, appId=org.onlab.onos.fwd
      selector=[ETH_TYPE{ethType=800}, ETH_SRC{mac=00:00:00:00:00:01}, ETH_DST{mac=00:00:00:00:00:13}, IN_PORT{port=2}]
      treatment=[OUTPUT{port=5}]
```

#### apps command
The applications currently run on the controller (in this case, ONOS).

```
onos> apps
id=1, name=org.onosproject.net.intent
id=2, name=org.onosproject.fwd
```

#### paths command
shortest path between 2 nodes, it supports completion with <TAB>

```
onos> paths of:0000000000000001 of:0000000000000002
of:0000000000000001/1-of:0000000000000002/1; cost=1.0
onos> 
```
It has the cost information about the path.

#### intents command

See more [intent framework information](https://wiki.onosproject.org/display/ONOS/The+Intent+Framework)

Intent can have following states:
[SUBMITTED | COMPILING | INSTALLING | INSTALLED | RECOMPILING | WITHDRAWING | WITHDRAWN | FAILED]

Since we have not install any intent yet, empty list.

```
onos> intents
onos> 
```

From ONOS doc;

```
onos> intents
id=0x0, state=INSTALLED, type=HostToHostIntent, appId=org.onlab.onos.gui
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
id=0x1, state=WITHDRAWN, type=HostToHostIntent, appId=org.onlab.onos.cli
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
```

### Intent Reactive Forwarding


```
onos> apps
id=1, name=org.onosproject.net.intent
id=2, name=org.onosproject.fwd
onos> intents
onos> hosts
id=00:00:00:00:00:01/-1, mac=00:00:00:00:00:01, location=of:000000000000000b/3, vlan=-1, ip(s)=[10.0.0.1]
id=00:00:00:00:00:13/-1, mac=00:00:00:00:00:13, location=of:000000000000000e/3, vlan=-1, ip(s)=[10.0.0.19]
onos> feature:uninstall onos-app-fwd
onos> apps
id=1, name=org.onosproject.net.intent
id=2, name=org.onosproject.fwd
```

Try to uninstall an app (<<<not app, a feature), it did not work (<<<app is still in the list). Maybe I need to stop it first.

```
onos> stop onos-app-fwd
No bundles specified.
onos> apps
id=1, name=org.onosproject.net.intent
id=2, name=org.onosproject.fwd
onos> 
```

*I don't why I cannot stop or remove it.*
**Got it, app != feature. Even through, we removed fwd feature, app onosproject.fwd will continue to exist. When I tried to uninstall the feature again, it shows it is gone already**

```
onos> apps
id=1, name=org.onosproject.net.intent
id=2, name=org.onosproject.fwd
onos> feature:uninstall onos-app-fwd
Error executing command: Feature named 'onos-app-fwd' is not installed
onos> 
```

When I tried to ping it again, it will not work anymore.

```
mininet> h11 ping h41 -c3
PING 10.0.0.19 (10.0.0.19) 56(84) bytes of data.

--- 10.0.0.19 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 2013ms
```

After we installed ifwd feature, it worked.

```
onos> intents
onos> feature:install onos-app-ifwd
```
We run 

```
mininet> h21 ping h31 -c3
PING 10.0.0.13 (10.0.0.13) 56(84) bytes of data.
64 bytes from 10.0.0.13: icmp_seq=1 ttl=64 time=12.4 ms
64 bytes from 10.0.0.13: icmp_seq=2 ttl=64 time=1.84 ms
64 bytes from 10.0.0.13: icmp_seq=3 ttl=64 time=0.132 ms

--- 10.0.0.13 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2004ms
rtt min/avg/max/mdev = 0.132/4.802/12.435/5.442 ms
```

This installed intents between h21 and h31.

```
onos> intents
id=0x0, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
id=0x1, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
id=0x2, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
onos> 
```
We can get more details by `intents -i`

```
onos> intents -i
id=0x0, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
    installable=[PathIntent{id=0x3, appId=DefaultApplicationId{id=3, name=org.onosproject.ifwd}, selector=DefaultTrafficSelector{criteria=[ETH_DST{mac=00:00:00:00:00:07}, ETH_SRC{mac=00:00:00:00:00:0D}]}, treatment=DefaultTrafficTreatment{instructions=[]}, constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}], path=DefaultPath{src=ConnectPoint{elementId=00:00:00:00:00:0D/-1, portNumber=0}, dst=ConnectPoint{elementId=00:00:00:00:00:07/-1, portNumber=0}, type=INDIRECT, state=ACTIVE, durable=false}}, PathIntent{id=0x4, appId=DefaultApplicationId{id=3, name=org.onosproject.ifwd}, selector=DefaultTrafficSelector{criteria=[ETH_DST{mac=00:00:00:00:00:0D}, ETH_SRC{mac=00:00:00:00:00:07}]}, treatment=DefaultTrafficTreatment{instructions=[]}, constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}], path=DefaultPath{src=ConnectPoint{elementId=00:00:00:00:00:07/-1, portNumber=0}, dst=ConnectPoint{elementId=00:00:00:00:00:0D/-1, portNumber=0}, type=INDIRECT, state=ACTIVE, durable=false}}]
id=0x1, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
    installable=[PathIntent{id=0x5, appId=DefaultApplicationId{id=3, name=org.onosproject.ifwd}, selector=DefaultTrafficSelector{criteria=[ETH_DST{mac=00:00:00:00:00:0D}, ETH_SRC{mac=00:00:00:00:00:07}]}, treatment=DefaultTrafficTreatment{instructions=[]}, constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}], path=DefaultPath{src=ConnectPoint{elementId=00:00:00:00:00:07/-1, portNumber=0}, dst=ConnectPoint{elementId=00:00:00:00:00:0D/-1, portNumber=0}, type=INDIRECT, state=ACTIVE, durable=false}}, PathIntent{id=0x6, appId=DefaultApplicationId{id=3, name=org.onosproject.ifwd}, selector=DefaultTrafficSelector{criteria=[ETH_DST{mac=00:00:00:00:00:07}, ETH_SRC{mac=00:00:00:00:00:0D}]}, treatment=DefaultTrafficTreatment{instructions=[]}, constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}], path=DefaultPath{src=ConnectPoint{elementId=00:00:00:00:00:0D/-1, portNumber=0}, dst=ConnectPoint{elementId=00:00:00:00:00:07/-1, portNumber=0}, type=INDIRECT, state=ACTIVE, durable=false}}]
id=0x2, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
    installable=[PathIntent{id=0x7, appId=DefaultApplicationId{id=3, name=org.onosproject.ifwd}, selector=DefaultTrafficSelector{criteria=[ETH_DST{mac=00:00:00:00:00:07}, ETH_SRC{mac=00:00:00:00:00:0D}]}, treatment=DefaultTrafficTreatment{instructions=[]}, constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}], path=DefaultPath{src=ConnectPoint{elementId=00:00:00:00:00:0D/-1, portNumber=0}, dst=ConnectPoint{elementId=00:00:00:00:00:07/-1, portNumber=0}, type=INDIRECT, state=ACTIVE, durable=false}}, PathIntent{id=0x8, appId=DefaultApplicationId{id=3, name=org.onosproject.ifwd}, selector=DefaultTrafficSelector{criteria=[ETH_DST{mac=00:00:00:00:00:0D}, ETH_SRC{mac=00:00:00:00:00:07}]}, treatment=DefaultTrafficTreatment{instructions=[]}, constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}], path=DefaultPath{src=ConnectPoint{elementId=00:00:00:00:00:07/-1, portNumber=0}, dst=ConnectPoint{elementId=00:00:00:00:00:0D/-1, portNumber=0}, type=INDIRECT, state=ACTIVE, durable=false}}]
onos> 
```

The intent is a host to host intent which details the path along which the flows have been installed. We can remove an intent

```
onos> intents
id=0x0, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
id=0x1, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
id=0x2, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
onos> remove-intent 0x
0x0   0x1   0x2   
onos> remove-intent 0x2
onos> intents
id=0x0, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
id=0x1, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
```

#### state your intentions

Intents track the state of the network and reconfigure themselves in order to satisfy your intention. I think the current coverage of the intent is limited to connection only. 

```
onos> apps
id=1, name=org.onosproject.net.intent
id=2, name=org.onosproject.fwd
id=3, name=org.onosproject.ifwd
onos> hosts
onos> hosts
id=00:00:00:00:00:01/-1, mac=00:00:00:00:00:01, location=of:000000000000000b/3, vlan=-1, ip(s)=[10.0.0.1]
id=00:00:00:00:00:07/-1, mac=00:00:00:00:00:07, location=of:000000000000000c/3, vlan=-1, ip(s)=[10.0.0.7]
id=00:00:00:00:00:0D/-1, mac=00:00:00:00:00:0D, location=of:000000000000000d/3, vlan=-1, ip(s)=[10.0.0.13]
id=00:00:00:00:00:13/-1, mac=00:00:00:00:00:13, location=of:000000000000000e/3, vlan=-1, ip(s)=[10.0.0.19]
onos> 
```
Do a `flows` to list exist flows before `add-host-intent`, 
Use <TAB> for auto-completion,

```
onos> add-host-intent 00:00:00:00:00:01/-1 00:00:00:00:00:
00:00:00:00:00:01/-1   00:00:00:00:00:07/-1   00:00:00:00:00:0D/-1   
00:00:00:00:00:13/-1   
onos> add-host-intent 00:00:00:00:00:01/-1 00:00:00:00:00:13/-1 
onos> 
```
This command will provision a path between h11 [10.0.0.1] and h41 [10.0.0.19]; we got IPAddress from `hosts` command. 

```
onos> intents
id=0x0, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
id=0x1, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.ifwd
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
id=0x9, state=INSTALLED, type=HostToHostIntent, appId=org.onosproject.cli
    constraints=[LinkTypeConstraint{inclusive=false, types=[OPTICAL]}]
onos> 
```
The list intent (id=0x9) is the one we just added, and some additional flows are added.

```
onos> flows
deviceId=of:0000000000000001, flowRuleCount=4
   id=10000dc53ac3a, state=ADDED, bytes=0, packets=0, duration=1287, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=2}, ETH_DST{mac=00:00:00:00:00:13}, ETH_SRC{mac=00:00:00:00:00:01}]
      treatment=[OUTPUT{port=5}]
   id=10000dc53ac58, state=ADDED, bytes=238, packets=3, duration=16240, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=3}, ETH_DST{mac=00:00:00:00:00:0D}, ETH_SRC{mac=00:00:00:00:00:07}]
      treatment=[OUTPUT{port=4}]
   id=10000dc53ac76, state=ADDED, bytes=238, packets=3, duration=16240, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=4}, ETH_DST{mac=00:00:00:00:00:07}, ETH_SRC{mac=00:00:00:00:00:0D}]
      treatment=[OUTPUT{port=3}]
   id=10000dc53ac94, state=ADDED, bytes=0, packets=0, duration=1287, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=5}, ETH_DST{mac=00:00:00:00:00:01}, ETH_SRC{mac=00:00:00:00:00:13}]
      treatment=[OUTPUT{port=2}]
deviceId=of:0000000000000002, flowRuleCount=0
deviceId=of:000000000000000b, flowRuleCount=2
   id=10000dc54640a, state=ADDED, bytes=0, packets=0, duration=1287, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=1}, ETH_DST{mac=00:00:00:00:00:01}, ETH_SRC{mac=00:00:00:00:00:13}]
      treatment=[OUTPUT{port=3}]
   id=10000dc546446, state=ADDED, bytes=0, packets=0, duration=1287, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=3}, ETH_DST{mac=00:00:00:00:00:13}, ETH_SRC{mac=00:00:00:00:00:01}]
      treatment=[OUTPUT{port=1}]
deviceId=of:000000000000000c, flowRuleCount=3
   id=10000dc5467cb, state=ADDED, bytes=238, packets=3, duration=16240, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=1}, ETH_DST{mac=00:00:00:00:00:07}, ETH_SRC{mac=00:00:00:00:00:0D}]
      treatment=[OUTPUT{port=3}]
   id=10000dc546807, state=ADDED, bytes=0, packets=0, duration=8926, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=3}, ETH_DST{mac=00:00:00:00:00:0D}, ETH_SRC{mac=00:00:00:00:00:07}]
      treatment=[OUTPUT{port=1}]
   id=10000dc546808, state=PENDING_REMOVE, bytes=0, packets=0, duration=0, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=3}, ETH_DST{mac=00:00:00:00:00:0D}, ETH_SRC{mac=00:00:00:00:00:07}]
      treatment=[OUTPUT{port=2}]
deviceId=of:000000000000000d, flowRuleCount=3
   id=10000dc546b8c, state=ADDED, bytes=238, packets=3, duration=16240, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=1}, ETH_DST{mac=00:00:00:00:00:0D}, ETH_SRC{mac=00:00:00:00:00:07}]
      treatment=[OUTPUT{port=3}]
   id=10000dc546bc8, state=ADDED, bytes=0, packets=0, duration=8926, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=3}, ETH_DST{mac=00:00:00:00:00:07}, ETH_SRC{mac=00:00:00:00:00:0D}]
      treatment=[OUTPUT{port=1}]
   id=10000dc546bc9, state=PENDING_REMOVE, bytes=0, packets=0, duration=0, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=3}, ETH_DST{mac=00:00:00:00:00:07}, ETH_SRC{mac=00:00:00:00:00:0D}]
      treatment=[OUTPUT{port=2}]
deviceId=of:000000000000000e, flowRuleCount=2
   id=10000dc546f4d, state=ADDED, bytes=0, packets=0, duration=1287, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=1}, ETH_DST{mac=00:00:00:00:00:13}, ETH_SRC{mac=00:00:00:00:00:01}]
      treatment=[OUTPUT{port=3}]
   id=10000dc546f89, state=ADDED, bytes=0, packets=0, duration=1287, priority=123, appId=org.onosproject.net.intent
      selector=[IN_PORT{port=3}, ETH_DST{mac=00:00:00:00:00:01}, ETH_SRC{mac=00:00:00:00:00:13}]
      treatment=[OUTPUT{port=1}]
onos> 
```

devices deviceId=of:0000000000000001, deviceId=of:000000000000000e, and deviceId=of:000000000000000b have new flows.


## ONOS Graphical User Interface

```
onos> feature:uninstall onos-app-ifwd
onos> feature:install onos-app-fwd
onos> feature:install onos-gui
```

In browser `http://localhost:8181/onos/ui/index.html#topo`

![ONOS gui](http://note.io/1Bl3bFZ)

### GUI Features

#### cheatsheet
Hit browser area with "/" or "\" to toggle 
![ONOS gui cheatsheet](http://note.io/1GlxFYl)

#### host icon
Hit browser area with "h" to toggle show/hide host icons, and click host/switch icon to show 
![details of node](http://note.io/1GlBMU5).

#### intents

- Click one host and shift-click the second host, then click "Create host to host flow" which will create the intent. 
- hit v key to show intent flow.
- We can also type `intents` in terminal to get a list of intents.
![Create intents with gui](http://note.io/1wV7uYQ)




























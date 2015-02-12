# ONS Tutorial - SDN Essential
tutorial-day1

## Introduction
- traditional: distributed logic, all-in-one (app, os, )
- new approach: separate data (may be 1 to n) and control (1 to m), centralized control
- logic/control will be outside of switch => NOS + Apps
- switch still needs OS for forwarding, but lighter weight 

**Trend**
we can learn from computer industry;

- computer industry -> virtualization layer
- network industry -> virtualization/slicing 

We have Data Plane Abstraction, i.e. OSI layer - separation of concern. But not in control plane.

Open Shortest Path First (OSPF) is a routing protocol for Internet Protocol (IP) networks. It uses a link state routing algorithm and falls into the group of interior routing protocols, operating within a single autonomous system (AS).

### Where is Control Plane Abstraction
We need Topology and Routing abstrction. Control protocol is based on different header info.

![Contro Protocol]

[Contro Protocol]:http://note.io/1CYPMp5

#### Flow Abstraction
old method: special protocol -> match-action table
Definition of flow changes, classification

![flow abstraction]

Open flow uses a pattern

![openflow pattern]

which can be improved with rule engine.

configuration is more static; control and forwarding is run-time
configuration is parameter for instantiation

[flow abstraction]:http://note.io/1zZM76B
[openflow pattern]:http://note.io/1zZOHtt

#### State Distribution Abstraction
The apps about global abstraction only have to deal the global graph view

![state abstraction], treat flow as different table for different type of switch, and treat/map state to graph 

[state abstraction]:http://note.io/1zZQE9c

### Protocol

**think different**
Protocol -> think -> Program
Hardware -> think -> Software
Standard -> think -> Evolution
Close -> think -> Open

Currently, there is no control layer in DC. Content network is different from inter-DC network. Using overlay to migrate to new technology, easier and cheaper.

### OpenFlow

![Interfaces are the realization of abstraction]

Depend on the item to match, device looks like certain type
Reactive pattern requires reaching control for flow table.

Usually Proactive + Reactive packet processing

[Interfaces are the realization of abstraction]:http://note.io/1zZSxme

## SDN Switches
Initial approach, version 1.0:
- Default off network 
- Centralized policy
- Dumb switch

Open flow defines 3 things
- state: match
- behavior: action
- interface: controller <-> switch

![open flow]

[open flow]:http://note.io/1zZUmj4

#### Issue 1
table is too small

#### Issue 2
single table, which requires all combination.
need relational db type

#### Issue 3
limited match options

#### Issue 4
limited forwarding options

### New Release
![version support different functions]

[version support different functions]:http://note.io/1zZV6EV

Should basic on version 1.3+

### Logic Pipeline
OF describes logic pipeline
Untype table, vendor implement what they want

Chain tables together

![multiple tables]

[multiple tables]:http://note.io/1zZVFP2

### Group
simplified the logic for broadcast, redirect due to failure, 

### Performance
We are talking about control performance not data forwarding rate (equipment dependent). Performance depends primarily on 3 factors: 

- usage, 
- domain, and (how many nodes)
- switch architecture

KPI
- Flow Setup Delay (whether we need to contact controller or not)
- Flow Setup Rate (speed for interface between controller and switch, cpu)- Control Channel Bandwidth ()
Software switch is faster than HW switch.
### Decision factors
#### understand type of switchs
- what is used for
- mode of operation
- switch type

#### recommendations
- assume switch is bottleneck
- use virtual switch whenever is possible
- each switch has its own performance

###  Software Switches
packet actually forwarded 
- OVS has long-term support for OF 1.0 and 1.3
- component (there is difference user space or kernal)
	- database: can be used for config
	- forwarding engine
	
1. Use 	DPDK lib for Intel chip
2. another way is to use network interface, NPU-Network Process Unit

**Don't use hybrid switch**

Use [whitebox] from ODM vendors (Quanta, Accton, Celestica, Delta, Dell)
visit OpenCompute.org to know more about whitebox
Cumulux has figure about cost saving on their blog.
![whitebox]

[whitebox]:http://note.io/1zZWibe

## Controller 
People use the term controller <=> Network OS, inter-changable.
ONOS is one of them, ODL is another. 

SDN controllers evolution to multi-master (cluster) fan out.
Controller plane is better done in software, data plane is maybe.

early stage: Single instance

### Basic functions

- default path compute, 
- topology, build graph and state
- calculate reachability, location
- discovery - to create initial topology

- communication with hardware via southbound API (openflow)
- run apps, and communication with apps via northbound

HA
- one switch can have different master from others
- Zookeeper uses (? protocol)

### Other Consideration of SDN Controller
#### Visibility & Configuration

- CLI
- GUI
- Orchestration, OpenStack can serve the purpose

#### Troubleshooting & Upgrade
- we should have a better or new way to find the problem and fix it
- should be able to do the simulation or even emulate the systems, try the strategy
- tools 
	- HSA (Header Space Analysis), ATPG, NetSight, NetPlumber, AntEater, Veriflow
	- necessary to pull out the state in run-time
	- we need predictive replacement
	
Service has 99.999 level but HW is only 99 level. Service can move around. 
Analytics can be insider or outside of controller, but we need run-time feedback loop.
	 
#### Northbound API 
- within the virtual network will only has one writer

### Summary
NetOS functions

![NetOS functions]

[NetOS functions]:http://note.io/1Dl4g0W

*SDN gives operators choices*

There is big discussion about scale, which is dependent on the state sharing. We should keep config sync. The decision in one instance should not dependent on other instance. 

![Single Instance and Multiple Instance] Controllers, this may not be the best way. reference only.

[Single Instance and Multiple Instance]:http://note.io/1CiMWIB

## SDN in Action

Tridon needs to support MPLS, otherwise it will not work.
Source packet routing

P-router core uses label, 
PE-edge uses IP

Use mininet to emulate topology
sh links
sh routers
sh sw xxx table ip
sh sw xxx group
sh sw xxx group mpls
sh switch 0
sh router xxx port

config 
sh policy
sh sw xxx table acl

## Application
### Production Use
#### Multi-Tenant Cloud DataCenter
- connectivity
- tenant isolation

Problem
- Traditional uses VLan.
- Hard to config and manage

##### Network Virtualization 
	= Isolation + Programmability
Address Space Isolation
Performance Isolation
Connectivity Isolation

![DC virtualization]

[DC virtualization]:http://note.io/1CiOwdA

##### Programmable Connectivity/Services

where is it deployed?
Nicira (vmware)
Contrail,Nuage, 

#### WAN Network
old way-only has local view

Software Defined WAN TE, Google's approach.

![Google approach]

[Google approach]:http://note.io/1CiQwm2

#### Traffic Monitoring

### Other Use
- IP network over Transport network
- LTE & IP RAN
- Router Replacement, Pica8, IPTV router multi-cast, 
- Security, from HP, intercept DNS request, SDN uses dynamic
- Fabrics for Clouds, Big-Data and NFVI

## Thinking Different
- new choice, choose carefully
- automation (orchestration) != programmability (change behavior)
- L2 and L3 are still the same for underlay, we add some overlay to change networks.
- Benefit review (separate of data and control, simplicity, programmability, low capex, low opex)





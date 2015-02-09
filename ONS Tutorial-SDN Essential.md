# ONS Tutorial - SDN101
## SDN Essential
by Saurav Das

- traditional: distributed, all-in-one
- new: separate data (1 to n) and control (1 to m)
- logic/control will be outside of switch => NOS + Apps
- switch still needs OS, but lighter weight

Slide - Trend
computer industry -> virtualization layer
network industry -> virtualization/slicing 

Data Plane Abstraction
OSI layer - separation of concern

### Where is Control Plane Abstraction
Topology
Routing
![control plane abstraction]



[control plane abstraction]:https://www.evernote.com/shard/s302/sh/2cd7ded8-dd80-409a-8ab2-ff9b90abedd6/3b9e70100beeecd0c0b0e3e008439049



#### Flow Abstraction
special protocol -> match-action table


Definition of flow changes, classification

[flow abstraction]:https://www.evernote.com/shard/s302/sh/fcfd63eb-6b5f-44b8-b19e-e6cee68710db/e0a129ef90a7c9e74d60b1c6817c4f3f

configuration is more static, control and forwarding is run-time
configuration is parameter for instantiation

#### State Distribution Abstraction
The apps about global abstraction only have to deal the global graph view

![state abstraction], treat flow as different table for different type of switch, and treat/map state to graph 

[state abstraction]:https://www.evernote.com/shard/s302/sh/1aaea5ae-6571-486f-8b8a-8c4c4070bf3c/83e7a0a3088c34ac93e973127399d703

### Protocol
think protocol as program
Protocol -> think -> Program
Hardware -> think -> Software
Standard -> think -> Evolution
Close -> think -> Open


Currently, there is no control layer in DC. Content network is different from inter-DC network. Using overlay to migrate to new technology, easier and cheaper.

## OpenFlow

![Interfaces are the realizatio of abstraction]

Depend on the item to match, device looks like certain type
Reactive pattern requires reaching control for flow table.

Usually Proactive + Reactive packet processing

[Interfaces are the realizatio of abstraction]:https://www.evernote.com/shard/s302/sh/f3b33bad-bdda-4beb-b27b-14ec5632fc0a/329b83d45f2a99d99fdad8e1a631a8ec

## SDN Switches
initially:
Default off network 
Centralized policy
Dumb switch

Open flow defines 3 things
- state: match
- behavior: action
- interface: controller <-> switch

#### Issue 1
table is too small

#### Issue 2
single table, which requires all combination.
need relational db type

#### Issue 3
limited match options

#### Issue 4
limited forwarding options

[version support different functions]:https://www.evernote.com/shard/s302/sh/50eca703-0004-42da-841f-e12207d48dc4/21cead53edc20f07a3f833687d81df45

Should basic on version 1.3+

### Logic Pipeline
OF describes logic pipeline
Untype table, vendor implement what they want

Chain tables together

![multiple tables]

[multiple tables]:https://www.evernote.com/shard/s302/sh/824a09c2-adeb-4938-ab00-8db664807666/cd9336a282f62786292fe747d844dd4c

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

Use whitebox from ODM vendors (Quanta, Accton, Celestica, Delta, Dell)
visit OpenCompute.org to know more about whitebox
Cumulux has figure about cost saving on their blog.

## Controller 
controller <=> Network OS
ONOS is one of them.

SDN controllers evolution to multi-master (cluster) fan out.
Controller plane is better done in software, data plane is maybe.

### Basic functions
- default path compute
- reachability
- topology
- discovery

HA
- one switch can different master from others
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

[NetOS functions]:https://www.evernote.com/shard/s302/sh/2f1aa75d-be6e-42b7-b35b-7c2b46889352/226004e31861021799cd44959abbd0d4

*SDN gives operators choices*

There is big discussion about scale, which is dependent on the state sharing. We should keep config sync. The decision in one instance should not dependent on other instance. 


![Single Instance] vs 
![Multiple Instance] Controllers

[Single Instance]:https://www.evernote.com/shard/s302/sh/bcbe9895-bfda-49f4-bb9c-3d3fe4da7bf3/db63a66e5d84f1f3c756244a3ed14108

[Multiple Instance]:https://www.evernote.com/shard/s302/sh/5835c30a-8441-4916-9572-3f0e2c9598e3/7352f1b72215eec5954e694bf40cdb4f



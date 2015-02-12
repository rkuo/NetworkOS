# SDN Use Cases and Deployment
Tutorial-day2 

## Introduction

- Data plane abstraction -> match-action tables
- Control plane abstraction -> global network view

## Benefit
- Simple Control with Greater Flexibility
- Programmability: Speed of Innovation, Ease of Service Insertion & Time to Market
- Lower Total Cost of Ownership

## Product Changes
- from vertical integration
- give different part of components for free and change other part of service

## Use cases
3 types for now: Datacenter(web scale datacenter), Enterprise and Telecom Carrier

## Switch
- is generic forwarding device/element

- Switch types, features, performance and evolution
- There are different ways split at different places:
- treat each app just a special feature, the flexibility of OF creates the challenge of southbound 
- We can have different mix of components which creates different market/product segments. 

Software, configuration and operator prune for mistakes, which drive down the availability. We should focus on service availability, instead of HW. 

## ONF 1.3 
- supports multiple tables
- table chaining uses generic table approach and support difference table types.
- Flexible forwarding can be achieved by
	- using ASIC, Barefoot, Xpliant, Centex
	- using FPGA, Corsa, slower than ACIS
	- using NPU
- Fix table vendor offers
	- TTPL, OF-DPA abstraction, OpenFlow agent translate to OF-DPA like from Broadcomm
	
## SDN in Datacenter
- network virtualization
- scaling out

SDN offers choice, which gives us more flexible network architecture.

- Traditional is more N-S traffic. Standard ToR-Aggregate-Core
- But now, a single request may requires the communicate between racks in the same data center. bandwidth drops too.
- Multiple VM mobility is issue too, configuration, multiple tenant-isolation, vlan-port, 

=> 100k vm, many machines

-> use case: Network Virtualization
-> use case: cost effective scale out

Virtualization:
- isolation + programmability
isolation (connectivity, address space, performance)
programmability (programmable connectivity, performance guarantees)

replace vSwith with OVS
different tables for different tenants
based on port+VN -> action (VN specific lookup), we can add policy to it too.

use different ways to implement API, then call different controller
OVS translation physical IP to virtual L3 fabric
each server has one vSwitch 
OpenFlow controls OVS (OVSdb-create ports)
![Openstack Interface with SDN]

[Openstack Interface with SDN]: http://note.io/1Fzpnw6

### Scaling Out
- Fat tree (leaf-spin), connect to many servers, same type pizza box, pica8, big switch, cumulus, etc. a lot of wiring. 
- treat each box individually. use SDN to do fabric. 
- Fat Tree != Single Switch, creates problem 

run time traffic engineer, use different route
elephant flow(big flow and long)

## SDN in Enterprise

- NPB (Network Pack Broker), possible put some tools in production switch
- trouble shooting can be done with analytics.


## SDN in WAM
### why
- we manage it per box level, no economy of scale, 

### traffic engineering
The goal of traffic engineering is “addressing traffic policy and performance requirements while uLlizing network economically and reliably”Path selection and creation algorithm -> sub-graph <- try neo4j
Google- user facing
- inside datacenter

B4-optimize site traffic
+ application to decide the priority

switch -> router -> site

- gradually deploying SDN
- hierachical management
- leverage control at edge

Small network
- eNode-b, apply radio resource management
- manage discovery and change in home access network

consider pack is logic 
wave length, optical/circuit optimization

## SDN and NFV

GPON, DSLAM 
problems-
proliferation of proprietary hardware

other than switch in Data plane, we have many different functions need to perform. We can use a generic server and process data in VM.

Challenges
- performannce, some can be easily move to cloud
- sometimes, data has to go in and out several times
- who controls and config network function VMs
- elasticity

SDN is key enabler to achieve NFV vision.
Flow is service, each segment is part of chain.

Check the site OPNFV 
- each VNF has its own EMS, 
- use OpenStack create VM on overlay
- 

## Vendors
1. pure-HP
2. orchestration/automation/gluework-across elements from different vendors, Overture, Tail-f, use plugin to OpenStack to implement NFV
3 traditional Networking + SDN-*programmable table*, Cisco,onePK api, PCE protocol to get the global view, ODL, I2RS see information model, hybrid,
4. Overlay Networking for Net Virtualization, more complicate, Nicira NVP, NSX Overlay, Juniper Contrail, uses different protocol, has its own Neutron plugin, Alcatel-Lucent work Open vSwitch. BigSwitch uses P+V (physical+virtual)
5. Cumulus uses standard linux and shell script, so you can use Chef/Puppet, does not do OpenFlow, Big Switch does not support traditional switch.  
6. Decupled Traditional Networking + Global View
7. Open Source Networking, hard to review, only provide part of solution   

## Open Source
### Controller
- OpenDL solves today's problem
- ONOS tries to solve tomorrow's problems
focus on community

### Switch
OVS

### Emulator and Test
mininet-use openvswitch, so it sends packet
OFTest


### Migration
- Google migrates in place fool other sites, then add new, 128x10G
- Single Port in Datacenter to talk to another port in another DC
- use EGDP to small SDN based AS
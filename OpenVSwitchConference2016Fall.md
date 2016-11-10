This is very productive conference. This email is organized as follows:
- short answer to your questions
- summary
- Opinion
- random meeting notes link:???

### Items mentioned in your email:
* Who is actively participating
	Intel, vmWare, Plumgrid, Oracle (public cloud), Netronome, Cisco, IBM, Stanford and other Universities,... 
* Plans around performance optimization
	The performance discussion is mainly around software library and frameworks itself (see summary).
* Any work being done by Intel around OVS.. Specifically around DPDK
	some work about easy of use (see summary below)
* Any work being done by Plumgrid/IOVISOR/Redhat around XDP enabling OVS
	PlumGrid and RedHat open source project, IOVisor, to improve IO performance; currently is focus on Datapath. XDP (eXpress Data Path) is a framework developed under IOVisor project. 
* Any discussion of alternative protocols/interfaces from OpenFlow..  Like P4
	P4 is a compute programming language, like c, python, but is designed for network, which already has been used by many universities and a few network processor/board mfg to test/improve their new protocol. Some PoC project enhance OpenFlow (a specification) header with P4 to achieve "flow awareness". 

### Summary 
* XDP provides a different approach for datapath; which possible to simplify the datapath programming.
* P4 chip is developing now.
* Developers are working on move some load hardware to have better performance improvement. This is very properitory for now.

#### DPDK ???
Performance:
* Fast packet I/O
	* import
	* Orthogonal to switch architecture
	* not comparable to complete software switch 
* Low overhead per-packet
	* a series function calls
	* OvS has parser at beginning 
* Low processing cost per-packet
	* a stage is only a function
	* to anything or nothing
	* OvS stage has expensive classifier per stage
* Library improvement

Usability
* make package ease to install, config and deploy
* performance vs page size are workload specific
* Manual pinning of rx queuse
* Arbitrary port names and auto detect DPDK library
* More document for installation
* Packet Tracing use pDump and ovs-tcpdump
* start/stop OvS independently

#### P4 
*  Usage: Most of use is for prototyping now; we maybe still use C for production; this may change soon.
*  It simplifies the modeling building. PISCES translates P4 model to OvS model for production with <2% overhead.

#### eBPF (extended Berkerley Packet Filter)
It is the basic block for XDP, which allow VNF to be implemented in module and run in kernal.  

### Opinions
- OvS is stable and will continue to improve and serve as a functional block for other network technology.
- XDP leverage eBPF to access kernel, is competing technology to DPDK; XDP may leads to simplify the data path and network service chaining. It is very early of development. 
- IOVisor is an important technology to watch. 
- P4 will speed up more innovation. Network space takes the advantage of IT technology to speedup innovation/evolution, increases complexity.
- Hardware offload may be related to FPGA.

[iovisor]:https://www.iovisor.org/resources
=======
# OpenVSwitch Conference 2016 Fall

Sponsor = vmWare, Intel.
OpenvSwitch started from vmWare, is part of Linux. start from vmWare.
Attendees = about 100 (dropping)
presenter slides and some video will be available on conference website later.

## Day-1 Monday, November 7

#### Keynote
Nick McKeown, Stanford University, One founder of P4

User-Programmable Software Switches:
* Need debugging tools when the network failed.
* Need to modify the network to keep it working.
* P4 is more in the forwarding plane, (PISA, Protocol Independent Switch Architecture)
* look a packet and ask: why is here, what is path to get here,
* parser (header typing) - (match+action) no protocol yet, do this n time to transform header - distribute to ports
* Data declaration, Parser (how to find the head after current one), table + control flow

control plane roles, things switch can do
queue, multicast, mirror,...

everyone wants visibility and meansure

Key-Value Store in P4 (SwitchKV or Paxos in P4)
PISCES (Protocol Independend Software Switch)

vpp is part of ecosystem.

**declare network forwarding behavior**
p4 chip set is in progress.
Language should out live platform.

#### An Update on OVS and OVN
Justin Pettit, VMware

started every six months release.
##### OvS 2.6 features

* OVN
* NAT support
* QoS and policing for DPDK
* Basic Connection tracking on DPDK and Hyper-V

What is OVN?
* Virtual Netowrking for Open vSwitch
see [What Is Open Virtual Network (OVN)? How It Works](https://www.sdxcentral.com/sdn/network-virtualization/definitions/what-is-open-virtual-network-ovn-how-it-works/)

** possible move OvS in P4, there is a discussion**

[OVN Vancouver Meeting slides]:http://openvswitch.org/support/slides/OVN-Vancouver.pdf

#### The Power of Compounding Caches in the OvS Pipeline 
Ben Pfaff, VMware

Performance
* Fast packet I/O
	* import
	* Orthogonal to switch architecture
	* not comparable to complete software switch
* Low overhead per-packet
	* a series function calls
	* OvS has parser at beginning 
* Low processing cost per-packet
	* a stage is only a function
	* to anything or nothing
	* OvS stage has expensive classifier per stage

Caches history
* MAC learning
* ARP cache in IPv4
* Route cache

#### BPF: Next Generation of Programmable Datapath
Thomas Graf, Cisco Systems

Happened in 2016, release OvS2.6
Modify byte code and insert modified code into kernal

[BCC - Tools for BPF-based Linux IO analysis, networking, monitoring](https://github.com/iovisor/bcc)

[intro to BPF](https://blog.cloudflare.com/bpf-the-forgotten-bytecode/)

[Programmable Abstraction of Datapath slides]:https://www.ewsdn.eu/files/Presentations/EWSDN%202014/2__Programmable_Abstraction_of_Datapath.pdf
[Programmable Abstraction of Datapath report]:http://www.fp7-alien.eu/files/publications/EWSDN2014-ALIEN-PAD.pdf

#### Using eBPF to Accelerate OVS Datapath
Nic Viljoen, Netronome

[more XDP info](http://open-nfp.org/media/pdfs/Open-NFP_eBPF-Offload-Starting-Guide.pdf)

goo.gl/Ym1AaC

#### Offloading OVS Flow Processing Using eBPF
William Tu, VMware

what is eBPF?
Motivation
* Extensibility when introducing a new datapath feature
* maintenance cost and compatibility effort
* eBPF reduce dependence on different kernal versions

#### Coupling the Flexibility of OVN with the Efficiency of IOVisor: Architecture and Demo

Fulvio Risso and Matteo Bertrone, Politecnico di Torino, Italy

* Data Center Network requires a mix of different technology.

replace bottom layer with IOVisor 
- eBPF is a virtual achine that extends classis
- open source iovisor-ovn
qemu vm

ovs+vpp extension is ok option
edge and home gateway has more advantage

#### Wepoq-OVN, an L4 Gateway for Extended Endpoints
Gabe Beged-Dov, Prismod System, LLC
** it is not ready yet, bad presentation too **

#### Service Function Chaining and OVN
Louise Fourie and Farhad Sunavala, Huawei;
John McDowall, Palo Alto Networks; and
Flavio Fernandes, IBM

allow SFC within one switch or multiple switch

#### OVS Hardware Offload Discussion Panel
Moderator, Joe Stringer

- cpu uses most of its time for classificatio, so just offload classification
- softload 
- use policy as control 

#### OvS-DPDK Usability Improvements for Real-World Applications
Aaron Conole, Red Hat, Robin Giller and Bhanuprakash Bodireddy, Intel
* make package ease to install, config and deploy
* performance vs page size are workload specific
* Manual pinning of rx queuse
* Arbitrary port names and auto detect DPDK library
* More document for installation
* Packet Tracing use pDump and ovs-tcpdump
* start/stop OvS independently

## Day-2

#### PISCES: A P4-Enabled Open vSwitch  

Muhammad Shahbaz, Princeton University and  <-very good->
Cian Ferriter, Intel

ovs (parser, mactch)
no need to understand dpdk.
separate network logic to dpdk

* use p4 as specific language DSL to separate  (parser, match-action pipeline)
* packet headers and field
* meta data
* parser
* acition
* control plas

340 line of code use p4 to specify Native OVS, 14535
use p4 forwarding model complile to OVS model 

40% overhead, reduce it with cache, after optimization, it reaches native performace 2%, microflow cache

fast/slow path slow=need to check the table.

microflow internal
extract field, hash field, perform lookup
field location effects the performance.

#### IP Forwarding with OVS
Romain Lenglet, Oracle Public Cloud
presented a IP routing, flow table.

#### OVS for Containers with Weave Net
Martynas Pumputis, Weaveworks
https://weave.works

support overlay network
create OvS 

#### DPDK vHost User Improvements and Their Benefit to the DPDK Datapath in OVS
Ciara Loftus, Intel

DPDK (Data Plane Development Kit) integrated into OvS since version 2.2
- Non-uniform memory access (NUMA) awareness, achieve >50% performance improvement
- Client Mode & Reconnect (previous limitation when OvS crush), solution=qemu cretes the socket
- vHost PMD(core libraries, driver-via API, ready for OvS), simplified code path.
- zero copy, enqueues(tx) and dequeues (rx) read directly, can improve 15% performance improvoement.
- Mergeable buffers path improvement.

#### Hierarchical Flow Classification Enhancements for OVS MegaFlow Cache
Sameh Gobriel and Charlie Tai, Intel

- Lookup Optimization: use Bloom Filter

#### OvS-DPDK Keep Alive + Monitoring Frameworks (Collected, Snap)
Maryam Tahhan and Bhanuprakash Bodireddy, Intel
<-good slide, sequence diagram->

- monitor the components, and make sure its resilence.
- reilable,
- stringent sla
- service credits - recover fast
- service assurance

OPNFV (Barometer)
- traffic meonitorint
- platforme monitoring
- system abnomality
- celimeter/openstack

#### Quilt
Ethan Jackson, Student
Compute/Network APIs

- propose a programming language Quilt.js 
- Auto deployment to AWS, DigitalOcean

OVN
- use graph, police layer 

#### User Friendly vNetworks
Nishanth Devarajan, Student

- logic flow
- dataplane gets complicate
- OVN is important can interface with Kubernetes, P4

#### P4-Enabled NICs - Acceleration of OVS
Petr Kastovski, Netcope Technologies
- p4vhdl compile p4 to vhdl for fpga

#### Optimizing Communications-Grade TCP Workloads in an OvS-Based NFV Deployment
Mark Kavanagh, Intel
- TCP Segmentation Offload, OffLoad is good
- Multi Q
- enable huge pages

there are some performance data chart.

#### NUMA-Aware Open vSwitch w/ DPDK for High-Performance NFV Platform
Kazuki Hyoudou, Fujitsu

- use of common hw
- stand I/F for VNF
- I/O thru-put
- number of IO port

there is some performance data charts/tables, good improvement
Use Intel X710 for prototyping
Use multiple rx/tx

#### OvS-DPDK Performance Optimizations to Meet Telco Needs
Jan Scheurich, Ericsson AB and Mark Gray, Intel
- openflow table classifier
- exact match-action table

Optimization Activities
- replace tuple space classifier with a trie based classifiedr (not much)
- faster crc32 hash function
- tx packet batching
- data structure alighment
- more meaningful PMD performance debug info
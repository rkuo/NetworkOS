# [DPDK Summit 2015][summit] 
SFan, 17.08.2015 

This is a short meeting notes to share. The presentations were recorded. Video and [slides][12] will be posted on [summit site][summit] later.    

I also appended some of my pre-conference study notes.

## Notes

### Opening Remarks   
Tim Driscoll, Intel
[slide][19]

* Objective this meeting to share the experience and build community. 30-50% increase on committers since last year.
* More CPU support, including x86, Power, Tile now, but it is still very Intel centric. 
* Need support ARM **<< important**. 
 
### Scale-Out Network Functions   	
Tim Mortsolf, Chief Technical Officer, RIFT.io &   
Scott Myelle, VP Solutions Architecture, RIFT.io
[slide][21] **Good** 

* New software startup, write software for network equipment. make VM to use DPDK. 
* Make a platform for software VNF development for different (Bare Metal, Private Cloud, Public Cloud) environments.
* VNF component can be viewed as one slice of blade. Functional decomposition: 
	* high speed io
	* firewall
	* encryption
* Different Networks Attachment 
	* video
	* direct pass-thru, PCI, (it is hard to use with OpenStack, )
	* SR-IOV (used mainly for hardware off-load)
* Interface with vSwitch (standard, DPDK comparison)
* Other consideration (cpu pinning, huge page, io aware, cache) 

**Think differently, we are working insider of cpu, and between motherboards and PCI buses. It has different scale and details; we may have different cpu, nic, bridges, sockets, ...**

* Use descriptor, for example VDU, to match workload. Find out what is EPA? 
* Use Abstract IO (GW, G-LAN, NAT, FW) to interface different gateways with underline hardware.
* Create Packet I/O Toolkit to leverage DPDK.

* Toolkit covers 4 areas: which obtains 5x performance improvement.  
	* management device
	* interface IO
	* Query Interface,
	* Quening policy

VNF may have to run host, to isolate the performance measurements. One VNF may use multiple VMs.

### Aspera's FASP Protocol for High-Speed Transfer    
Charles Shiflett, Senior Software Engineer, IBM Aspera Solutions
[slides][14]

Benefit of DPDK

* lightweight
* high performance, does not need to be in kernel
* best practices
* NUMA aware
* high performance framework

Goal is to bring data closer to user devices.

Problem (see details of the problems at each hop in slide deck)

* Distance degrades conditions on all networks
* TCP degrades with distance
* TCP bandwidth does not scale
* need alternatives 

Balance between process and size <- compress packet, bandwidth

Solution <- understand current flow and congestion, manage them   

* avoid synchnoization, eliminate locks, 
* reduce copying, direct interface between storage to memory, use memory buffer.
* direct IO between layers (L2-L3), between storage to NIC.
* Use DPDK for L3 data streaming.
* read and write from multiple source and destanations, Use multiple core -> parallel processing and parallel traffic routes.

* review the solution whether the initial condition affects the solution. 

Opportunity:

* better integrate for network, storage <- modify flow, move out critical area.
* add standard processes to payload before hopping <- use more process per step.
* increase buffer size <- increase batch process block.
* have better parallel process <- ring buffer allows multiple ins and outs.

### Future Enhancements
Keith Wiles, Intel Architect, Intel
[slides][13]

* more hardware acceleration
* need ARM
* SOC - uses PMD (Poll Mode Driver)
* need to use event programming model
* need to support config, external memory mgmt system
* Multiple Network Stack
* Language binding: Golang, Swift, Java, and Scripting: Lua (ease to support), Python

### Innovation with DPDK.
Yoshihiro Nakajima, Researcher, NTT Network Innovation Laboratories
[slide][15]

Objective
* NFV/SDN-aware switch framework
* Expand software-based packet processing into carrier network

Target
* high performance SDN/OP
* expands SDN to WAN, GW and NFV

Approach

Motivation
* Network IO is not optimized for small core cpu
* Software based processing are heavy

![NTT approach][16]

* Smart NIC, leverage hadware offload
* FPGA Flow Classification & Dispatch
* Performance improvement

SDN-IX (Internet eXchange)
* This is beyond Data Center. OvS support DC well.

### Design Considerations for Virtualized LTE Core Infrastructure  
Arun Rajagopal, Technology Architect for NFV, Sprint
[slide][18]

Problems:

* EPC SGW session table size grow significantly (millions of entries) with the number of subscribers/bearers/flows.
* Flow lookup and Packet classification is common for many VNFs. 
* Distributed flow table as a single entity to control/management plane.

Best Practices:

* Avoiding serialization 
* Accessing data from the cache where possible by making use of prefetch instructions 
* Designing data structures to be cache-aligned and avoiding occurrences of data being spread across two cache lines, partial writes, and contention between write and read operations* Maintaining affinity between software threads and hardware threads,
* Breaking down user-plane functionality (Microservices)
* Use of pre-tuned open source optimized software components like DPDK

### Evaluation and Characterization of NFV on HP Platforms  
Al Sanders, Lead Developer, Hewlett-Packard 

Test the NVFi functions, see [slide][20] deck for the details of hardware layout. 


---
***
## Background Study 
Excerpt from report - [A Look at Intel’s Dataplane Development Kit][3]

### Abstract Model
![Abstract Model][4]

* With the arrival of the packet at the receiving NIC (1) 
* The packet has to be transferred to main memory (2). 
* Therefore the Linux kernel uses the *sk_buff* structure for the internal representation of packets. The NIC has a buffer, usually a ring queue called ‘*ring buffer*’, to store pointers to *sk_buff* structures (3), one for each packet reception and transmission. 
* To achieve this the direct memory access (DMA) engine of the NIC is used, mapping the structure to kernel memory space. The second step is to inform the kernel that a packet is available (4). 
* The interrupt handler adds the NIC to a so called *poll_list* and schedules a soft interrupt. When this interrupt gets served the CPU polls each of the devices present in the list to get their available packets from the ring buffer. Then, for each of these packets a function is called to start the processing through the *network stack*. (5)
* The network stack processes each packet layer by layer, starting with the network layer. 
	* At first, basic checks, including integrity-verification and application of firewall rules, are performed. If the packet is faulty it gets dropped, otherwise
it gets passed to the routing subsystem (6) in order to make a decision whether the packet 
		- has to be delivered locally to a userspace application or 
		- forwarded to another host. 
	
	This decision is being made based on the implemented routing algorithm that finds the best match for the destination IP address of the packet in the routing table.

* If this address equals one of the hosts locally configured addresses the packet has to be delivered locally and is handed over to the transport layer. After passing the transport layer the packet can finally be delivered to the application. Using the socket API the data of the *sk_buff* gets copied to userspace. Now the application has full access to the data of the received packet (7a). 
* The same way an application in userspace can pass a packet down to the network stack in order to transmit it (8).

* In the case of forwarding the packet (7b), no processing of layers beyond layer 3 is needed. On the network layer the main task is to decrement the TTL header field and, in case it reached zero, to drop the packet and send a corresponding ICMP message. Furthermore, sanity checks, firewall rules and fragmentation can be applied.
Afterwards the packet gets passed to the transmitting part of the network stack, too (8).

* The layer 2 processing does not differ for forwarded and locally created packets. Based on the result of the routing lookup, the layer 2 address of the next hop has to be identified using for instance the Address Resolution Protocol. After meeting these tasks a function of the NIC is called, informing it to transmit the packet. (9)
* First of all the driver has to load the packet descriptor, which holds the location of the *sk_buff* in main memory, into the transmitting ring buffer (10). 
* Afterwards he tells the NIC that there are packets available and ready to send (11). Secondly the NIC has to inform the CPU via an interrupt that the *sk_buff* structure can be deallocated.

### Call Flow Comparison between Linux and DPDK
From [Understand DPDK][0]

![Packet Process in Linux][7]
![Packet Process in DPDK][8]

Performance improvement comes from:

* Processor affinity (separate cores) 
* Huge pages (no swap, TLB)
* UIO (no copying from kernel)
* Polling (no interrupts overhead)
* Lockless synchronization (avoid waiting) 
* Batch packets handling
* SSE, NUMA awareness

### Libraries

![DPDK Major Components][5]  
Excerpted from [Communications Packet Processing Brief][2]

* The **Environment Abstraction Layer (EAL)** provides access to low-level resources (hardware, memory space, logical cores, etc.) through a generic interface that hides the environment specifics from the applications and libraries.
* The **Memory Pool Manager** allocates NUMA-aware pools of objects in memory. The pools are created in huge-page memory space to increase performance by reducing translation lookaside buffer (TLB) misses, and a ring is used to store free objects. It also provides an alignment helper to ensure objects are distributed evenly across all DRAM channels, thus balancing memory bandwidth utilization across the channels.
* The **Buffer Manager** significantly reduces the amount of time the system spends allocating and de-allocating buffers. The Intel DPDK pre-allocates fixed size buffers,
which are stored in memory pools for fast, efficient cache-aligned memory allocation and de-allocation from NUMA-aware memory pools. Each core is provided a dedicated buffer cache to the memory pools, which is replenished as required. This provides a fast and efficient method for quick access and release of buffers without locks.
* The **Queue Manager** implements safe lockless queues instead of using spinlocks that allow different software components to process packets, while avoiding unnecessary wait times.
* The **Ring Manager** provides a lockless implementation for single or multi producer/consumer enqueue/ dequeue operations, supporting bulk operations to reduce overhead for efficient passing of events, data and packet buffers.
* **Flow Classification** provides an efficient mechanism for generating a hash (based on tuple information) used to combine packets into flows, which enables faster processing and greater throughput.
* **Poll Mode Drivers** for 1 GbE and 10 GbE Ethernet controllers greatly speed up the packet pipeline by receiving and transmitting packets without the use of asynchronous, interrupt-based signaling mechanisms, which have a lot of overhead.

### Compare to Other Frameworks
![compare][6]

### Use DPDK

* [Step by Step][9]
* [Get code from github][10]
* [Visit documentation site][11]

[References]:
[summit]:https://dpdksummit.com/
[0]:http://www.slideshare.net/garyachy/dpdk-44585840?related=1
[1]:https://haryachyy.wordpress.com/
[2]:http://www.intel.com/content/dam/www/public/us/en/documents/solution-briefs/communications-packet-processing-brief.pdf
[3]:http://www.net.in.tum.de/fileadmin/TUM/NET/NET-2014-08-1/NET-2014-08-1_15.pdf
[4]:https://www.evernote.com/l/AS4Z2_f2FaVFjJvH-UcTxNDB2jcp_Y_QkTUB/image.png
[5]:https://www.evernote.com/l/AS56rLXtZGRINLkaRhRZeVMas8BKHfMtpkIB/image.png
[6]:https://www.evernote.com/l/AS5Z0bPy4TxL_Yaqf56SNUGLb-J-vBzLe-8B/image.png
[7]:https://www.evernote.com/l/AS4bGlVH3jBEzaBsQRKfBvuUMxMVi3_0iZ8B/image.png
[8]:https://www.evernote.com/l/AS5AwBUd5QtFHYTn3x2PJqlYIWYFdHSVlXoB/image.png
[9]:http://www.slideshare.net/hisaki/intel-dpdk-step-by-step-instructions
[10]:http://dpdk-org.github.io/dpdk/
[11]:http://dpdk.org/
[12]:http://www.slideshare.net/jstleger/presentations
[13]:http://www.slideshare.net/jstleger/dpdk-summit-2015-intel-keith-wiles
[14]:http://www.slideshare.net/jstleger/dpdk-summit-2015-aspera-charles-shiflett
[15]:http://www.slideshare.net/jstleger/dpdk-summit-2015-ntt-yoshihiro-nakajima
[16]:https://www.evernote.com/l/AS6d4k14lhZFQZ6YWgPksagJAtsyy3ftg5MB/image.png
[17]:http://www.slideshare.net/jstleger/dpdk-summit-2015-hp-al-sanders
[18]:http://www.slideshare.net/jstleger/dpdk-summit-2015-sprint-arun-rajagopal
[19]:http://www.slideshare.net/jstleger/dpdk-summit-2015-intro-tim-odriscoll
[20]:http://www.slideshare.net/jstleger/dpdk-summit-2015-hp-al-sanders
[21]:http://www.slideshare.net/jstleger/dpdk-summit-2015-riftio-tim-mortsolf


# IDF15

[IDF Website][1] Agenda is a single page application, all slides are listed [here][2], use session number to filter the slide.

### Key Notes
Intel, Brian Krzanich, CEO

* Interact amony the devices with Open Sources and API.
* Scratch is in part of demo. 

*3 Assumptions:*

* sensification to get user more involved:

	* sound -> speak and listen, different way to connect to the cloud, 
		* wake-on-voice interface with Microsoft Windows. Nature Language Processing.
		* reduce audio latency, worked with Google 
	* view -> use a drone 
		* navigate thru forrest, Google project Tango, @RealSense in Android phone to scan the 3D objects. combining virtual reality.
	* action -> robots, ROS (Robot OS)
	
* smart and connected -> interface with mobile devices.
	* robot serves as butler. It needs real-time sensing and response. 
	* Game -> PC Game is feeling, which requires computing power. 
	iRacing, Razer (camera), twitch is gaming platform.
	* Memomi -> Mirror input for fashion comparison, shopping experience.
	* Nabi - Baby car seat, with the sensors in clipper and link to phone as reminder. 
	* N&W - Vending machine, customized per user, standardize the platform. It can also serve as advertisement platform.
	* Security IoT -> Enhanced Privacy ID.
		5G connectivity
* computing device become part of user -> wearable
	* fossil group -> fashion products, android watch

* Announces [Curie chip][9] in Jan 2015 SoC
	* BMX sensors on bike 		
	
* Intel IQ 
more software Kits (body iq, social iq, time iq, identity iq)
Q4 will release for Curie

* enterprise wearables to solve the password problem, auto-unlock
* blue tooth, low energy sercie
* this can also be part of building facility management.
* Makers' fair competition

**Mark Burnett**
CEO of United Artists Media Group
Will host makers show and broadcast **<< good marketing**
www.americagreatestmakers.com, $1M price. 

* Unleashing Display, floating piano keyboard.   
* Rearchitecting the computing storage architecture -> 3D xPoint Technology, store microswitch in the connection, which allows to re-route -> Intel Optane, can be used as SSD or DIMM. 5x-7x improvement. -> big data analytics, 

---

### INFS001 — Implementing Software Defined Infrastructure for Hyper-Scale 
Das Kamhout - Intel, [slide] **Good slide to review again**

* Evolution: from for human toward for computers
* Data Center Computing Progression   
* Software Defined Infrastructure (resource pool -> os -> virtualization -> orchestration Software -> developer environment), half of attendees use Docker, mesos,..

Mesos + Kubernetes + Zookeeper
mesos slave -> send available resource -> mesos master -> framework -> master 

docker - then ceph-mesos executor -> mesos master -> framework

github/intel/big-data/ceph-mesos
Serenity loaded as a mesos module, github/available mesosphere/serenity

Power Thermal Aware Scheduling, Use thermal power control the scheduling, which reduces 24% cooling. Baidu.

VT Enabled Host, Core-OS -> rkt -> lkvm + lightweight OS -> User Apps

Best practice:

* Use shared read-only file system
* Open Container 
* Run on bare metal

Testing hardware = E5-2670v3 + ssd 

---

### INFS002 — Software-Defined Infrastructure: Tips, Tricks, and Tools for Network Infrastructure Design and Optimization
Edwin Verplanke, Intel

SDI (Software Defined Infrastructure)

* Packet Switching 
* Virtualization Hardware Assists
* Platform Quality of Services

With DPDK an OvS can deliver 60GB/s performance. It targets on 160Gb/s  
Optimization in virtual world maybe different from bare metal.   
There are opportunities of performance improvement in host to VM and VM to VM communication.  

---

### GSSS003 — It’s Not Business as Usual
Jason Hoffman, Head of Cloud Technology, Ericsson, 

* This session is recorded. It is more a marketing session than technology. 
* Software as an Infrastructure, we can view Data Center as new factory. We a configurable DC which allows us to adapt the business evolution.
* **Hyper Scale Clouds**, efficiency comes from managing the different workload profile.   

Alex Jinsung Choi, SK Tlecom

---
### IOTS001 - Bringing the Internet of Things to Life: Rapid Innovation Using the Intel® IoT Platform

Charlie Sheridan, Director, IoT Systems Research Lab, Intel Labs  
Mark Kelly, Senior Staff Researcher, IoT Systems Research Lab, Intel Labs  

![intel platform][3]

* Responsive Edge Computing, 
* Perceptive Networking, 
* Data Fusion Algorithms, decision making

Need a team to build a system. 
3 labs, UK, Doblin, San Jose

![Logical definition of IoT Platform][4]

* Platform concerns are different in Lab from deployment.
* flexible gateway is important, which allows configuration
* Data collection from devices and processing across the data center is critical.
* Consumer is only interested the information, so API design is important, OOB (Out Of Box) experience is expected.

![concerns are different from scope, domain, and sensor condition][5]

* This slide highlights the difference between them. **If the session is recorded, listen it again**
* Understand the use-case during the life cycle of sensor installation is important.
* Real-time event collection and analysis is important, all data collection needs to have timestamp.

EnerNet for smart metering.
Energy conservation is still, if it is more, important in data center, node.
Use Galileo and Edison development kits as starting point.

---

![security edge computing][7]

---

[Referenc]:
[1]:http://www.intel.com/content/www/us/en/intel-developer-forum-idf/san-francisco/2015/idf-2015-san-francisco-technology-showcase.html
[Ericsson Cloud]:http://www.ericsson.com/spotlight/cloud
[2]:http://myeventagenda.com/sessions/0B9F4191-1C29-408A-8B61-65D7520025A8/7/5
[3]:https://www.evernote.com/l/AS5qSzK6SC1EILAlu3aL_bcvqiX3IHQpFb4B/image.png
[4]:https://www.evernote.com/l/AS5TBy1fc0RJnbH4-MXzxF4b_DfzF3tCcl0B/image.png
[5]:https://www.evernote.com/l/AS6MI0OnkDNAibX_LeC5bddv2oFCEm6WTcYB/image.png
[6]:http://opentsdb.net/
[7]:https://www.evernote.com/l/AS66PAN7fJFKS5zVxWmIRd_N3eq94ptIBY0B/image.png
[8]:https://www.evernote.com/l/AS4r7wxU2uJDbpLpUm9-KdI3JpRMsHlbjgcB/image.png
[9]:http://www.intel.com/content/www/us/en/wearables/wearable-soc.html

---
---
### Background

#### Edge Computing
[Edge Computing]:https://en.wikipedia.org/wiki/Edge_computing
[ETSI MEC portal]:http://www.etsi.org/technologies-clusters/technologies/mobile-edge-computing
[Mobile Edge Computing white paper]:https://portal.etsi.org/Portals/0/TBpages/MEC/Docs/Mobile-edge_Computing_-_Introductory_Technical_White_Paper_V1%2018-09-14.pdf
[Fog Computing From the Center to the Edge of the Cloud]:http://www.slideshare.net/professorbanafa/fog-computing-from-the-center-to-the-edge-of-the-cloud?qid=39ceebbc-220e-426f-a710-8b4a63d6e030&v=default&b=&from_search=2
[Improving Web Siste Performance Using Edge Services in Fog Computing Architecture]:http://www.slideshare.net/JiangZhu/web-perf2013?qid=39ceebbc-220e-426f-a710-8b4a63d6e030&v=default&b=&from_search=10

#### Data Center
* **hyperscale datacenter systems** realizing a disaggregated hardware architecture, 
* using optical interconnect and a new equipment manager for multi-vendor environments. 
* It enables complete operator cloud transformation, 
	* including support for Network Functions Virtualization and 
	* IT and commercial cloud operations. 
	* to enable support for hyperscale storage-centric applications.

It is a very productive trip.

I found out what RedHat and Ericsson's offers in SDN/NFV space, 

* Ericsson - Apcera, Ericsson NFV ecosystem, 6000 series equipment, 
* Redhat - Affirmed, Redhat Enterprise System supporting NFV.

also learned many other components that related to Domain 2.0, such as,

* components for building Wireless Network physical infrastructure, how do they effect virtualization.
* Internet of Things that connected to network, 
* Digital life, connected cities and connected cars; which drive the wireless network SDN/NFV design requirements. many requiremens are non-technical.

A brief summary is list below:

#### Ericsson

* [Apcera](https://www.apcera.com/) is working with Ericsson to containerize NFV functions, which are currently in the VM format.
* Ericsson's Element Management can define a POT (just name for virtual grouping), which groups VMs or containers for NFV deployment. Currently, it is mostly for VMs.
* Ericsson 6000 series can have multiple anternas (fronthaul mixed with different backhaul. This opens up the challenge - how should we design our RAN network in 5G. Current C-RAN topology may not meet the need of 5G.  
* Ericsson is working with Intel to develop the next generation of server, which will eliminate backplane with optical connection. The connection is programmable, which allows operator to create customized server in real-time; Software Driven Server, very cool! Number of core per blade, size of RAM and network bandwidth is configurable in real-time. The configuration is driven by big-data analytics and ML.

![Ericsson NFV EcoSystem][1]  

If diagram does not display, please paste the link to your browser to view, https://www.evernote.com/l/AS7YVypgk7NDxqI-KBYdiy0qxMtNlLWwzj8

[1]:https://www.evernote.com/l/AS7YVypgk7NDxqI-KBYdiy0qxMtNlLWwzj8

My random notes:

* Network Element is virtualized, so is EMS too.
* In some way, this is the separation of spaces, and mapping between spaces are needed (can we think they are part of diamension?? discuss this with Bob):

Virtual Machine	| Containers	| Type
:-----------    | :-----------  | :-----------
VM         	    | container     | node
hyervisor(kvm, xen) | layer on top of linux, i.e. LXC, Docker Daeman| running platform, interface w/lower layer
network path | container network | links, one plug at each end for encoding & decoding
mgmt (vmware, OpenStack) |kubertenetes, etcd| life cycle mgmt, nodes/links, group formation & life cycle, policy creation and attachment


#### RedHat

Combined with [Affirmed](http://www.affirmednetworks.com/) as Element Management System and 
Redhat Enterprise OS, Redhat offeres a NFV software solution. This is currently installed in AT&T Labs for testing and review. It has following characteristic:

* uses vmWare as Hypervisor, OpenStack is on the roadmap. SGSN and GGSN are available, TWAG/TWAS are in the next release.
* current only delivered PGW/SGW and Media and Content components to AT&T Labs. 
* supports VM only, they are aware container technology, but there is no roadmap.
* can define define the dynamic policy for NFV to meet the scalability requirements, the system will select an available resource to create VMs and backup VMs at different blades for redundence. 

![Redhat NFV][2]

If diagram does not display, please paste the link to your browser to view, https://www.evernote.com/l/AS7mrYPFlERGB6A1StNMo3q5Q37cmAEUjZI

[2]:https://www.evernote.com/l/AS7mrYPFlERGB6A1StNMo3q5Q37cmAEUjZI

## Keynotes

http://www.ctiasupermobility2015.com/registration/index.cfm/daily-schedule

### Day-1

#### Meredith Attwell Baker, CTIA

* All the applications around us in daily life gets moved into device.
* Around 85% people keep the phone next to them all the time.
* Wireless is way to keep things connected.
* Platform is necessary fo innovation. American has 91% mobile app download.
* This leads to => more data => analysis
* Next year bandwidth auction. 

#### Ron Smith from Bluegrass Cellular:  

* market in rurel area, country side is opportunity.   
	* less user, but more devices => IoT covers more area.   
	* large area => different characteristic,    

#### Jim Wales from Wikipedia:  

**about wikipeida**

* provides free access, knowledge is re-usable.   
* is the sum of the all human knowledge. 34 million articles, in 288 languages. It is related to internet access. 
* is blocked in China.  
* has 500 million visitors.

Lesson learned:

Uber did not spend too much on ad. 
	* word mouth: Toms shoes
	* viral platform - kickstarter (17m pedges), change.org (76m member)
	* long tail - Amazon, cost of providing service is very minimun.

Promoting **the people operator (tpo)**  <<== new competitor, increditiable; the entry has no assets, no experience.

10% of bill goes to the cause your choice.
25% of profits go to charity.

Sprint is one partner in U.S.  

My random notes:

* Mobile service provider because only part of ingredient of business model. [tpo](https://store.tpo.com/)  

#### Tom Wheeler Chairman, FCC
   
* spectrum can be shared.
* the need of continue innovating.
* starts on March 29, 2016, 600mhz ==>> opportunity for innovation.
* AT&T will use WCS for hih speed wireless.
* the governing rules may need to be modified to meet new technology and application.  

#### Michael Che, 

Good conference program design to include some laugh.

## Tech Talks

### Future Mobile Networks

#### Peter, Marketing Research 

#### Verizon Approach

work with Lucent, Cisco, Erisson, Junipier, OpenStack, 

Decoupling, interconnect, cloudify, Decompose application
75% virtualization by 2020
open, simple, scale, secoure

#### AT&T

3 Pillars `NFV`, `Ecomp`, `sdn`   

My random notes:
  
Software Define Network => New skill requirement, also => Openness, also => DevOps <-- **critical 1**

#### Cloud RAN

Good slide deck to review again.
* there is limit preformance other technologies can contribute.
* improve network intelligent, more opportunity for inter-system optimization, integratiion.
* reduce the resource requirement.
* automatic recovery, more agile.

* Consolidate various nodes, same baseband vm across locations/applications.

* Resource Pooling, Scalability, layer networking, spectral efficiency

### Day-2

Everything goes to wireless.

#### Glenn Lurie, AT&T Mobile  
Connecting your world   
10% penetration 1985, 100m user@2000, 355m user@2014  
2003-2014, cap investment 20 times

mobile video in 25 Exabytes@now,   570EB @2020
connected home 200m@now, 700m global @2020
IoT 4.9B@now,  25B@2020

New Era in Wireless, 
Smartphone: Remote Control of Life
Home, Car, IoT, Industrial, this is only a subset.

Home Automation 42B@2020, 

* security, simple customer experience, customizable

Digital Life

* All IP
* Complete solution
* Leader in net flow share
* Customer satisfication.

Announce (api-work with NEST, Personal Security-monitor personal security, )

25B global @2020
Everything is connected, Making business better, data analysis, 

AT&T IoT

* Invested early, start-up, Approach, Customer centric, cutting edge platform.
* 23m+ IoT now
* TUMI for lagguage tracking.
* KIKa monitor bike
* Permobile, connected wheel chair allow care giver to monitor
* Health - connect to other display Trail with Dr. Lynda Chin in U of Texas
* Industrial IoT, 1B global M2M, (more efficent, productive), invest platform, 200+ contracts with AT&T. Telogis, 
* Connected car, agreements with 8 mfg, advanced platform. 4.8m now, 
* Customer experience inanimate Objects, simple solution, single customer experience, << **connected world**

My random notes:  

**Take care the Life cycle of things, interface with ** <-- **critical 2** 

#### Bob Pittman, Mediacomm  
* phone should not be called phone anymore, do not let term to limit our thinking.
* a factor allows product-A to be succeed in maybe in product-B
* appreciate the personalize, to identify his/her own characteristic
* relationship thru the media may be differently, review the items/object's 
* advertise is to connect the needs and offers **like intelligent switch**
* can we ask the request to change the problem statement, so task changes to solution providing.
* to forecast unknown, to better deliver the service, do not use exist system as boundry, abstract the function/service delivery for problem solving first, fit the 
* mobile delivery convience.

My random notes:   

* radio is part of devices, often we cannot use our visual, listening is only thing we can do.  
* A person's available is limited  
* thru the devices a person connected to others (which can be any role we need)  
* we may be able to connect the people differently, including early connection, like Uber shows taxi is coming via map, more holistic. **extends the life cycle of relationship, both in begining and ending**  

#### Marni Walden, Verizon   

* 20% cut cord to TV
* sell assets, eco-systems
* jeffery Katzenbery, dreamworks, and Dave Penski, vivaki:
	* content - sometimes device/delivery platform leads entertainment revolution. 
	* content format is changing too, for example, one hours show is broken down to short segaments, needs re-define format
	* mobile device changed the life style, <-- **important to understand**
	* understand the existing eco-system, how do all parties respond to the change and move alone, do not discard the existing players.
	* things to concern: secuirty, 

My random notes:   

* mobile Device is connect to a person 
* mobile device not only serve as connector also acts as a content producer for multiple types.
* mobile device also being used in the home. **device should consider as a interface between physical world to digital world.**
* study **mobile cloud** and edge computing.
* eliminate the contraints by offering a services that defeats the need of attack.

#### Marcelo Claure, Sprint and Chuck Robbins, Cisco   

* appreciate speed of changing 
* stuff the team with global profession, **global culture**
* contract free, 
* 70-80% of time to work on strategic technology **critical 3**
* listen to customer understanding the market transition
* Cisco is partner with iPhone directly **short cut carrier**
* use more micro cell as buffer.
* enable the service delivered globally. 

My random notes:  

* distribute computing to meet high mobile and storage demand.

### Day-3

#### Under Armour

Connected Fittness:

Interface with other Apps, health, social media (what is needed in this community). It's member profile: 63% female, 71% under 40yr, 42% international.

Review the evolution of Under Armour to understand trend and its promotion. It defines the potential products. 


My random notes:
- built-in sensors in everyday clothes/shoes.
- local/portable node (compute, storage, networking, interface,..)
- look beyond individual node, what is the group needs, how to form a group, individual node's behavior may be effected by group, ecosystem. 


Per your email, I attended Intel Developer Forum 2016. This is very productive meeting,   learned many new things and triggered more todo. This is a short summary. 

- Intel is bidding part of their future on IoT (Internet of Things): 
	- produced development board, packaged with 3rd party IO devices
	- promoting hands-on MAKE, coding, hacking.
	- released new chips, Curie, ??? for sensors and actuators.
	- push open source foundations, such as Open Connectivity Foundation, Open Network Insight.
	Intel belives there is large demand on IoT chips in near future, they are cultivating this field. As IoT continue to grow, the required cloud infrastructure may evolve toward Edge Computing. This is especially true for 5G network which requires high computing power at radio towers.
	 
- Intel is promoting new server architecture design with CPU + FPGA. This allows the CPU architecture and behavior to be customized in real-time per application. At larger scale, the data center architecture and performance (compute, network, storage and security) can be modified per application. 
	
For more detailed notes see ???



IDF16
August 17, 2016 Richard Kuo@SF

## Day-1

## Keynotes
### Brian Krzanich, 
CEO of Intel

What is VR interacting with real world? 
Intel plan to "power the cloud and connect the devices". This is the main theme. 

- redefine computing, 7 gen core for 4k vdieo

- visual intelligence, realsense with sdk for developer, drone with 4k video, can navigate.
maker-Aero, drone system for diy, with LTE, Euclid fir robot developer, camera 400
transportation revolution about automated driving car.      
central enviromental model vitural reality equals reality, <-do a prototype modeling for this

- cloud designed for innovation
At year 2020, storage requirement, ~1.5gb per day per person, hospital 3000gb, car 4000gb, air plane 40000gb, smart factory 1,000,000gb

- empower developer
Curie, knowledge buider on chip pattern match. 

Virtual Reality is here, music demo: drum and piano. It tracks 3D movement and secondry/derivated data. Band can be grouped in VR world, instrument can be easily defined/modified in real-time. VR + ML = ? <-innovation

### IoT
future of city
Jeff and John Gordon from GE

A Personal Drone can be considered as an extension of the functions of a person's visual, arms, such as, soldiers in battle.    
Intelligent data and meta-data collection. <-modeling a city, both indoor and outdoor.

#### Joule
* Use case-1: safety glass for worker for real-time feedback, like on body camera for police. <-this is similar to google glasses, professional assistant requires hands free. When the output/result of a person's task is highly critical, then the info/instruction to carry that task becomes necessary; we need job-aid and feedback.      
To get function/features: We can think a robot reduce the human involvement.   
* Use case-2: grush to brush teeth, sense the teeth are brushed.

## Day-2

There is a Connect Effect -> creates relationship, allows event notification, response, and interaction.    

IoT -> intimicy of data collection/monitoring -> data explosion -> twitch and streaming, allows fire fighter to collect the onsite data and analyze it for real-time decision     

### Edge Computing      

computing -> pervasive and ambient -> edge computing   
storage ->    
analytic ->    
networking -> bind the things together -> data sharing -> allows context to extend, allow the device to see the facts/context beyond    

retrofit the existing building/environment, add more interactive capability for actors

### 5G + SDN software defined infrastructure panel 
Tom Keathley from AT&T, 
Sezo Onie from Docomo
John Gorden from Current
Murthy from Intel

Connectivity is moving away from telephone/voice only

problems/challenges: 
5G moves out of telecom industry,   
different allocation for different industry, priority

streaming is only a format/mode of incoming data   

move intelligence to the client -> edge computing   
relavence of data -> edge become more competent   

5G may aggregates various of networks and paradigms.    
We are still in R&D period, standardize, 2020  

### Data Center
cloud, network, AI

Open telemetry framework -> snap on mirantis diestribution, kubernetes will come

if we virtualize data center, it is not as important where it is in the flow anymore. **why do  we still need a data center?**

#### microsoft
user of Intel Silicon Photonics

released some lib MKL, like dpdk open source
leverage FPGA to customerize the infrastructure in real-time for different apps

follow data path, customerize DAG (directed acylic graph) in FPDA   
FPGA can enhance cpu-based processing    

letter to jacob about server

### security analytics
- ops can only see limited things a day
- with ML we can see data back day before
- from deterministic to more probilitistic data
- network insight 
- docker container 

use ML to filter incoming data for learning

### Data Center Evolution

- Orchestration (compute, network, storage, security)
- resource pool (FPDA can change the application behavior and attributes), IP libraries (Analytics, Network, Storage)
- <<insert pic>>
- Microsoft use for Bing search, 2x performance improvement, 
- Arria-10 allows to optimize the apps at network, cpu, storage

#### distribution
- drive fiber deep and move cable layer toward edge of the network
- full duplex
#### Convergence
single, reconfigurable device supports cable remote phy, fiber olt, 5g
#### virtualization
- high layer
- NFV 
- <<<<<< read slide deck again >>>>>> see slide#65
- it is not just about edge, needs end2end, 

### OCF
- specification, define standard model for IoT devices
- open source implementation
- certification

- LonMark is one of members
- follow IETF standard
- mnmn = mfg name
- see diagram of security overview


ToDo
- Investigate OpennNetwork Insight (for network security) and https://www.iotivity.org/
- Test Ubuntu-core on RPi-2 and run docker container
- Model high level smart city, use SimCity as reference
- find out the difference of edge vs fog computing, mindmap, 
- Investigate Open Connectivity Foundation, model it with RESTlet
- investigate OCF to RPi, find out the relationship to Gobot
- investiagte honeywell in OCF funance control app
- research UML to Json/RAML or EMF



















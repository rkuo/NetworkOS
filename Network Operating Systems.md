# Network Operating Systems

Questions to Larry:
- Why do we need ONOS? What is our problem need to solve? 
- Why do we need Virtex? Can I just use standard Hypervisor + (ONOS or even just Linux)? to reduce complexity of stack.
- How ONOS/Virtex related to OpenStack? They have Neutron plugin now, when the both exist to solve our problem?
- Who else is this space?
- If we have to make decision today, what issue will hold us back of using ONOS and Virtex?

write my own answer send it after the discussion.

From [wikipedia]
Network operating system refers to software that implements an operating system of some kind that is oriented to computer networking. For example, one that runs on a server and enables the server to manage data, users, groups, security, applications, and other networking functions.[1] The network operating system is designed to allow shared file and printer access among multiple computers in a network, typically a local area network (LAN), a private network or to other networks.

[wikipedia]: http://en.wikipedia.org/wiki/Network_operating_system
## References and ToDos
- Review [Coursera SDN class]
- Scan [ACM SIGCOMM Workshop on Hot Topics in Software Defined Networking (HotSDN 2014)]

[Coursera SDN class]: https://class.coursera.org/sdn-002 
[seminars]: http://www.opennetsummit.org/ons-inspire-webinars-on-demand.php
[OVNC Keynote: ONOS - Enabling Software Defined Transformation of Service Provider Networks]: http://www.slideboom.com/presentations/1183970/OVNC-Keynote%3A-ONOS--Enabling-Software-Defined-Transformation-of-Service-Provider-Networks
[ACM SIGCOMM Workshop on Hot Topics in Software Defined Networking (HotSDN 2014)]: http://conferences.sigcomm.org/sigcomm/2014/hotsdn.php

## Requirement

1. support multi-tenants
2. decouple physical and virtual network
3. allow security and isolation of multi-tenant traffic

- support overlay on top of existing network (which will evolve to different topologies and components). For example, vpn, gre...
- support underlay on top of existing hardware evolution. 
- in some way, we need to virtualize both data plane and control plane independently. The network graph for upper and lower layer need to be evolved independently. 

## Open Newtwork OS (ONOS)
![ONOS]

### Tutorial
![ONOS diagram]

Most of tutorial can be found at [onosproject wiki]

[ONOS]: https://wiki.onosproject.org/download/attachments/360449/global.logo?version=2&modificationDate=1414633691908&api=v2
[ONOS diagram]: https://assets.sdncentral.com/ON.LAB-Open-Network-Operating-System-ONOS-1394342534
[onosproject wiki]: https://wiki.onosproject.org/display/ONOS/Distributed+ONOS+Tutorial

#### Pre-requisites
- First complete the [OpenFlow tutorial] and the [Mininet walkthrough]. Although not a requirement, completing the [FlowVisor tutorial] before starting this one is highly recommended. Also being familiar with [Apache Karaf] would be helpful although not entirely required.

[onlab]: http://onlab.us/ 
[ONOS wiki home]: https://wiki.onosproject.org/display/ONOS/ONOS+Wiki+Home 
[OpenFlow tutorial]: http://archive.openflow.org/wk/index.php/OpenFlow_Tutorial
[Mininet walkthrough]: http://mininet.org/walkthrough/
[FlowVisor tutorial]: https://openflow.stanford.edu/display/ONL/Flowvisor
[Apache Karaf]: http://karaf.apache.org/

### Workspaces
- Software feature [release 1], can be found at [downloads]
- For [ONOS docker container] see instruction [ONOS from Scratch]

[release 1]: http://www.prnewswire.com/news-releases/onlab-delivers-software-for-new-open-source-sdn-network-operating-system--onos-300004797.html
[downloads]: https://wiki.onosproject.org/display/ONOS/Downloads
[ONOS docker container]: https://registry.hub.docker.com/u/ywang1007/onos-buildenv/
[ONOS from Scratch]: https://wiki.onosproject.org/display/ONOS/ONOS+from+Scratch


## OpenVirtex

Good talk [Virtex talk in OpenStack]

*Why*-we need to program the virtual network created by cloud computing system,i.e. OpenStack.

![why virtex]

[openvirtex]:http://ovx.onlab.us/
[Virtex talk in OpenStack]:https://www.openstack.org/summit/openstack-paris-summit-2014/session-videos/presentation/ovx-virtual-software-defined-networks
[why virtex]:https://www.evernote.com/shard/s302/sh/80bb20c1-27d0-4a1d-b39c-e10386233a82/18ac47d64c170bcea94dea5e702d1fb9

### Use case 1

![virtex use case 1]

[virtex use case 1]:https://www.evernote.com/shard/s302/sh/9b30f520-969f-4ff3-9779-8ef379f04a5b/311daf504414b5376a01f1af5e09db0b

### Use case 2

![service composition]

- Group multiple service chain together as a vpn

[service composition]:https://www.evernote.com/shard/s302/sh/e01a9674-a75f-485e-8906-33476745e527/77f9259f260db6c97aad554a2ec8ef90
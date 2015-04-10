# SDN

## OpenDayLight SDN Controller
from [slide](http://www.slideshare.net/esumit/opendaylight-sdn-controller?next_slideshow=1)
by sumit1234@gmail.com

Detailed installation step is [here](https://wiki.opendaylight.org/view/OpenDaylight_Controller:Installation), a test vm is pre-bulit and can be download [test vm], or from [OpenDaylight Application Developers’ Tutorial](http://sdnhub.org/tutorials/opendaylight/) and speed up the learning.

VM description
[test vm]:https://wiki.opendaylight.org/view/CrossProject:Integration_Group:Test_VMs
* VM disk: Ubuntu 14.04 desktop, 20GB HDD, ova file size=4GB
* Intalled SW:
 
	* Java 1.7 OpenJDK, 
	* OpenDaylight Helium-SR1.1, 
	* POSTMAN plugin with some example collections, 
	* mininet 2.1.0, 
	* Open vSwitch 2.0.2, 
	* CPqD ofsoftswitch13, 
	* Wireshark 1.12.2 with OF1.3 dissectors, 
	* Netopeer Netconf server, 
	* integration test repository, Robot framework 2.8.6, RIDE 1.3,CBench

[The Robot Framework is a generic test automation framework.](https://blog.codecentric.de/en/2012/03/robot-framework-tutorial-overview/)

[RobotFramework-EclipseIDE is an Eclipse IDE plugin for the Robot Framework test automation tool developed by Nitor Creations Oy.](https://github.com/NitorCreations/RobotFramework-EclipseIDE)

## SDNHub 

* [All-in-one SDN App Development Starter VM](http://sdnhub.org/tutorials/sdn-tutorial-vm/) Username and passwd are both “ubuntu”,
* Click the controller you want to learn from this [tutorial](http://sdnhub.org/tutorials/)
* Use [this](http://eatpeppershothot.blogspot.com/2014/11/setting-up-opendaylight-hydrogen-vm.html) to check settings

### ODL

script of [odl tutorial](http://sdnhub.org/tutorials/opendaylight/)

```
ubuntu@sdnhubvm:~[17:57]$ cd SDNHub_Opendaylight_Tutorial && git pull --rebase
Current branch master is up to date.
```

Create a network in mininet,

```
ubuntu@sdnhubvm:~/SDNHub_Opendaylight_Tutorial[17:57] (master)$ sudo mn --topo single,3 --mac --switch ovsk,protocols=OpenFlow13 --controller remote
*** Creating network
*** Adding controller
Unable to contact the remote controller at 127.0.0.1:6633
*** Adding hosts:
h1 h2 h3 
*** Adding switches:
s1 
*** Adding links:
(h1, s1) (h2, s1) (h3, s1) 
*** Configuring hosts
h1 h2 h3 
*** Starting controller
*** Starting 1 switches
s1 
*** Starting CLI:
mininet> 
```

* check wireshark installation,

[CLI help](https://www.wireshark.org/docs/wsug_html_chunked/ChCustCommandLine.html)

We can start wireshark `sudo wireshark &`
Since we have mininet created already, we can select an interface to monitor, e.g. s1
then click start.

In mininet console,

```
mininet> h1 ping h2 -c3
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
From 10.0.0.1 icmp_seq=1 Destination Host Unreachable
From 10.0.0.1 icmp_seq=2 Destination Host Unreachable
From 10.0.0.1 icmp_seq=3 Destination Host Unreachable

--- 10.0.0.2 ping statistics ---
3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2015ms
pipe 3
mininet> 
```
Because there is not flow rule in s1, there is no connectivity between h1 and h2. 
list directory structure before compile,

```
ubuntu@sdnhubvm:~/SDNHub_Opendaylight_Tutorial[21:12] (master)$ ls -la adsal_L2_forwarding/target/classes/org/opendaylight/tutorial/tutorial_L2_forwarding/internal/
total 100
drwxrwxr-x 2 ubuntu  4096 Jan  8 17:15 ./
drwxrwxr-x 3 ubuntu  4096 Jan  8 17:15 ../
-rw-rw-r-- 1 ubuntu  3099 Jan  8 17:15 Activator.class
-rw-rw-r-- 1 ubuntu  9578 Jan  8 17:15 TutorialL2Forwarding.class
-rwxrwxr-x 1 ubuntu  7566 Oct  1 17:37 TutorialL2Forwarding_hub.solution*
-rwxrwxr-x 1 ubuntu  8863 Oct  1 17:37 TutorialL2Forwarding_multiswitch.solution*
-rwxrwxr-x 1 ubuntu  8935 Oct  1 17:37 TutorialL2Forwarding_singleswitch.solution*
-rwxrwxr-x 1 ubuntu  8473 Oct  1 17:37 TutorialL2Forwarding.skeleton*
-rwxrwxr-x 1 ubuntu 15339 Oct  1 17:37 TutorialL2Forwarding_statelesslb.solution*
-rwxrwxr-x 1 ubuntu 15959 Oct  1 17:37 TutorialL2Forwarding_statelesslb.solution2*
ubuntu@sdnhubvm:~/SDNHub_Opendaylight_Tutorial[21:12] (master)$ ls -la adsal_L2_forwarding/src/main/java/org/opendaylight/tutorial/tutorial_L2_forwarding/internal/
total 100
drwxrwxr-x 2 ubuntu  4096 Oct  1 17:37 ./
drwxrwxr-x 3 ubuntu  4096 Oct  1 17:37 ../
-rwxrwxr-x 1 ubuntu  3634 Oct  1 17:37 Activator.java*
-rwxrwxr-x 1 ubuntu  7566 Oct  1 17:37 TutorialL2Forwarding_hub.solution*
-rwxrwxr-x 1 ubuntu  8932 Oct  1 17:37 TutorialL2Forwarding.java*
-rwxrwxr-x 1 ubuntu  8863 Oct  1 17:37 TutorialL2Forwarding_multiswitch.solution*
-rwxrwxr-x 1 ubuntu  8935 Oct  1 17:37 TutorialL2Forwarding_singleswitch.solution*
-rwxrwxr-x 1 ubuntu  8473 Oct  1 17:37 TutorialL2Forwarding.skeleton*
-rwxrwxr-x 1 ubuntu 15339 Oct  1 17:37 TutorialL2Forwarding_statelesslb.solution*
-rwxrwxr-x 1 ubuntu 15959 Oct  1 17:37 TutorialL2Forwarding_statelesslb.solution2*
ubuntu@sdnhubvm:~/SDNHub_Opendaylight_Tutorial[21:14] (master)$ 
```

compile app

```
ubuntu@sdnhubvm:~/SDNHub_Opendaylight_Tutorial[21:20] (master)$ mvn install -nsu
... cut ...
[INFO] ------------------------------------------------------------------------
[INFO] Building tutorial 0.6.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] 
[INFO] --- maven-install-plugin:2.3:install (default-install) @ tutorial ---
[INFO] Installing /home/ubuntu/SDNHub_Opendaylight_Tutorial/pom.xml to /home/ubuntu/.m2/repository/org/sdnhub/odl/tutorial/tutorial/0.6.0-SNAPSHOT/tutorial-0.6.0-SNAPSHOT.pom
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] SDN Hub OpenDaylight tutorial POM ................. SUCCESS [0.217s]
[INFO] L2 forwarding tutorial with AD-SAL OpenFlow plugins  SUCCESS [1.977s]
[INFO] L2 forwarding tutorial with MD-SAL OpenFlow plugins  SUCCESS [0.739s]
[INFO] OpenFlowPlugin and OVSDB plugin exercise .......... SUCCESS [0.882s]
[INFO] OpenDaylight OSGi AD-SAL tutorial Distribution .... SUCCESS [15.340s]
[INFO] OpenDaylight OSGi MD-SAL tutorial Distribution .... SUCCESS [1:18.401s]
[INFO] SDN Hub AD-SAL tutorial project Karaf Features .... SUCCESS [1.050s]
[INFO] SDN Hub MD-SAL tutorial project Karaf Features .... SUCCESS [1.209s]
[INFO] SDN Hub South bound plugin exercise Karaf Features  SUCCESS [0.843s]
[INFO] distribution-karaf ................................ SUCCESS [11.440s]
[INFO] tutorial .......................................... SUCCESS [0.013s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 1:54.115s
[INFO] Finished at: Fri Mar 27 21:20:49 PDT 2015
[INFO] Final Memory: 72M/237M
[INFO] ------------------------------------------------------------------------
ubuntu@sdnhubvm:~/SDNHub_Opendaylight_Tutorial[21:20] (master)$ 
```

```
ubuntu@sdnhubvm:~/SDNHub_Opendaylight_Tutorial[21:28] (master)$ cd distribution/opendaylight-osgi-adsal/target/distribution-osgi-adsal-1.1.0-SNAPSHOT-osgipackage/opendaylight
ubuntu@sdnhubvm:~/SDNHub_Opendaylight_Tutorial/distribution/opendaylight-osgi-adsal/target/distribution-osgi-adsal-1.1.0-SNAPSHOT-osgipackage/opendaylight[21:31] (master)$ ./run.sh
*****************************************************************
JVM maximum memory was not defined. Setting maximum memory to 1G.
To define the maximum memory, specify the -Xmx setting on the
command line. 
        e.g. ./run.sh -Xmx1G
*****************************************************************
osgi> 2015-03-27 21:38:55 PDT [org.apache.catalina.mbeans.GlobalResourcesLifecycleListener] SEVERE org.apache.catalina.mbeans.GlobalResourcesLifecycleListener createMBeans No global naming context defined for server
...cut...
2015-03-27 21:39:03.029 PDT [SwitchHandler-1] WARN  o.o.c.p.o.c.i.EnhancedController - Error parsing buffer using OF1.0 plugin for message : java.nio.DirectByteBuffer[pos=16 lim=16 cap=1048576]
2015-03-27 21:39:03.163 PDT [SwitchHandler-1] INFO  o.o.c.p.o.core.internal.Controller - Switch:127.0.0.1:33791 is connected to the Controller
...cut...
2015-03-28 00:33:57.558 PDT [fileinstall-./plugins] INFO  o.o.t.t.i.TutorialL2Forwarding - Started

osgi> ss tutorial
"Framework is launched."

id	State       Bundle
55	ACTIVE      org.sdnhub.odl.tutorial.adsal_L2_forwarding_0.5.0.SNAPSHOT
osgi> 
```
It indicates osgi bundle is running. 

```
mininet> h1 python -m HTTPServer 80 &
mininet> h2 wget -o - h1
mininet> 
```


In wireshark

![wireshark after run](http://note.io/1EeCtBJ)

If we ping again, it works.

```
mininet> h1 ping h2 -c3
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=41.6 ms
64 bytes from 10.0.0.2: icmp_seq=2 ttl=64 time=4.46 ms
64 bytes from 10.0.0.2: icmp_seq=3 ttl=64 time=3.62 ms

--- 10.0.0.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2005ms
rtt min/avg/max/mdev = 3.623/16.575/41.638/17.725 ms
mininet> 
```

![wireshark records ping](http://note.io/197s6Sv)







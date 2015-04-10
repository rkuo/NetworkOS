# Study Notes of Containet
Docker Networking Meetup, Sriram Natarajan

[video](https://www.youtube.com/watch?v=5op3ZQmsvN8)
[slide](http://www.slideshare.net/snrism/dockerovs-n)
[script](https://bitbucket.org/snrism/containet)

* `git clone https://snrism@bitbucket.org/snrism/containet.git` to get all scripts 
* `cd containet` and `vagrant up` to create two VMs (host1 and host2) with static ip (10.0.0.3 and 10.0.0.4) and share the directory.

## VM 
Vagrantfile:

```
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
# Copy the scripts to your favorite folder and modify the source
# of the synced_folder in the below config to your chosen folder
#  e.g., If you choose "~/myfolder" then modify "~/docker/meetup/" to "~/myfolder"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "host1" do |host1|
     host1.vm.box = "ubuntu/trusty64"
     host1.vm.network "private_network", ip: "10.0.0.3"
     host1.vm.synced_folder File.dirname(__FILE__), "/home/vagrant/meetup/"
  end
  config.vm.define "host2" do |host2|
     host2.vm.box = "ubuntu/trusty64"
     host2.vm.network "private_network", ip: "10.0.0.4"
     host2.vm.synced_folder File.dirname(__FILE__), "/home/vagrant/meetup/"
  end
end
```
### for host1

* login host1 `vagrant ssh host1`
* `sudo bash`
* run `./install.sh` to install 
	* open vswitch
	* bridge-utils
	* docker
* start docker engine

```
# Installation script to run Docker, OVS and Bridge Utils on Ubuntu 14.04
# For lxc-docker.
echo deb http://get.docker.io/ubuntu docker main \
  > /etc/apt/sources.list.d/docker.list
# Add the Docker repo key to your local keychain
apt-key adv \
  --keyserver keyserver.ubuntu.com \
  --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
# Install required packages
apt-get update
apt-get install -q -y openvswitch-switch bridge-utils lxc-docker
# Add Docker Options to pickup the bridge name.
# Default to docker0. if alternate name is used, update the file with that name
echo 'DOCKER_OPTS="--bridge=docker0"' >> /etc/default/docker
# Restart docker
service docker restart
```
**Docker engine is installed and running, no container yet**

#### build basic container with some network utils

* `docker build -t ubuntu config/` to create images from Dockerfile which is stored under /vagrant/config, uses ubuntu as base, then add
	* `iputils-ping` The ping command sends ICMP ECHO_REQUEST packets to a host in order to test if the host is reachable via the network.
	* `net-tools` is a comprehensive set of host monitoring, network scanning, security, administration tools and much more, all with a highly intuitive user interface. 
	* `iperf` While tools to measure network performance. Iperf was orginally developed by NLANR/DAST as a modern alternative for measuring TCP and UDP bandwidth performance. 

```
FROM phusion/baseimage
MAINTAINER Sriram Natarajan 
RUN apt-get update
RUN apt-get install -y iputils-ping net-tools iperf
``` 

```
...cut...
Unpacking iperf (2.0.5-3) ...
Setting up iperf (2.0.5-3) ...
 ---> b5dfc68787e8
Removing intermediate container cea154e1155f
Successfully built b5dfc68787e8
root@vagrant-ubuntu-trusty-64:~/meetup# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
ubuntu              latest              b5dfc68787e8        3 minutes ago       301.7 MB
phusion/baseimage   0.9.16              5a14c1498ff4        10 weeks ago        279.6 MB
phusion/baseimage   latest              5a14c1498ff4        10 weeks ago        279.6 MB
root@vagrant-ubuntu-trusty-64:~/meetup#
```

we set the parameters for host1 `source config/host1_tunrc` 

* `source config/host1_tunrc` is a configuration file for the OVS bridge.
Use [gre tunnel](http://en.wikipedia.org/wiki/Generic_Routing_Encapsulation):
Generic Routing Encapsulation (GRE) is a tunneling protocol developed by Cisco Systems that can encapsulate a wide variety of network layer protocols inside virtual point-to-point links over an Internet Protocol internetwork.

[export in linux](http://how-to.linuxcareer.com/learning-linux-commands-export): 
In general, the export command marks an environment variable to be exported with any newly forked child processes and thus it allows a child process to inherit all marked variables.

[ip subnet](http://stackoverflow.com/questions/707002/ip-subnet-notation):
Before CIDR notation, IPv4 networks were represented using dot-decimal notation for both the address and the subnet mask. Thus, 192.168.100.0/24 would be written as 192.168.100.0/255.255.255.0. 
The /24 means that the routing prefix of the subnet is 24 bits long, which means there's ony 8 bits left for the subnet itself, i.e. 123.218.44.0 to 123.218.44.255

```
#!/bin/bash
# Docker Bridge Configuration
export BRIDGE_NAME='docker0'
# Assign bridge address
export BRIDGE_ADDRESS='172.15.42.1/24'
# Container Addresses
export SUBNET='172.15.42.0/24'
# OpenvSwitch Configuration
export OVS_BRIDGE='br0'
# Configure tunnel interface name
export TUN_IF='gre0'
# Configure tunnel type between two hosts
export TUN_TYPE='gre'
# Remote host address
export REMOTE_IP='10.0.0.4'
```

* `exit` host1 and login host2

![create a container](http://note.io/1BW9bBW)

### for host2

We need to log off host1 and get back to containet directory.

```
vagrant@vagrant-ubuntu-trusty-64:~$ ls
meetup
vagrant@vagrant-ubuntu-trusty-64:~$ vagrant ssh host2
The program 'vagrant' is currently not installed. To run 'vagrant' please ask your administrator to install the package 'vagrant'
vagrant@vagrant-ubuntu-trusty-64:~$ exit
logout
Connection to 127.0.0.1 closed.
➜  containet git:(master) ✗ ls
README.rst                config                    install.sh                tunnel_via_ovs
Vagrantfile               contributors.txt          tunnel_via_docker_and_ovs
➜  containet git:(master) ✗
```
**Repeat steps above for host2**

* login host2 `vagrant ssh host2` (we can have customized VM here, have some package pre-installed)
* `cd meetup`, `sudo bash`
* run `./install.sh` to install docker engine on host2 
* `docker build -t ubuntu config/` to create images (we can have repository for this)
* set the env parameters for host2 `source config/host2_tunrc` 
* `exit` host2

### Experiment 1 - Connect host via OVS (docker bridge + OVS)

```
root@vagrant-ubuntu-trusty-64:~/meetup# cd tunnel_via_docker_and_ovs/
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# ls
iptables.sh  ovs-tunnel-setup.sh  start-container.sh
```

![Docker-OVS experiment 1](http://note.io/1yBVBm0)

* `./ovs-tunnel-setup.sh` to setup gre tunnel, copy steps from script file below for study:
	* Connect docker containers via OpenvSwitch Bridge
	* Deactivate and remove the docker0 bridge
	* Delete the Open vSwitch bridge
	* Add the docker0 bridge
	* Set up the IP for the docker0 bridge
	* Activate the bridge
	* Add the $OVS_BRIDGE Open vSwitch bridge
	* Create the tunnel to the other host and attach it to the $OVS_BRIDGE bridge
	* Add the $OVS_BRIDGE bridge to docker0 bridge
	* Restart docker

script:

```
bash-3.2$ cat ovs-tunnel-setup.sh
#!/bin/bash
# Establish a GRE Tunnel between two hosts to
# connect docker containers via OpenvSwitch Bridge
[ "$REMOTE_IP" ] || {
    echo "'source tunrc' before running this script"
    echo "./ovs-tunnel-setup.sh"
    exit 1
}
# Deactivate and remove the docker0 bridge
DOCKER_BR="$(sudo brctl show)"
for bridge in $DOCKER_BR
do
  if [ $BRIDGE_NAME = $bridge ]; then
    ip link set $BRIDGE_NAME down
    brctl delbr $BRIDGE_NAME
  fi
done
# Delete the Open vSwitch bridge
OVS_BR="$(sudo ovs-vsctl list-br)"
for ovs_br in $OVS_BR
do
  if [ $OVS_BRIDGE = $ovs_br ]; then
    ovs-vsctl del-br $OVS_BRIDGE
  fi
done
# Add the docker0 bridge
# Set up the IP for the docker0 bridge
# Activate the bridge
brctl addbr $BRIDGE_NAME
ip a add $BRIDGE_ADDRESS dev $BRIDGE_NAME
ip link set $BRIDGE_NAME up
# Add the $OVS_BRIDGE Open vSwitch bridge
# Create the tunnel to the other host and attach it to the $OVS_BRIDGE bridge
ovs-vsctl add-br $OVS_BRIDGE
ovs-vsctl add-port $OVS_BRIDGE $TUN_IF -- set interface $TUN_IF type=gre options:remote_ip=$REMOTE_IP
# Add the $OVS_BRIDGE bridge to docker0 bridge
brctl addif $BRIDGE_NAME $OVS_BRIDGE
# Restart docker
service docker restart
bash-3.2$
```

After logoff host1, then re-login host1 later will require more steps: 

#### host1

```
vagrant@vagrant-ubuntu-trusty-64:~$ sudo bash
root@vagrant-ubuntu-trusty-64:~# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
ubuntu              latest              b5dfc68787e8        5 hours ago         301.7 MB
phusion/baseimage   0.9.16              5a14c1498ff4        10 weeks ago        279.6 MB
phusion/baseimage   latest              5a14c1498ff4        10 weeks ago        279.6 MB
root@vagrant-ubuntu-trusty-64:~# cd meetup/
root@vagrant-ubuntu-trusty-64:~/meetup# source config/host1_tunrc
root@vagrant-ubuntu-trusty-64:~/meetup# cd tunnel_via_docker_and_ovs/
```
1. setup tunnel

```
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# ./ovs-tunnel-setup.sh
docker stop/waiting
docker start/running, process 7615
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs#
```

2. `./iptables.sh` to setup required iptables rules for containers to reach external world.

```
#!/bin/bash
# Set iptables rules to connect docker containers
[ "$SUBNET" ] || {
  echo "'source tunrc' before running this script"
  echo "./iptables.sh"
  exit 1
}
# Enable NAT
iptables -t nat -A POSTROUTING -s $SUBNET ! -d $SUBNET -j MASQUERADE
# Accept incoming packets for existing connections
iptables -A FORWARD -o $OVS_BRIDGE -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
# Accept all non-intercontainer outgoing packets
iptables -A FORWARD -i $OVS_BRIDGE ! -o $OVS_BRIDGE -j ACCEPT
# By default allow all outgoing traffic
iptables -A FORWARD -i $OVS_BRIDGE -o $OVS_BRIDGE -j ACCEPT
```

* `docker ps` to record the Container ID that just started

```
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
ubuntu              latest              b5dfc68787e8        7 hours ago         301.7 MB
phusion/baseimage   0.9.16              5a14c1498ff4        10 weeks ago        279.6 MB
phusion/baseimage   latest              5a14c1498ff4        10 weeks ago        279.6 MB
```

3. `docker run -d --net=none -t -i ubuntu /bin/bash` to start a container without using docker's default network config

```
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# docker run -d --net=none -t -i ubuntu /bin/bash
f69cff8266f9fdde23c77454a2205f1fa36b669687f8b7397ebf1043a4e0fad3
```

4. get containerID, `docker ps`

```
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
f69cff8266f9        ubuntu:latest       "/bin/bash"         14 seconds ago      Up 13 seconds                           goofy_newton
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs#
```

5. start container

start-container.sh

```
#!/bin/bash
# Establish a GRE Tunnel between two hosts to
# connect docker containers via OpenvSwitch Bridge
#[ "$2" ] || {
#  echo "./start-container.sh <container-id> <ip-addr>"
#  exit 1
#}
# Identify the pid for the running container
# and create the associated namespace entry
pid=`docker inspect --format '{{ .State.Pid }}' $1`
mkdir -p /var/run/netns
ln -s /proc/$pid/ns/net /var/run/netns/$pid
# Create a pair of peer interfaces
ip link add tap$pid type veth peer name peertap$pid
# Attach peertap$pid inside the container
# Provide a name to the interface
# Set an IP Address to the interface from the private address subnet
# Add default gateway
ip link set peertap$pid netns $pid
ip netns exec $pid ip link set dev peertap$pid name eth0
ip netns exec $pid ip link set eth0 up 
ip netns exec $pid ip addr add "${2}/24" dev eth0
ip netns exec $pid ip route add default via `echo $2 | awk -F '.' '{ print $1 "." $2 "." $3 "." 1 }'`
# Bring up the device
ifconfig tap$pid up
# Add port to the docker bridge
brctl addif $BRIDGE_NAME tap$pid
```

#### host2

* `cd meetup`, `sudo bash` to get privilege
* `docker images` 
* `source config/host2_tunrc`
* `cd tunnel_via_docker_and_ovs/`

1. `./ovs-tunnel-setup.sh`
2. `./iptables.sh` 
3. `docker run -d --net=none -t -i ubuntu /bin/bash`
4. `docker ps` # e1d2cd4f6c1a
5. ./start-container.sh <container-id> 172.15.42.101 # on host 2

```
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
e1d2cd4f6c1a        ubuntu:latest       "/bin/bash"         7 minutes ago       Up 7 minutes                            tender_hypatia
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# ./start-container.sh e1d2cd4f6c1a  172.15.42.101
```

```
vagrant@vagrant-ubuntu-trusty-64:~$ cd meetup/tunnel_via_docker_and_ovs/
vagrant@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs$ l
iptables.sh*  ovs-tunnel-setup.sh*  start-container.sh*
vagrant@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs$ sudo bash
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# ./ovs-tunnel-setup.sh
'source tunrc' before running this script
./ovs-tunnel-setup.sh
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# cd ..
root@vagrant-ubuntu-trusty-64:~/meetup# source config/host2_tunrc
root@vagrant-ubuntu-trusty-64:~/meetup# cd tunnel_via_docker_and_ovs/
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# ./ovs-tunnel-setup.sh
docker stop/waiting
docker start/running, process 6053
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# ./iptables.sh
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# docker run -d --net=none -t -i ubuntu /bin/bash
fce52e2371d4a92e4a2bcf0749a86664c64813885d7a5fa4dcd09523e252f02c
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
fce52e2371d4        ubuntu:latest       "/bin/bash"         25 seconds ago      Up 24 seconds                           furious_stallman
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# ./start-container.sh fce52e2371d4 172.15.42.101
```

ping

```
root@vagrant-ubuntu-trusty-64:~/meetup/tunnel_via_docker_and_ovs# ping 172.15.42.100
PING 172.15.42.100 (172.15.42.100) 56(84) bytes of data.
64 bytes from 172.15.42.100: icmp_seq=1 ttl=64 time=1.50 ms
64 bytes from 172.15.42.100: icmp_seq=2 ttl=64 time=0.684 ms
64 bytes from 172.15.42.100: icmp_seq=3 ttl=64 time=0.626 ms
64 bytes from 172.15.42.100: icmp_seq=4 ttl=64 time=0.604 ms
64 bytes from 172.15.42.100: icmp_seq=5 ttl=64 time=0.609 ms
64 bytes from 172.15.42.100: icmp_seq=6 ttl=64 time=0.627 ms
^C
```

### Experiment 2 - Connect host via OVS (direct OVS)

![Docker-OVS experiment 2](http://note.io/1xZLRap)

### Experiment 3 - Connect host via OVS (direct OVS + vlan)

![Docker-OVS experiment 3](http://note.io/1xZMZuK)









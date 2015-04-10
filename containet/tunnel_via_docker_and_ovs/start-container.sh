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



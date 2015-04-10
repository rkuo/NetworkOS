#!/bin/sh

[ "$2" ] || {
    echo "'source tunrc' before running this script"
    echo "./connect-container.sh <container-pid> <iface-ip-addr> <optional-vlan-tag>"
    exit 1
}

VLANTAG=$3

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
ip netns exec $pid ip link set dev peertap$pid name eth1
ip netns exec $pid ip link set eth1 up
ip netns exec $pid ip addr add "${2}/24" dev eth1
ip netns exec $pid ip route add default via `echo $2 | awk -F '.' '{ print $1 "." $2 "." $3 "." 1 }'`

# Bring up the device
ifconfig tap$pid up

# Add the port to the OVS bridge
if [ "$VLANTAG" ]
then
  ovs-vsctl add-port $OVS_BRIDGE tap$pid tag=$VLANTAG
else
  ovs-vsctl add-port $OVS_BRIDGE tap$pid
fi

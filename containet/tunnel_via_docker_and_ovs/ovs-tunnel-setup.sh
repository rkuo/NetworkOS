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

#!/bin/bash
# Establish a GRE Tunnel between two hosts to
# connect docker containers via OpenvSwitch Bridge

[ "$REMOTE_IP" ] || {
    echo "'source tunrc' before running this script"
    echo "./ovs-tunnel-setup.sh"
    exit 1
}

# Delete the Open vSwitch bridge
OVS_BR="$(sudo ovs-vsctl list-br)"
for ovs_br in $OVS_BR
do
  if [ $OVS_BRIDGE = $ovs_br ]; then
    ovs-vsctl del-br $OVS_BRIDGE
  fi
done

# Add the $OVS_BRIDGE Open vSwitch bridge
# Based on the tunnel type create the tunnel to the other host
# and attach it to the $OVS_BRIDGE bridge
ovs-vsctl add-br $OVS_BRIDGE
ovs-vsctl add-port $OVS_BRIDGE $TUN_IF -- set interface $TUN_IF type=$TUN_TYPE options:remote_ip=$REMOTE_IP

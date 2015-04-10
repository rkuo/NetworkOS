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

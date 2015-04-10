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

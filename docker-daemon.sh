#!/bin/bash

. shared.sh

DIR_DOCKER_EXEC_ROOT=$(pwd)/docker-root/run
DIR_DOCKER_GRAPH_ROOT=$(pwd)/docker-root/graph

DOCKER_NET=172.18.0.1/24
DOCKER_BRIDGE=runvbr0

mkdir -p $DIR_DOCKER_EXEC_ROOT $DIR_DOCKER_GRAPH_ROOT

# Set up bridge network
if ! ip link show $DOCKER_BRIDGE > /dev/null 2>&1
then
   sudo ip link add name $DOCKER_BRIDGE type bridge
   sudo ip addr add $DOCKER_NET dev $bridge
   sudo ip link set dev $DOCKER_BRIDGE up
fi

sudo docker daemon \
    --debug \
    --config-file= \
    --pidfile= \
    --containerd=$CONTAINERD_SOCK \
    --bridge=$DOCKER_BRIDGE \
    --exec-root=$DIR_DOCKER_EXEC_ROOT \
    --graph=$DIR_DOCKER_GRAPH_ROOT \
    --host=$DOCKER_SOCK \
    --storage-driver=vfs

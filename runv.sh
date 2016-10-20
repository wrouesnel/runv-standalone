#!/bin/bash

. shared.sh

RUNV=$GOPATH/src/github.com/hyperhq/runv/runv

DRIVER=kvm
KERNEL=$GOPATH/src/github.com/hyperhq/hyperstart/build/kernel
INITRD=$GOPATH/src/github.com/hyperhq/hyperstart/build/hyper-initrd.img

DIR_RUNV_LOG=$(pwd)/runv/log
DIR_RUNV_STATE=$(pwd)/runv/runv-containerd
DIR_RUNV_CONTAINERD=$(pwd)/runv/runv-containerd
DIR_RUNV_ROOT=$(pwd)/runv/root

mkdir -p $DIR_RUNV_LOG $DIR_RUNV_STATE $DIR_RUNV_CONTAINERD $DIR_RUNV_ROOT

sudo $RUNV --debug \
    --log_dir $DIR_RUNV_LOG \
    --root $DIR_RUNV_ROOT \
    --driver $DRIVER \
    --kernel $KERNEL \
    --initrd $INITRD \
    containerd \
    --state-dir $DIR_RUNV_STATE \
    --containerd-dir $DIR_RUNV_CONTAINERD \
    --listen $CONTAINERD_SOCK

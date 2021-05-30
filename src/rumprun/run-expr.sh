#!/bin/bash

start_domid=$1
iperf_mod=$2

domid_count=0
iperf_mod_arg=""

# 0 bidirection; 1 reverse mode, receiver; other sender(default)
if [ ! -z "$iperf_mod" ]; then
    if [ $iperf_mod -eq 0 ]; then
        iperf_mod_arg="--bidir"
    elif [ $iperf_mod -eq 1 ]; then
        iperf_mod_arg="-R"
    fi
fi

for i in `seq 1 5`;
do
    echo $i
    domid=$(($start_domid+$domid_count))
    echo "iperf_mod_args =" $iperf_mod_arg
    echo "domid =" $domid
    # sudo /home/moslab/Desktop/unikernel/rumprun/rumprun/bin/rumprun xen -I newnet,xenif,bridge=xenbr0,mac=00:16:3b:00:00:00 -W newnet,inet,static,10.32.135.13/16 -M 350 -N  iperf-example-client -- iperf.bin  -V -4 -c 10.32.141.245 -p 5201 $iperf_mod_arg
    sudo /home/moslab/Desktop/unikernel/rumprun/rumprun/bin/rumprun xen -I newnet,xenif,bridge=xenbr0,mac=00:16:3b:00:00:00 -W newnet,inet,static,10.32.135.13/16 -M 350 -N  iperf-example-client -- iperf.bin  -V -4 -c 10.32.135.12 -p 5201 $iperf_mod_arg
    sleep 20
    sudo xl destroy $domid
    sleep 5
    domid_count=$(($domid_count+1))
done

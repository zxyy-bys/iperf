#!/bin/bash

# cd ~/Desktop/gdoc-project/gdoc-proxy-impl/edge_server2/
iperf_mod=$1
cur_dir=$(pwd)
cd ~/Desktop/xen-source/xen3/tools/tests/mem-sharing/
sudo ./memshrtool set_value 0 0
cd ~/Desktop/linux-studying/linux-source/linux-4.4/drivers/net/xen-netback/
sudo ./reinstall_mod.sh
# cd ~/Desktop/node-js-example/
cd "$cur_dir"
sudo xl dmesg --clear > /dev/null
./run-client.sh $iperf_mod


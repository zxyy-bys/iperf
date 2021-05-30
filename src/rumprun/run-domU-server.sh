#!/bin/bash

# cd ~/Desktop/gdoc-project/gdoc-proxy-impl/edge_server2/
server_template_domid=$1
fork_domid=$2

cur_dir=$(pwd)
cd ~/Desktop/xen-source/xen3/tools/tests/mem-sharing/
sudo ./memshrtool set_value 0 0
cd ~/Desktop/linux-studying/linux-source/linux-4.4/drivers/net/xen-netback/
sudo ./reinstall_mod.sh
# cd ~/Desktop/node-js-example/
cd "$cur_dir"
sudo xl dmesg --clear > /dev/null
./run-server.sh

sleep 5

sudo xl create_refer $server_template_domid
sleep 5

sudo xl fork $server_template_domid

sleep 5

cd ~/Desktop/xen-source/xen3/tools/tests/mem-sharing/
sudo ./memshrtool set_value 1 0

sudo xl unpause $fork_domid
sleep 2

sudo xl console $fork_domid

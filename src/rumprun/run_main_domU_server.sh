#! /bin/bash
#$1 first template domain id -- increased by 1 after each workload
#$2 first fork domain id --  increased by 3 after echa worklad
#$3 type 1: print only timestamp 3: print "cow" and "free page"

tdom_index=$1
fdom_index=$2
iperf_mod=$3
experiment_type="cow" #measure cow only
vm_control_value=1
enable_cow_prediction=1

tdom_count=0
fdom_count=0

./run_template_domU.sh $iperf_mod
sleep 10
tdomid=$(($tdom_index+$tdom_count))
./create_template.sh $tdomid
fdomid=$(($fdom_index+$fdom_count))
sleep 10
# start ip address 10.32.135.14
./run_fork_expr.sh $tdomid $fdomid $iperf_mod
sleep 10

sudo xl destroy $tdomid
sleep 2
let tdom_count++
let fdom_count+=5
# sleep 2

tdomid=$(($tdom_index+$tdom_count))
fdomid=$(($fdom_index+$fdom_count))

echo "next fork domid $fdomid, next template domid $tdomid"


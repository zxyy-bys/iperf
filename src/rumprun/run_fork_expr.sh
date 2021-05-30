#! /bin/bash
# $1 template domain id
# $2 first fork domian id
# $3 start ip - 1

template_domid=$1
start_index=$2
iperf_mod=$3
experiment_type="cow"
domid_count=0
vm_control_value=1
enable_cow_prediction=0
iperf_mod_arg="sender-dmesg"

if [ ! -z "$iperf_mod" ]; then
    if [ $iperf_mod -eq 0 ]; then
        iperf_mod_arg="bidirection-dmesg"
    elif [ $iperf_mod -eq 1 ]; then
        iperf_mod_arg="receiver-dmesg"
    fi
fi
output_dir="/home/moslab/Desktop/mem sharing research/evaluation/overall-eva/iperf-eval/iperf-result/$experiment_type"
echo "$output_dir"
mkdir -p "$output_dir"
cd "$output_dir"

# mkdir -p ~/Desktop/mem\ sharing\ research/evaluation/nodejs-raneto/raneto/cow-predict/single-request-wfp/single-request-count-100-2
# cd ~/Desktop/mem\ sharing\ research/evaluation/nodejs-raneto/raneto/cow-predict/single-request-wfp/single-request-count-100-2
mkdir $iperf_mod_arg
cd $iperf_mod_arg
sudo xl dmesg --clear > template

for i in $(seq 1 5);
do
    sudo xl dmesg --clear > /dev/null
    # cd ~/Desktop/gdoc-project/gdoc-proxy-impl/edge_server2/
    echo "[$i]: start fork domain"
    sudo ~/Desktop/xen-source/xen3/tools/tests/mem-sharing/memshrtool set_value $vm_control_value $enable_cow_prediction
    sudo xl fork $1
    sleep 30
    domid=$(($start_index+$domid_count))
    echo "domid = $domid $vm_control_value $enable_cow_prediction"
    sudo xl unpause $domid
    sleep 30
    sudo /home/moslab/Desktop/xen-source/xen3/tools/tests/mem-sharing/memshrtool check_state $domid
    sleep 5
    sudo xl dmesg --clear > run-fork-$i

    sleep 2
    echo "[$i]: destroy fork domain"
    sudo xl destroy $domid
    sleep 5
    let domid_count++
done

sudo /home/moslab/Desktop/xen-source/xen3/tools/tests/mem-sharing/memshrtool set_value 0 0
echo $domid


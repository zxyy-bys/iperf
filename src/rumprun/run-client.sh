# has a problem to run iperf3 as client inside rumprun
# sudo /home/moslab/Desktop/unikernel/rumprun/rumprun/bin/rumprun xen -i -I newnet,xenif,bridge=xenbr0,mac=00:16:3b:00:00:00 -W newnet,inet,static,10.32.135.13/16 -M 350 -N  iperf-example-client -- iperf.bin  -c 10.32.135.12 -p 5201 -R -P 1 --repeating-payload

iperf_mod=$1
iperf_mod_arg=""

if [ ! -z "$iperf_mod" ]; then
    if [ $iperf_mod -eq 0 ]; then
        iperf_mod_arg="--bidir"
    elif [ $iperf_mod -eq 1 ]; then
        iperf_mod_arg="-R"
    fi
fi
# sudo /home/moslab/Desktop/unikernel/rumprun/rumprun/bin/rumprun xen -i -I newnet,xenif,bridge=xenbr0,mac=00:16:3b:00:00:00 -W newnet,inet,static,10.32.135.13/16 -M 350 -N  iperf-example-client -- iperf.bin  -V -4 -c 10.32.141.245 -p 5201 $iperf_mod_arg
sudo /home/moslab/Desktop/unikernel/rumprun/rumprun/bin/rumprun xen -I newnet,xenif,bridge=xenbr0,mac=00:16:3a:00:00:00 -W newnet,inet,static,10.32.135.12/16 -M 350 -N  iperf-example-client -- iperf.bin  -V -4 -c 10.32.141.245 -p 5201 -R


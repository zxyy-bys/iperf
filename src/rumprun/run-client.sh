# has a problem to run iperf3 as client inside rumprun
sudo /home/moslab/Desktop/unikernel/rumprun/rumprun/bin/rumprun xen -i -I newnet,xenif,bridge=xenbr0,mac=00:16:3b:00:00:00 -W newnet,inet,static,10.32.135.13/16 -M 350 -N  iperf-example-client -- iperf.bin -s 10.32.135.12 -p 5201


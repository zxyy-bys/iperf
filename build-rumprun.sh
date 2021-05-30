## confiure options for rumprun, but it still has a problem to compile iperf3-profile
## if error of "sctp_bindx not defined" appears during building,
## rename $RUMPRUN_PATH/rumprun/rumprun-x86_64/include/netinet/sctp.h to another file name(e.g. sctp.h.bak)
## then run this script again
# ./configure --enable-static CC=/home/moslab/Desktop/unikernel/rumprun/rumprun/bin/x86_64-rumprun-netbsd-gcc --host=x86_64-netbsd --without-openssl  --disable-shared

make


~/Desktop/unikernel/rumprun/rumprun/bin/rumprun-bake xen_pv ./src/rumprun/iperf.bin src/iperf3

echo "Running iperf -c inside rumprun is not supported yet!"


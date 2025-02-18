set TESTNAME "$1"
echo TESTNAME
vlog -coveropt 3 +acc +cover ../RTL/* ../TEST/router_pkg.sv ../TOP/router_top.sv +incdir+../RTL +incdir+../ENV +incdir+../TEST
vsim -coverage -vopt router_top -sv_seed 2280232710 +UVM_TESTNAME=$TESTNAME
run 0ns
log -r /uvm_root/*
do wave.do
run -all
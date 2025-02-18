vlib work
vlog -coveropt 3 +acc +cover ../RTL/* ../TEST/router_pkg.sv ../TOP/router_top.sv +incdir+../RTL +incdir+../ENV +incdir+../TEST
vsim -novopt router_top
run 0ns
do wave.do
run -all
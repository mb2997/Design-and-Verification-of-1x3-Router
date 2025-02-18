import os
import sys

TESTNAME=sys.argv[1]
print("TESTNAME=",TESTNAME)

repeat_test_counts = int(input("\nHowmany times you want to run each test in regression?"))
delete_prev_logs = int(input("\nDo you want to delete previous coverage files?\n 1 - YES :::: 2 - NO"))

if (delete_prev_logs == 1) :
    os.system('del *.ucdb')

os.system("vlib work")
os.system("vlog -coveropt 3 +acc +cover ../RTL/* ../TEST/router_pkg.sv ../TOP/router_top.sv +incdir+../RTL +incdir+../ENV +incdir+../TEST")
for i in range(0,repeat_test_counts) :
    os.system('vsim -coverage -novopt router_top -sv_seed random -c -do "coverage save -onexit '+TESTNAME+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TESTNAME)
    if(i == 0) :
        os.system('vcover merge '+TESTNAME+'_mergecov.ucdb '+TESTNAME+'_0.ucdb')
    else :
        os.system('vcover merge '+TESTNAME+'_mergecov.ucdb '+TESTNAME+'_mergecov.ucdb '+TESTNAME+'_'+str(i)+'.ucdb')


os.system('vcover report -details -html '+TESTNAME+'_mergecov.ucdb')
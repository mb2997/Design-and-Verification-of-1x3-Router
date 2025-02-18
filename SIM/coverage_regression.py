import os
import sys

TB="../TOP/router_top.sv"
TBModule="router_top"
PKG="../TEST/router_pkg.sv"
RTL="../RTL/*"

##Testcases List
TC1="router_header_addr_00_test"
TC2="router_header_addr_01_test"
TC3="router_header_addr_10_test"
TC4="router_min_header_len_test"
TC5="router_mid_header_len_test"
TC6="router_max_header_len_test"
TC7="router_min_payload_data_test"
TC8="router_mid_payload_data_test"
TC9="router_max_payload_data_test"
TC10="router_mid_reset_test"
TC11="router_soft_reset_0_test"
TC12="router_soft_reset_1_test"
TC13="router_soft_reset_2_test"

single_test = int(input("\nDo you want to run single test multiple times?\n 1 - YES :::: 0 - NO\n"))
delete_prev_logs = int(input("\nDo you want to delete previous coverage files?\n 1 - YES :::: 0 - NO\n"))

if (delete_prev_logs == 1) :
    os.system('del *.ucdb')

os.system('vlib work')
os.system('vlog -coveropt 3 +acc +cover '+RTL+' '+PKG+' '+TB+' ''+incdir+../RTL +incdir+../ENV +incdir+../TEST')

if(single_test == 0) :
    repeat_test_counts = int(input("\nHowmany times you want to run each test in regression?"))
    for i in range(0,repeat_test_counts) :
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC1+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC1+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC2+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC2+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC3+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC3+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC4+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC4+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC5+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC5+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC6+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC6+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC7+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC7+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC8+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC8+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC9+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC9+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC10+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC10+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC11+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC11+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC12+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC12+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+TC13+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+TC13+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        os.system('vcover merge mergecov_'+str(i)+'.ucdb '+TC1+'_'+str(i)+'.ucdb '+TC2+'_'+str(i)+'.ucdb '+TC3+'_'+str(i)+'.ucdb '+TC4+'_'+str(i)+'.ucdb '+TC5+'_'+str(i)+'.ucdb '+TC6+'_'+str(i)+'.ucdb '+TC7+'_'+str(i)+'.ucdb '+TC8+'_'+str(i)+'.ucdb '+TC9+'_'+str(i)+'.ucdb '+TC10+'_'+str(i)+'.ucdb '+TC11+'_'+str(i)+'.ucdb '+TC12+'_'+str(i)+'.ucdb '+TC13+'_'+str(i)+'.ucdb')
    
        ##add 1st iteration merge coverage to mergecov.ucdb (if part), then merge each iteration coverage with it (else part)
        if(i == 0) :
            os.system('vcover merge mergecov.ucdb mergecov_0.ucdb')
        else :
            os.system('vcover merge mergecov.ucdb mergecov.ucdb mergecov_'+str(i)+'.ucdb')

    os.system('vcover report -details -html mergecov.ucdb')

if(single_test == 1) :
    test_name = input("\nEnter the test name = ")
    repeat_test_counts = int(input("\nHowmany times you want to run the test in regression?"))
    for i in range(0,repeat_test_counts) :
        os.system('vsim -coverage -vopt '+TBModule+' -sv_seed random -c -do "coverage save -onexit '+test_name+'_'+str(i)+'.ucdb; run -all; exit" +UVM_TESTNAME='+test_name+' +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION')
        if(i == 0) :
            os.system('vcover merge mergecov.ucdb '+test_name+'_'+str(i)+'.ucdb')
        else :
            os.system('vcover merge mergecov.ucdb mergecov.ucdb '+test_name+'_'+str(i)+'.ucdb')
    os.system('vcover report -details -html mergecov.ucdb')

    




#Makefile
TB=../TOP/router_top.sv
TBModule=router_top
PKG=../TEST/router_pkg.sv
RTL=../RTL/*

VERBOSITY ?= UVM_MEDIUM

lib :
	vlib work
	
cmp :
	vlog -coveropt 3 +acc +cover $(RTL) $(PKG) $(TB) +incdir+../RTL +incdir+../ENV +incdir+../TEST

sim :
	vsim -coverage -vopt $(TBModule) -c -do "run -all; exit"

all : lib cmp sim

run_tc1 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_header_addr_00_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc2 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_header_addr_01_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc3 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_header_addr_10_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc4 :
	vsim -vopt $(TBModule) -sv_seed 3949019678 -c -do "run -all; exit" +UVM_TESTNAME=router_min_header_len_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc5 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_mid_header_len_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc6 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_max_header_len_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc7 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_min_payload_data_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc8 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_mid_payload_data_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc9 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_max_payload_data_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc10 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_mid_reset_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc11 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_soft_reset_0_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc12 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_soft_reset_1_test +UVM_VERBOSITY=$(VERBOSITY)

run_tc13 :
	vsim -vopt $(TBModule) -sv_seed random -c -do "run -all; exit" +UVM_TESTNAME=router_soft_reset_2_test +UVM_VERBOSITY=$(VERBOSITY)

tc1 : cmp run_tc1

tc2 : cmp run_tc2

tc3 : cmp run_tc3

tc4 : cmp run_tc4

tc5 : cmp run_tc5

tc6 : cmp run_tc6

tc7 : cmp run_tc7

tc8 : cmp run_tc8

tc9 : cmp run_tc9

tc10 : cmp run_tc10

tc11 : cmp run_tc11

tc12 : cmp run_tc12

tc13 : cmp run_tc13

tc1_cov :
	vsim -coverage -vopt $(TBModule) -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_header_addr_00_test

tc2_cov :
	vsim -coverage -vopt $(TBModule) -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_header_addr_01_test

tc3_cov :
	vsim -coverage -vopt $(TBModule) -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_header_addr_10_test

tc4_cov :
	vsim -coverage -vopt $(TBModule) -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_min_header_len_test

tc5_cov :
	vsim -coverage -vopt $(TBModule) -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_mid_header_len_test

tc6_cov :
	vsim -coverage -vopt $(TBModule) -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_max_header_len_test

tc7_cov :
	vsim -coverage -vopt $(TBModule) -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_min_payload_data_test

tc8_cov :
	vsim -coverage -vopt $(TBModule) -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_mid_payload_data_test

tc9_cov :
	vsim -coverage -vopt $(TBModule) -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_max_payload_data_test

tc10_cov :
	vsim -coverage -vopt $(TBModule) +RESET_CLK_CNTS=10 -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_mid_reset_test

tc11_cov :
	vsim -coverage -vopt $(TBModule) +RESET_CLK_CNTS=10 -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_soft_reset_0_test

tc12_cov :
	vsim -coverage -vopt $(TBModule) +RESET_CLK_CNTS=10 -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_soft_reset_1_test

tc13_cov :
	vsim -coverage -vopt $(TBModule) +RESET_CLK_CNTS=10 -sv_seed random -c -do "coverage save -onexit .ucdb; run -all; exit" +UVM_TESTNAME=router_soft_reset_2_test

merge_cov :
	vcover merge mergecov.ucdb fsm_da_to_lfd_state_test_cov.ucdb fsm_da_to_wte_to_lfd_state_test_cov.ucdb fsm_ld_to_ff_to_laf_state_test_cov.ucdb fsm_soft_reset_test_cov.ucdb fsm_ld_to_lp_to_cpe_to_ff_state_test_cov.ucdb fsm_ld_to_ff_to_laf_to_da_state_test_cov.ucdb

merge_report :
	vcover report -details -html mergecov.ucdb 

all_tc : lib cmp tc1 tc2 tc3 tc4 tc5 tc6 tc7 tc8 tc9 tc10 tc11 tc12 tc13

cov_regr : lib cmp tc1_cov tc2_cov tc3_cov tc4_cov tc5_cov tc6_cov merge_cov merge_report

clean :
	del *.ucdb
	del work
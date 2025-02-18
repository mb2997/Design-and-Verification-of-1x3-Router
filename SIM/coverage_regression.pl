use strict;
use warnings;

my $TB = "../TOP/router_top.sv";
my $TBModule = "router_top";
my $PKG = "../TEST/router_pkg.sv";
my $RTL = "../RTL/*";

# Testcases List
my @testcases = (
    "router_header_addr_00_test",
    "router_header_addr_01_test",
    "router_header_addr_10_test",
    "router_min_header_len_test",
    "router_mid_header_len_test",
    "router_max_header_len_test",
    "router_min_payload_data_test",
    "router_mid_payload_data_test",
    "router_max_payload_data_test",
    "router_mid_reset_test",
    "router_soft_reset_0_test",
    "router_soft_reset_1_test",
    "router_soft_reset_2_test"
);

print "\nDo you want to run a single test multiple times?\n 1 - YES :::: 0 - NO\n";
chomp(my $single_test = <STDIN>);

print "\nDo you want to delete previous coverage files?\n 1 - YES :::: 0 - NO\n";
chomp(my $delete_prev_logs = <STDIN>);

if ($delete_prev_logs == 1) {
    system('del *.ucdb wlf* *.wlf');
}

system('vlib work');
system("vlog -coveropt 3 +acc +cover $RTL $PKG $TB +incdir+../RTL +incdir+../ENV +incdir+../TEST");

if ($single_test == 0) {
    print "\nHow many times do you want to run each test in regression?\n";
    chomp(my $repeat_test_counts = <STDIN>);

    for my $i (0 .. $repeat_test_counts - 1) {
        foreach my $testcase (@testcases) {
            system("vsim -coverage -vopt $TBModule -sv_seed random -c -do \"coverage save -onexit ${testcase}_${i}.ucdb; run -all; exit\" +UVM_TESTNAME=$testcase +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION");
        }

        my $merge_files = join(' ', map { "${_}_${i}.ucdb" } @testcases);
        system("vcover merge mergecov_${i}.ucdb $merge_files");

        if ($i == 0) {
            system("vcover merge mergecov.ucdb mergecov_0.ucdb");
        } else {
            system("vcover merge mergecov.ucdb mergecov.ucdb mergecov_${i}.ucdb");
        }
    }

    system("vcover report -details -html mergecov.ucdb");
} elsif ($single_test == 1) {
    print "\nEnter the test name: \n";
    chomp(my $test_name = <STDIN>);

    print "\nHow many times do you want to run the test in regression?\n";
    chomp(my $repeat_test_counts = <STDIN>);

    for my $i (0 .. $repeat_test_counts - 1) {
        system("vsim -coverage -vopt $TBModule -sv_seed random -c -do \"coverage save -onexit ${test_name}_${i}.ucdb; run -all; exit\" +UVM_TESTNAME=$test_name +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION");

        if ($i == 0) {
            system("vcover merge mergecov.ucdb ${test_name}_${i}.ucdb");
        } else {
            system("vcover merge mergecov.ucdb mergecov.ucdb ${test_name}_${i}.ucdb");
        }
    }

    system("vcover report -details -html mergecov.ucdb");
}
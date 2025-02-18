`timescale 1ns/1ps

import router_pkg::*;

module router_top();
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "router_defs.sv"

    logic clk;

    //Disable assertion bits
    bit disable_error_check = 0;
    bit disable_lfd_state_check = 0;
    bit disable_ld_state_check = 0;
    bit disable_laf_state_check = 0;
    bit disable_fifo_0_empty_check = 0;
    bit disable_fifo_1_empty_check = 0;
    bit disable_fifo_2_empty_check = 0;
    bit disable_soft_reset_0_check = 0;
    bit disable_soft_reset_1_check = 0;
    bit disable_soft_reset_2_check = 0;

    router_if inf();
    router_test test_h;

    //Design Instantiation
    router_dut ROUTER_DUT(.clk(inf.clk),
                          .resetn(inf.resetn),
                          .pkt_valid(inf.pkt_valid),
                          .read_enb_0(inf.read_enb_0),
                          .read_enb_1(inf.read_enb_1),
                          .read_enb_2(inf.read_enb_2),
                          .data_in(inf.data_in),
                          .data_out_0(inf.data_out_0),
                          .data_out_1(inf.data_out_1),
                          .data_out_2(inf.data_out_2),
                          .valid_out_0(inf.valid_out_0),
                          .valid_out_1(inf.valid_out_1),
                          .valid_out_2(inf.valid_out_2),
                          .error(inf.error),
                          .busy(inf.busy));

    initial
    begin
        inf.clk = 0;
        forever
        begin
            #(`CLK_PERIOD/2) inf.clk = ~inf.clk;
        end
    end

    initial
    begin
        uvm_config_db#(virtual router_if) :: set(null,"*","vif_top",inf);
        `uvm_info("ROUTER_TOP","uvm_config_db SET from router_top module",UVM_MEDIUM)

        /*
        If you want to run perticular testcase in command-line then we neednot to write anything in argument,
        While running the code in command we have to write +UVM_TESTNAME=testcase_file_name
        e.g. vsim -novopt $(TBModule) -c -do "run -all; exit" +UVM_TESTNAME=ram_low_range_data_tc1 (from make-file)
        */
        run_test("router_test");
    end

    // final
    // begin
    //     foreach(ROUTER_DUT.FIFO_1.fifo_memory[i])
    //         $display("FIFO-1-Memory[%0h] = %0h",i,ROUTER_DUT.FIFO_1.fifo_memory[i]);
    //     foreach(ROUTER_DUT.FIFO_2.fifo_memory[i])
    //         $display("FIFO-2-Memory[%0h] = %0h",i,ROUTER_DUT.FIFO_2.fifo_memory[i]);
    //     foreach(ROUTER_DUT.FIFO_3.fifo_memory[i])
    //         $display("FIFO-3-Memory[%0h] = %0h",i,ROUTER_DUT.FIFO_3.fifo_memory[i]);
    // end

    //Checker for error signal
    property error_check;
        disable iff(!inf.resetn || disable_error_check)
        @(posedge inf.clk) inf.error == 0;
    endproperty : error_check

    assert property (error_check);
    
    //Checker for lfd_state signal
    property lfd_state_check;
        @(posedge inf.clk)
        disable iff(!inf.resetn || disable_lfd_state_check)
        (ROUTER_DUT.FSM.present_state == 'h1 |-> ROUTER_DUT.REGISTER.lfd_state == 1);
    endproperty : lfd_state_check

    assert property (lfd_state_check);

    //Checker for ld_state signal
    property ld_state_check;
        @(posedge inf.clk)
        disable iff(!inf.resetn || disable_ld_state_check)
        (ROUTER_DUT.FSM.present_state == 'h2 |-> ROUTER_DUT.REGISTER.ld_state == 1);
    endproperty : ld_state_check

    assert property (ld_state_check);

    //Checker for laf_state signal
    property laf_state_check;
        @(posedge inf.clk)
        disable iff(!inf.resetn || disable_laf_state_check)
        (ROUTER_DUT.FSM.present_state == 'h5 |-> ROUTER_DUT.REGISTER.laf_state == 1);
    endproperty : laf_state_check

    assert property (laf_state_check);

    //Checker for fifo_empty signal
    property fifo_0_empty_check;
        @(posedge inf.clk)
        disable iff(!inf.resetn || disable_fifo_0_empty_check)
        (ROUTER_DUT.FIFO_1.write_en == 1) |-> ##1 (ROUTER_DUT.FIFO_1.empty == 0);
        //$rose(ROUTER_DUT.FIFO_1.write_en) |-> ##1 $fell(ROUTER_DUT.FIFO_1.empty);
    endproperty : fifo_0_empty_check

    assert property (fifo_0_empty_check);

    //Checker for fifo_empty signal
    property fifo_1_empty_check;
        @(posedge inf.clk)
        disable iff(!inf.resetn || disable_fifo_1_empty_check)
        (ROUTER_DUT.FIFO_2.write_en == 1) |-> ##1 (ROUTER_DUT.FIFO_2.empty == 0);
        //$rose(ROUTER_DUT.FIFO_2.write_en) |-> ##1 $fell(ROUTER_DUT.FIFO_2.empty);
    endproperty : fifo_1_empty_check

    assert property (fifo_1_empty_check);

    //Checker for fifo_empty signal
    property fifo_2_empty_check;
        @(posedge inf.clk)
        disable iff(!inf.resetn || disable_fifo_2_empty_check)
        (ROUTER_DUT.FIFO_3.write_en == 1) |-> ##1 (ROUTER_DUT.FIFO_3.empty == 0);
        //$rose(ROUTER_DUT.FIFO_3.write_en) |-> ##1 $fell(ROUTER_DUT.FIFO_3.empty);
    endproperty : fifo_2_empty_check

    assert property (fifo_2_empty_check);
    
    //Checker for resetn signal
    property reset_check;
        @(posedge inf.clk) $fell(inf.resetn) |=> (inf.data_out_0 == 0 && inf.data_out_1 == 0 && inf.data_out_2 == 0);
    endproperty : reset_check

    assert property (reset_check);
    
    //Checker for soft_reset signal
    property soft_reset_0_check;
        @(posedge inf.clk)
        disable iff(!inf.resetn || disable_soft_reset_0_check)
        $rose(inf.valid_out_0) |-> ##[1:30] $rose(inf.read_enb_0);
    endproperty : soft_reset_0_check

    assert property (soft_reset_0_check);
    
    //Checker for soft_reset signal
    property soft_reset_1_check;
        @(posedge inf.clk)
        disable iff(!inf.resetn || disable_soft_reset_1_check)
        $rose(inf.valid_out_1) |-> ##[1:30] $rose(inf.read_enb_1);
    endproperty : soft_reset_1_check

    assert property (soft_reset_1_check);
    
    //Checker for soft_reset signal
    property soft_reset_2_check;
        @(posedge inf.clk)
        disable iff(!inf.resetn || disable_soft_reset_2_check)
        $rose(inf.valid_out_2) |-> ##[1:30] $rose(inf.read_enb_2);
    endproperty : soft_reset_2_check

    assert property (soft_reset_2_check);


endmodule : router_top
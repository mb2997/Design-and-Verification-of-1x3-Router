`include "router_defs.sv"
`include "router_if.sv"

package router_pkg;

    int no_of_trans = 8;

    virtual router_if vif;

    import uvm_pkg::*;

    `include "uvm_macros.svh"

    `include "router_env_config.sv"
    `include "../ENV/router_wr_agent/router_wr_agent_config.sv"
    `include "../ENV/router_rd_agent/router_rd_agent_config.sv"

    `include "../ENV/router_wr_agent/router_wr_trans.sv"
    `include "../ENV/router_rd_agent/router_rd_trans.sv"
    
    `include "../ENV/router_wr_agent/router_wr_seqs.sv"
    `include "../ENV/router_rd_agent/router_rd_seqs.sv"

    //Testcase sequences files
    `include "/seqs/router_header_addr_00_seqs.sv"
    `include "/seqs/router_header_addr_01_seqs.sv"
    `include "/seqs/router_header_addr_10_seqs.sv"
    `include "/seqs/router_min_header_len_seqs.sv"
    `include "/seqs/router_mid_header_len_seqs.sv"
    `include "/seqs/router_max_header_len_seqs.sv"
    `include "/seqs/router_min_payload_data_seqs.sv"
    `include "/seqs/router_mid_payload_data_seqs.sv"
    `include "/seqs/router_max_payload_data_seqs.sv"
    `include "/seqs/router_mid_reset_seqs.sv"
    `include "/seqs/router_soft_reset_0_seqs.sv"
    `include "/seqs/router_soft_reset_1_seqs.sv"
    `include "/seqs/router_soft_reset_2_seqs.sv"
    
    `include "../ENV/router_wr_agent/router_wr_seqr.sv"
    `include "../ENV/router_rd_agent/router_rd_seqr.sv"
    
    `include "../ENV/router_wr_agent/router_wr_drv.sv"
    `include "../ENV/router_rd_agent/router_rd_drv.sv"
    
    `include "../ENV/router_wr_agent/router_wr_mon.sv"
    `include "../ENV/router_rd_agent/router_rd_mon.sv"
    
    `include "../ENV/router_wr_agent/router_wr_agent.sv"
    `include "../ENV/router_rd_agent/router_rd_agent.sv"
    
    `include "router_sb.sv"
    
    `include "router_env.sv"
    
    `include "/tests/router_test.sv"

    //Testcase files
    `include "/tests/router_header_addr_00_test.sv"
    `include "/tests/router_header_addr_01_test.sv"
    `include "/tests/router_header_addr_10_test.sv"
    `include "/tests/router_min_header_len_test.sv"
    `include "/tests/router_mid_header_len_test.sv"
    `include "/tests/router_max_header_len_test.sv"
    `include "/tests/router_min_payload_data_test.sv"
    `include "/tests/router_mid_payload_data_test.sv"
    `include "/tests/router_max_payload_data_test.sv"
    `include "/tests/router_mid_reset_test.sv"
    `include "/tests/router_soft_reset_0_test.sv"
    `include "/tests/router_soft_reset_1_test.sv"
    `include "/tests/router_soft_reset_2_test.sv"

    function void get_vif_in_pkg();
        if(!uvm_config_db #(virtual router_if) :: get(null," ","vif_top",vif))
            `uvm_fatal("ROUTER_PKG :",$sformatf("Can't able to get router_if... Have you set it ??"))
    endfunction : get_vif_in_pkg

    task wait_for_posedge_clock(int no_of_clocks = 1);
        
        repeat(no_of_clocks)
            @(posedge vif.clk);

    endtask : wait_for_posedge_clock

    task wait_for_negedge_clock(int no_of_clocks = 1);
        
        repeat(no_of_clocks)
            @(negedge vif.clk);

    endtask : wait_for_negedge_clock

    task apply_reset(int no_of_clocks = 1);

        vif.resetn = 0;
        wait_for_posedge_clock(no_of_clocks);
        vif.resetn = 1;

    endtask : apply_reset

    task wait_for_reset_to_be_low();

        wait(vif.resetn == 0);

    endtask : wait_for_reset_to_be_low

    task wait_for_reset_to_be_high();

        wait(vif.resetn == 1);

    endtask : wait_for_reset_to_be_high

endpackage : router_pkg



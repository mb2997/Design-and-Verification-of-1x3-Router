`ifndef ROUTER_WR_AGENT_CONFIG
`define ROUTER_WR_AGENT_CONFIG
`include "router_defs.sv"

class router_wr_agent_config extends uvm_object;

    //Factory registration
    `uvm_object_utils(router_wr_agent_config)

    virtual router_if vif;

    //Function new - constructor
    function new(string name = "router_wr_agent_config");
        super.new(name);
    endfunction
    
    //UVM_ACTIVE and UVM_PASSIVE agent creation selection
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    //Driver sent transaction counts and monitor received data counts
    static int wr_driver_sent_xtn_cnt = 0;
    static int wr_monitor_rcvd_xtn_cnt = 0;

endclass : router_wr_agent_config

`endif
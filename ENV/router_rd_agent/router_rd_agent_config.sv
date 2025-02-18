`ifndef ROUTER_RD_AGENT_CONFIG
`define ROUTER_RD_AGENT_CONFIG

class router_rd_agent_config extends uvm_object;

    //Factory registration
    `uvm_object_utils(router_rd_agent_config)

    virtual router_if vif;

    //Function new - constructor
    function new(string name = "router_rd_agent_config");
        super.new(name);
    endfunction
    
    //UVM_ACTIVE and UVM_PASSIVE agent creation selection
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    //Driver sent transaction counts and monitor received data counts
    static int rd_driver_sent_xtn_cnt = 0;
    static int rd_monitor_rcvd_xtn_cnt = 0;

endclass : router_rd_agent_config

`endif
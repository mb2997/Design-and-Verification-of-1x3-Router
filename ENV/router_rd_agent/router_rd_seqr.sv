`ifndef ROUTER_RD_SEQR
`define ROUTER_RD_SEQR

class router_rd_seqr extends uvm_sequencer#(router_rd_trans);

    //Factory registration
    `uvm_component_utils(router_rd_seqr)

    //New constructor
    function new(string name = "router_rd_seqr", uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass : router_rd_seqr

`endif
`ifndef ROUTER_WR_SEQR
`define ROUTER_WR_SEQR

class router_wr_seqr extends uvm_sequencer#(router_wr_trans);

    //Factory registration
    `uvm_component_utils(router_wr_seqr)

    //New constructor
    function new(string name = "router_wr_seqr", uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass : router_wr_seqr

`endif
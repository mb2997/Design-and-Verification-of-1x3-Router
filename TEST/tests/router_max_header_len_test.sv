`ifndef ROUTER_MAX_HEADER_LEN_TEST
`define ROUTER_MAX_HEADER_LEN_TEST

class router_max_header_len_test extends router_test;

    //Factory registration
    `uvm_component_utils(router_max_header_len_test)

    router_max_header_len_seqs wr_seqs_tc;

    //Function new - constructor
    function new(string name = "router_max_header_len_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    //build_phase
    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        wr_seqs_tc = router_max_header_len_seqs :: type_id :: create("wr_seqs_tc");

    endfunction : build_phase

    task run_phase(uvm_phase phase);
    
        phase.raise_objection(this);
        
        /*
        .start method syntax :
        (sequences_name).start(sequencer_name);
        */
        fork
            wr_seqs_tc.start(env_h.wr_agent_h.wr_seqr_h);   
            rd_seqs_h.start(env_h.rd_agent_h.rd_seqr_h);
        join

        phase.drop_objection(this);

    endtask 

endclass : router_max_header_len_test

`endif
`ifndef ROUTER_SOFT_RESET_1_TEST
`define ROUTER_SOFT_RESET_1_TEST

class router_soft_reset_1_test extends router_test;

    //Factory registration
    `uvm_component_utils(router_soft_reset_1_test)

    router_soft_reset_1_seqs rd_seqs_tc;
    router_header_addr_01_seqs wr_seqs_tc;
    bit soft_reset_0 = 0;

    //Function new - constructor
    function new(string name = "router_soft_reset_1_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    //build_phase
    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        rd_seqs_tc = router_soft_reset_1_seqs :: type_id :: create("rd_seqs_tc");
        wr_seqs_tc = router_header_addr_01_seqs :: type_id :: create("wr_seqs_tc");
        env_config_h.has_scoreboard = 0;

    endfunction : build_phase

    task run_phase(uvm_phase phase);
    
        phase.raise_objection(this);

        /*
        .start method syntax :
        (sequences_name).start(sequencer_name);
        */
        fork
            wr_seqs_tc.start(env_h.wr_agent_h.wr_seqr_h);   
            rd_seqs_tc.start(env_h.rd_agent_h.rd_seqr_h);
        join_any

        phase.drop_objection(this);

    endtask 

endclass : router_soft_reset_1_test

`endif
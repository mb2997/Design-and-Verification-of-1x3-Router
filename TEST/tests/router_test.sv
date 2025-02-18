`ifndef ROUTER_TEST
`define ROUTER_TEST

class router_test extends uvm_test;

    //Factory registration
    `uvm_component_utils(router_test)

    router_wr_seqs wr_seqs_h;
    router_rd_seqs rd_seqs_h;
    router_env env_h;
    //router_config config_h;
    /*
    We have permission to access sequences class from test module
    So, We are taking instance and implement it .start method to drive the sequences in run_phase
    */
    
    router_wr_agent_config wr_agt_config_h;
    router_rd_agent_config rd_agt_config_h;
    router_env_config env_config_h;
    virtual router_if vif;

    //Function new - constructor
    function new(string name = "router_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void set_all_configurations();
        
        rd_agt_config_h.is_active = UVM_ACTIVE;
        wr_agt_config_h.is_active = UVM_ACTIVE;
        env_config_h.has_scoreboard = 1;

    endfunction

    //build_phase
    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        wr_seqs_h = router_wr_seqs :: type_id :: create("wr_seqs_h");
        rd_seqs_h = router_rd_seqs :: type_id :: create("rd_seqs_h");
        env_h = router_env :: type_id :: create("env_h",this);
        wr_agt_config_h = router_wr_agent_config :: type_id :: create("wr_agt_config_h");
        rd_agt_config_h = router_rd_agent_config :: type_id :: create("rd_agt_config_h");
        env_config_h = router_env_config :: type_id :: create("env_config_h");

        if(!uvm_config_db #(virtual router_if) :: get(this," ","vif_top",vif))
            `uvm_fatal("ROUTER_TEST : ", $sformatf("Can't able to get vif... Have you set it ??"))

        //set config data from test.sv file
        uvm_config_db #(router_wr_agent_config) :: set(this,"*","wr_agt_config_h", wr_agt_config_h);
        `uvm_info("ROUTER_TEST :","router_wr_agent_config is set from router_test.sv",UVM_MEDIUM)
        
        uvm_config_db #(router_rd_agent_config) :: set(this,"*","rd_agt_config_h", rd_agt_config_h);
        `uvm_info("ROUTER_TEST :","router_rd_agent_config is set from router_test.sv",UVM_MEDIUM)
        
        uvm_config_db #(router_env_config) :: set(this,"*","router_env_config", env_config_h);
        `uvm_info("ROUTER_TEST :","router_env_config is set from router_test.sv",UVM_MEDIUM)

        get_vif_in_pkg();
        
        set_all_configurations();
        
    endfunction : build_phase

    //end_of_elaboration
    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    /*
    Here we commenting out/remove the run_phase to run the read & write sequence because it will override in testcase file
    */
    
    task run_phase(uvm_phase phase);
    
        phase.raise_objection(this);
        
        /*
        .start method syntax :
        (sequences_name).start(sequencer_name);
        */
        fork
            wr_seqs_h.start(env_h.wr_agent_h.wr_seqr_h);   
            rd_seqs_h.start(env_h.rd_agent_h.rd_seqr_h);
        join

        phase.drop_objection(this);

    endtask 

endclass : router_test

`endif
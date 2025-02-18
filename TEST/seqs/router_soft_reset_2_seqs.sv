`ifndef ROUTER_SOFT_RESET_2_SEQS
`define ROUTER_SOFT_RESET_2_SEQS

class router_soft_reset_2_seqs extends router_rd_seqs;

    //Factory registration
    `uvm_object_utils(router_soft_reset_2_seqs)

    router_env_config env_config_h;

    int reset_clk_counts;
    logic soft_reset_2;
    bit soft_reset_2_q [$];

    //New constructor
    function new(string name = "router_soft_reset_2_seqs");
        super.new(name);
    endfunction

    //BODY
    task body();    
        
        rd_trans_h = router_rd_trans :: type_id :: create("rd_trans_h");

        //Disabling error check assertion
        void'(uvm_hdl_force("router_top.disable_error_check",1));
        void'(uvm_hdl_force("router_top.disable_soft_reset_0_check",1));
        void'(uvm_hdl_force("router_top.disable_soft_reset_1_check",1));
        void'(uvm_hdl_force("router_top.disable_soft_reset_2_check",1));

        fork
            catch_soft_reset_2_val();
        join_none

        repeat(no_of_trans)
        begin
            assert(rd_trans_h.randomize() with {xtn_delay inside {[`MAX_WAIT_FOR_READ_ENB+2 : `MAX_WAIT_FOR_READ_ENB+7]};});
            //assert(rd_trans_h.randomize() with {xtn_delay == 2;});

            //Make a deep-copy of randomized variables in another handle
            $cast(rd_trans_h_clone, rd_trans_h.clone());

            $display("\n--------------------------------- READ TRANSACTION (SOFT_RESET_2) : %0d ---------------------------------\n",trans_no);
            `uvm_info(get_type_name(),$sformatf("Data sent from READ-SEQS to READ-DRIVER = \n%s",rd_trans_h_clone.sprint()),UVM_MEDIUM)
            
            //Send transaction using macro
            `uvm_send(rd_trans_h_clone)
            
            trans_no++;
            
            `uvm_info(get_type_name(),$sformatf("SOFT_RESET_0 QUEUE Array = \n%p",soft_reset_2_q),UVM_MEDIUM)

            if(soft_reset_2_q.size() == 0)
                `uvm_error("TEST_FAIL","SOFT_RESET_2 is not asserted from DUT")
            else
                `uvm_info("TEST_PASS","SOFT_RESET_2 is asserted from DUT",UVM_MEDIUM)

        end

    endtask : body

    task catch_soft_reset_2_val();

        for(int i=1; i>0; i++)
        begin
            void'(uvm_hdl_read("router_top.ROUTER_DUT.SYNCHRONIZER.soft_reset_2",soft_reset_2));
            wait_for_negedge_clock(1);
            if(soft_reset_2 == 1)
            begin
                soft_reset_2_q.push_back(soft_reset_2);
            end
        end
    endtask

endclass : router_soft_reset_2_seqs

`endif
`ifndef ROUTER_MID_RESET_SEQS
`define ROUTER_MID_RESET_SEQS

class router_mid_reset_seqs extends router_wr_seqs;

    //Factory registration
    `uvm_object_utils(router_mid_reset_seqs)

    router_env_config env_config_h;
    int reset_clk_counts;

    //New constructor
    function new(string name = "router_mid_reset_seqs");
        super.new(name);
    endfunction

    //BODY
    task body();    
        
        wr_trans_h = router_wr_trans :: type_id :: create("wr_trans_h");
        env_config_h = router_env_config :: type_id :: create("env_config_h");

        if($value$plusargs("RESET_CLK_CNTS=%0d",reset_clk_counts))
            `uvm_info(get_type_name(),$sformatf("RESET_CLK_CNTS set value is = %0d",reset_clk_counts),UVM_MEDIUM)
        else
            reset_clk_counts = 10;

        repeat(no_of_trans)
        begin
            assert(wr_trans_h.randomize());

            //Make a deep-copy of randomized variables in another handle
            $cast(wr_trans_h_clone, wr_trans_h.clone());

            if(trans_no == no_of_trans/2)
            begin
                apply_reset(6);
                env_config_h.has_scoreboard = 0;
            end
            else
                env_config_h.has_scoreboard = 1;


            $display("\n--------------------------------- WRITE TRANSACTION : %0d ---------------------------------\n",trans_no);
            `uvm_info(get_type_name(),$sformatf("Data sent from WRITE-SEQS to WRITE-DRIVER = \n%s",wr_trans_h_clone.sprint()),UVM_MEDIUM)

            //Send transaction using macro
            `uvm_send(wr_trans_h_clone)
            trans_no++;

            wait_for_posedge_clock(reset_clk_counts);
        end

    endtask : body

endclass : router_mid_reset_seqs

`endif
`ifndef ROUTER_MID_PAYLOAD_DATA_SEQS
`define ROUTER_MID_PAYLOAD_DATA_SEQS

class router_mid_payload_data_seqs extends router_wr_seqs;

    //Factory registration
    `uvm_object_utils(router_mid_payload_data_seqs)

    //New constructor
    function new(string name = "router_mid_payload_data_seqs");
        super.new(name);
    endfunction

    //BODY
    task body();    
        
        wr_trans_h = router_wr_trans :: type_id :: create("wr_trans_h");

        repeat(no_of_trans)
        begin
            assert(wr_trans_h.randomize() with {foreach(payload_data[i]) payload_data[i] inside {[10:250]};});

            //Make a deep-copy of randomized variables in another handle
            $cast(wr_trans_h_clone, wr_trans_h.clone());

            $display("\n--------------------------------- WRITE TRANSACTION (P-DATA = MID) : %0d ---------------------------------\n",trans_no);
            `uvm_info(get_type_name(),$sformatf("Data sent from WRITE-SEQS to WRITE-DRIVER = \n%s",wr_trans_h_clone.sprint()),UVM_MEDIUM)

            //Send transaction using macro
            `uvm_send(wr_trans_h_clone)
            trans_no++;

        end

    endtask : body

endclass : router_mid_payload_data_seqs

`endif
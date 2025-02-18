`ifndef ROUTER_WR_SEQS
`define ROUTER_WR_SEQS

class router_wr_seqs extends uvm_sequence#(router_wr_trans);

    //Factory registration
    `uvm_object_utils(router_wr_seqs)

    //Instantiation
    router_wr_trans wr_trans_h;
    router_wr_trans wr_trans_h_clone;
    int trans_no = 1;

    //New constructor
    function new(string name = "router_wr_seqs");
        super.new(name);
    endfunction

    //BODY
    task body();    
        
        wr_trans_h = router_wr_trans :: type_id :: create("wr_trans_h");

        repeat(no_of_trans)
        begin
            assert(wr_trans_h.randomize());

            //Make a deep-copy of randomized variables in another handle
            $cast(wr_trans_h_clone, wr_trans_h.clone());

            `uvm_info("W_XTN", $sformatf("\n--------------------------------- WRITE TRANSACTION : %0d ---------------------------------\n",trans_no),UVM_MEDIUM);
            `uvm_info(get_type_name(),$sformatf("Data sent from WRITE-SEQS to WRITE-DRIVER = \n%s",wr_trans_h_clone.sprint()),UVM_MEDIUM)

            //Send transaction using macro
            `uvm_send(wr_trans_h_clone)
            trans_no++;
        end

    endtask : body

endclass : router_wr_seqs

`endif
`ifndef ROUTER_RD_SEQS
`define ROUTER_RD_SEQS

class router_rd_seqs extends uvm_sequence#(router_rd_trans);

    //Factory registration
    `uvm_object_utils(router_rd_seqs)

    //Instantiation
    router_rd_trans rd_trans_h;
    router_rd_trans rd_trans_h_clone;
    int trans_no = 1;

    //New constructor
    function new(string name = "router_rd_seqs");
        super.new(name);
    endfunction

    //BODY
    task body();    
        
        rd_trans_h = router_rd_trans :: type_id :: create("rd_trans_h");

        repeat(no_of_trans)
        begin
            assert(rd_trans_h.randomize());

            //Make a deep-copy of randomized variables in another handle
            $cast(rd_trans_h_clone, rd_trans_h.clone());

            `uvm_info("R_XTN",$sformatf("\n--------------------------------- READ TRANSACTION : %0d ---------------------------------\n",trans_no), UVM_MEDIUM);
            `uvm_info(get_type_name(),$sformatf("Data sent from READ-SEQS to READ-DRIVER = \n%s",rd_trans_h_clone.sprint()),UVM_MEDIUM)

            //Send transaction using macro
            `uvm_send(rd_trans_h_clone)
            trans_no++;
        end

    endtask : body

endclass : router_rd_seqs

`endif
`ifndef ROUTER_HEADER_LEN_0_SEQS
`define ROUTER_HEADER_LEN_0_SEQS

class router_header_len_0_seqs extends router_wr_seqs;

    //Factory registration
    `uvm_object_utils(router_header_len_0_seqs)

    //New constructor
    function new(string name = "router_header_len_0_seqs");
        super.new(name);
    endfunction

    //BODY
    task body();    
        
        wr_trans_h = router_wr_trans :: type_id :: create("wr_trans_h");

        repeat(no_of_trans)
        begin
            void'(wr_trans_h.randomize() with {header_len == 0;});

            //Make a deep-copy of randomized variables in another handle
            $cast(wr_trans_h_clone, wr_trans_h.clone());

            `uvm_info(get_type_name(),$sformatf("Data sent from WRITE-SEQS to WRITE-DRIVER = \n%s",wr_trans_h_clone.sprint()),UVM_MEDIUM)

            //Send transaction using macro
            `uvm_send(wr_trans_h_clone)
            trans_no++;

        end

    endtask : body

endclass : router_header_len_0_seqs

`endif
`ifndef ROUTER_WR_TRANS
`define ROUTER_WR_TRANS

class router_wr_trans extends uvm_sequence_item;

    //Declare random variable for transactions
    randc bit [1:0] header_addr;
    rand bit [7:2] header_len;
    rand bit [7:0] payload_data [];
    bit [7:0] header_byte;
    bit [7:0] parity_byte;
    bit [7:0] data_for_cov;

    
    //Variables to store and transfer the value
    //Input signals
    bit resetn;
    bit pkt_valid;
    bit [7:0] data_in;
    // bit valid_out_0;
    // bit valid_out_1;
    // bit valid_out_2;

    

    //constraint for randomization
    constraint HEADER_ADDR_C {header_addr != 2'b11;}       //Invalid ID for 1*3 router
    constraint HEADER_LEN_C {header_len != 0;}       //Header length must not be zero anytime. It won't generate any packet to transfer
    // constraint HEADER_LEN_C {soft header_len > 0 && header_len < 4;}            //Payload data length should not be zero
    //constraint HEADER_LEN_C {soft header_len == 5;}            //Payload data length should not be zero
    constraint PAYLOAD_SIZE_C {payload_data.size() == header_len; solve header_len before payload_data;}
    //constraint READ_ENB_C {({read_enb_0, read_enb_1, read_enb_2} != 3'b111) && ({read_enb_0, read_enb_1, read_enb_2} != 3'b011) && ({read_enb_0, read_enb_1, read_enb_2} != 3'b101);}
    //constraint READ_ENB_C {{read_enb_0, read_enb_1, read_enb_2} == 3'b111;}

    //New constructor
    function new(string name = "router_wr_trans");
        super.new(name);
    endfunction

    //factory registration
    `uvm_object_utils_begin(router_wr_trans)
        `uvm_field_int(header_addr, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(header_len, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(header_byte, UVM_ALL_ON | UVM_HEX)
        `uvm_field_array_int(payload_data, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(parity_byte, UVM_ALL_ON | UVM_HEX)
    `uvm_object_utils_end

    function void post_randomize();
        header_byte = {header_len, header_addr};
        parity_byte = header_byte;
        foreach(payload_data[i])
        begin
            $cast(data_for_cov, payload_data[i]);
            parity_byte = parity_byte ^ payload_data[i];
        end
        `uvm_info("CALCULATED_PARITY_FROM_XTN_CLASS",$sformatf("The value of parity_byte = %0h",parity_byte),UVM_MEDIUM)
    endfunction : post_randomize

endclass : router_wr_trans

`endif
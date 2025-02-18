`ifndef ROUTER_RD_TRANS
`define ROUTER_RD_TRANS

class router_rd_trans extends uvm_sequence_item;
    
    rand int xtn_delay;

    //Declare random variable for transactions
    bit [1:0] header_addr;
    bit [7:2] header_len;
    bit [7:0] header_byte;
    bit [7:0] payload_data [];
    bit [7:0] parity_byte;
    bit read_enb_0;
    bit read_enb_1;
    bit read_enb_2;
    //Output signals
    bit valid_out_0;
    bit valid_out_1;
    bit valid_out_2;
    bit [7:0] data_out_0;
    bit [7:0] data_out_1;
    bit [7:0] data_out_2;
    bit error;
    bit busy;

    //for coverage
    bit [7:0] data_0_for_cov;
    bit [7:0] data_1_for_cov;
    bit [7:0] data_2_for_cov;

    //constraint for randomization
    constraint DELAY_C {soft xtn_delay == 1;}
    //constraint DELAY_C {xtn_delay == 50;}

    //New constructor
    function new(string name = "router_rd_trans");
        super.new(name);
    endfunction

    //factory registration
    `uvm_object_utils_begin(router_rd_trans)
        `uvm_field_int(header_addr, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(header_len, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(header_byte, UVM_ALL_ON | UVM_HEX)
        `uvm_field_array_int(payload_data, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(parity_byte, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(read_enb_0, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(read_enb_1, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(read_enb_2, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(xtn_delay, UVM_ALL_ON | UVM_HEX)
    `uvm_object_utils_end

endclass : router_rd_trans

`endif
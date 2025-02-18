`ifndef ROUTER_IF
`define ROUTER_IF

interface router_if();

    //Input signals
    logic clk;
    logic resetn;
    logic pkt_valid;
    logic read_enb_0;
    logic read_enb_1;
    logic read_enb_2;
    logic [7:0] data_in;

    //Output signals
    logic [7:0] data_out_0;
    logic [7:0] data_out_1;
    logic [7:0] data_out_2;
    logic valid_out_0;
    logic valid_out_1;
    logic valid_out_2;
    logic error;
    logic busy;

endinterface : router_if

//sequence 

`endif
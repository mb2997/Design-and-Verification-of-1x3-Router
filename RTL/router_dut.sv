module router_dut (
    clk,
    resetn,
    pkt_valid,
    read_enb_0,
    read_enb_1,
    read_enb_2,
    data_in,
    data_out_0,
    data_out_1,
    data_out_2,
    valid_out_0,
    valid_out_1,
    valid_out_2,
    error,
    busy
    );

    input clk, resetn, pkt_valid, read_enb_0, read_enb_1, read_enb_2;
    input [7:0] data_in;

    output valid_out_0, valid_out_1, valid_out_2, error, busy;
    output [7:0] data_out_0, data_out_1, data_out_2;

    wire soft_reset_0, soft_reset_1, soft_reset_2;
    wire lfd_state, ld_state, laf_state, detect_addr, write_en_reg, reset_int_reg, parity_done, low_pkt_valid;
    wire full_0, full_1, full_2, fifo_full, full_state;
    wire empty_0, empty_1, empty_2;
    wire [2:0] write_enb;
    wire [7:0] data_out;

    //FIFO instantiation
    fifo FIFO_1 (.clk(clk),
                 .resetn(resetn), 
                 .soft_reset(soft_reset_0),
                 .write_en(write_enb[0]),
                 .read_en(read_enb_0),
                 .lfd_state(lfd_state),
                 .data_in(data_out),
                 .full(full_0),
                 .empty(empty_0),
                 .data_out(data_out_0));

    fifo FIFO_2 (.clk(clk),
                 .resetn(resetn), 
                 .soft_reset(soft_reset_1),
                 .write_en(write_enb[1]),
                 .read_en(read_enb_1),
                 .lfd_state(lfd_state),
                 .data_in(data_out),
                 .full(full_1),
                 .empty(empty_1),
                 .data_out(data_out_1));

    fifo FIFO_3 (.clk(clk),
                 .resetn(resetn), 
                 .soft_reset(soft_reset_2),
                 .write_en(write_enb[2]),
                 .read_en(read_enb_2),
                 .lfd_state(lfd_state),
                 .data_in(data_out),
                 .full(full_2),
                 .empty(empty_2),
                 .data_out(data_out_2));

    synchronizer SYNCHRONIZER (.clk(clk), 
                               .resetn(resetn),
                               .data_in(data_in[1:0]),
                               .detect_addr(detect_addr),
                               .full_0(full_0),
                               .full_1(full_1),
                               .full_2(full_2),
                               .empty_0(empty_0),
                               .empty_1(empty_1),
                               .empty_2(empty_2),
                               .write_en_reg(write_en_reg),
                               .read_enb_0(read_enb_0),
                               .read_enb_1(read_enb_1),
                               .read_enb_2(read_enb_2),
                               .write_enb(write_enb),
                               .fifo_full(fifo_full),
                               .valid_out_0(valid_out_0),
                               .valid_out_1(valid_out_1),
                               .valid_out_2(valid_out_2),
                               .soft_reset_0(soft_reset_0),
                               .soft_reset_1(soft_reset_1),
                               .soft_reset_2(soft_reset_2));

    register REGISTER (.clk(clk), 
                       .resetn(resetn),
                       .pkt_valid(pkt_valid),
                       .data_in(data_in),
                       .fifo_full(fifo_full),
                       .detect_addr(detect_addr),
                       .ld_state(ld_state),
                       .laf_state(laf_state),
                       .full_state(full_state),
                       .lfd_state(lfd_state),
                       .reset_int_reg(reset_int_reg),
                       .error(error),
                       .parity_done(parity_done),
                       .low_pkt_valid(low_pkt_valid),
                       .data_out(data_out));

    fsm FSM (.clk(clk), 
             .resetn(resetn),
             .pkt_valid(pkt_valid),
             .data_in(data_in[1:0]),
             .fifo_full(fifo_full),
             .fifo_empty_0(empty_0),
             .fifo_empty_1(empty_1),
             .fifo_empty_2(empty_2),
             .soft_reset_0(soft_reset_0),
             .soft_reset_1(soft_reset_1),
             .soft_reset_2(soft_reset_2),
             .parity_done(parity_done),
             .low_pkt_valid(low_pkt_valid),
             .write_en_reg(write_en_reg),
             .detect_addr(detect_addr),
             .ld_state(ld_state),
             .laf_state(laf_state),
             .lfd_state(lfd_state),
             .full_state(full_state),
             .reset_int_reg(reset_int_reg),
             .busy(busy));

endmodule : router_dut
module register( 
    clk, 
    resetn,
    pkt_valid,
    data_in,
    fifo_full,
    detect_addr,
    ld_state,
    laf_state,
    full_state,
    lfd_state,
    reset_int_reg,
    error,
    parity_done,
    low_pkt_valid,
    data_out);

    input [7:0] data_in;
    input clk, resetn, pkt_valid, fifo_full, detect_addr, ld_state, laf_state, full_state, lfd_state, reset_int_reg;
    output reg error, parity_done, low_pkt_valid;
    output reg [7:0] data_out;
    reg [7:0] prev_data_in = 'hx;
    
    //Internal variable
    reg [7:0] full_state_byte, internal_parity, packet_parity, header_byte;

    //full_state_byte logic
    always@(posedge clk)
    begin
        if(resetn == 0)
        begin
            full_state_byte <= 0;
        end
        else
        begin
            if(ld_state == 1 && fifo_full == 1)
            begin
                full_state_byte <= data_in;
            end
            else
            begin
                full_state_byte <= full_state_byte;
            end
        end
    end

    //header_byte byte logic
    always@(posedge clk)
    begin
        if(resetn == 0)
        begin
            header_byte <= 0;
        end
        else
        begin
            if(detect_addr == 1 && pkt_valid == 1 && (data_in[1:0] != 2'b11))
            begin
                header_byte <= data_in;
            end
            else
            begin
                header_byte <= header_byte;
            end
        end
    end


/*
    //data_out logic
    always@(posedge clk)
    begin
        if(resetn == 0)
        begin
            data_out <= 0;
        end
        else
        begin
            if(detect_addr == 0)
            begin
                if(lfd_state == 1)
                begin
                    if(ld_state == 0 && fifo_full == 1)
                    begin
                        if(ld_state == 0 && fifo_full == 0)
                        begin
                            if(laf_state == 0)
                            begin
                                data_out <= data_out;
                            end
                            else
                            begin
                                data_out <= full_state_byte;
                            end
                        end
                        else
                        begin
                            data_out <= data_out;
                        end
                    end
                    else
                    begin
                        data_out <= data_in;
                    end
                end
                else
                begin
                    data_out <= header_byte;
                end
            end
            else
            begin
                data_out <= data_out;
            end
        end
    end
    */

    //data_out logic
    always@(posedge clk)
    begin
        if(resetn == 0)
            data_out <= 0;
        else
        begin
            if(lfd_state == 1)
                data_out <= header_byte;
            if(ld_state == 1 && fifo_full == 0)
                data_out <= data_in;
            if(laf_state == 1)
                data_out <= full_state_byte;
        end
    end

    //low_pkt_valid logic
    always@(posedge clk)
    begin
        if(resetn == 0)
        begin
            low_pkt_valid <= 0;
        end
        else
        begin
            if(reset_int_reg == 1)
            begin
                low_pkt_valid <= 0;
            end
            else if(ld_state == 1 && pkt_valid == 0)
            begin
                low_pkt_valid <= 1;
            end
            else
                low_pkt_valid <= low_pkt_valid;
        end
    end

    //parity_done logic
    always@(posedge clk)
    begin
        if(resetn == 0)
        begin
            parity_done <= 0;
        end
        else
        begin
            if(detect_addr == 1)
            begin
                parity_done <= 0;
            end
            else if((ld_state == 1 && fifo_full == 0 && pkt_valid == 0) || (laf_state == 1 && low_pkt_valid == 1 && parity_done == 0))
            begin
                parity_done <= 1;
            end
            else
                parity_done <= parity_done;
        end
    end

    //packet parity
    always@(posedge clk)
    begin
        if(resetn == 0)
        begin
            packet_parity <= 0;
        end
        else if(ld_state == 1 && pkt_valid == 0)
        begin
            packet_parity <= data_in;
        end
        else
            packet_parity <= packet_parity;
    end
/*
    //parity logic
    always@(posedge clk)
    begin
        if(resetn == 0)
            internal_parity <= 0;
        else if(lfd_state == 1)
        begin
            if(prev_data_in !== data_in)
                internal_parity <= header_byte;
            prev_data_in = data_in;
        end
        else if(ld_state == 1 && pkt_valid == 1 && full_state == 0)
        begin
            if(prev_data_in !== data_in)
                internal_parity <= internal_parity ^ data_in;
            else
            begin
                if(detect_addr == 1)
                    internal_parity <= 0;
            end
            prev_data_in = data_in;
        end
    end
*/

    //Internal Parity Logic
    always@(posedge clk)
    begin
        if(resetn)
        begin
            if(detect_addr)
                internal_parity <= 0;
            else if(lfd_state)
                internal_parity <= internal_parity ^ header_byte;
            else if(ld_state && ~full_state && pkt_valid)
                internal_parity <= internal_parity ^ data_in;
        end
    end

    //error calculation
    always@(posedge clk)
    begin
        if(resetn == 0)
        begin
            error <= 0;
        end
        else
        begin
            if(parity_done == 1)
            begin
                if(internal_parity == packet_parity)
                    error <= 0;
                else
                    error <= 1;
            end
            else
                error <= 0;
        end
    end

endmodule : register
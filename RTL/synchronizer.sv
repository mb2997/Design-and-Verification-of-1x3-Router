module synchronizer( 
    clk, 
    resetn,
    data_in,
    detect_addr,
    full_0,
    full_1,
    full_2,
    empty_0,
    empty_1,
    empty_2,
    write_en_reg,
    read_enb_0,
    read_enb_1,
    read_enb_2,
    write_enb,
    fifo_full,
    valid_out_0,
    valid_out_1,
    valid_out_2,
    soft_reset_0,
    soft_reset_1,
    soft_reset_2);

    input [1:0] data_in;
    input clk, resetn, detect_addr, full_0, full_1, full_2, empty_0, empty_1, empty_2, write_en_reg, read_enb_0, read_enb_1, read_enb_2;
    output reg fifo_full, valid_out_0, valid_out_1, valid_out_2, soft_reset_0, soft_reset_1, soft_reset_2;
    output reg [2:0] write_enb;
    reg [1:0] fifo_selection;       //Internal variable for selection between three FIFOs
    reg [4:0] timeout_count_0, timeout_count_1, timeout_count_2;
    
    //fifo_selection value assignment logic
    always@(posedge clk)
    begin
        if(resetn == 0)
            fifo_selection <= 0;
        else if(detect_addr == 1)
            fifo_selection <= data_in;
        else
            fifo_selection <= fifo_selection;
    end

    //fifo_full logic
    //always@(fifo_selection or full_0 or full_1 or full_2)
    always@(*)
    begin
        case(fifo_selection)
            2'b00   :   fifo_full = full_0;
            2'b01   :   fifo_full = full_1;
            2'b10   :   fifo_full = full_2;
            default :   fifo_full = 0;
        endcase
    end

    //write_enb logic
    always@(*)
    begin
        if(write_en_reg == 1)
        begin
            case(fifo_selection)
                2'b00   :   write_enb = 3'b001;
                2'b01   :   write_enb = 3'b010;
                2'b10   :   write_enb = 3'b100;
                default :   write_enb = 3'b000;
            endcase
        end
        else
            write_enb = 3'b000;
    end

    //soft_reset_0 logic
    always@(posedge clk)
    begin
        if(resetn == 0)
            timeout_count_0 <= 0;
        else if(valid_out_0 == 1)
        begin
            if(read_enb_0 !== 1)
            begin
                if(timeout_count_0 == 5'b1_1110)
                begin
                    soft_reset_0 = 1;
                    timeout_count_0 = 0;
                end
                else
                begin
                    timeout_count_0 = timeout_count_0 + 1;
                    soft_reset_0 = 0;
                end
            end
            else
            begin
                soft_reset_0 = 0;
                timeout_count_0 = 0;
            end
        end
        else
        begin
            soft_reset_0 = 0;
            timeout_count_0 = 0;
        end
    end

    //soft_reset_1 logic
    always@(posedge clk)
    begin
        if(resetn == 0)
            timeout_count_1 <= 0;
        else if(valid_out_1 == 1)
        begin
            if(read_enb_1 !== 1)
            begin
                if(timeout_count_1 == 5'b1_1110)
                begin
                    soft_reset_1 <= 1;
                    timeout_count_1 <= 0;
                end
                else
                begin
                    timeout_count_1 <= timeout_count_1 + 1;
                    soft_reset_1 <= 0;
                end
            end
            else
            begin
                timeout_count_1 <= 0;
            end
        end
        else
            timeout_count_1 <= 0;
    end

    //soft_reset_2 logic
    always@(posedge clk)
    begin
        if(resetn == 0)
            timeout_count_2 <= 0;
        else if(valid_out_2 == 1)
        begin
            if(read_enb_2 !== 1)
            begin
                if(timeout_count_2 == 5'b1_1110)
                begin
                    soft_reset_2 <= 1;
                    timeout_count_2 <= 0;
                end
                else
                begin
                    timeout_count_2 <= timeout_count_2 + 1;
                    soft_reset_2 <= 0;
                end
            end
            else
            begin
                timeout_count_2 <= 0;
            end
        end
        else
            timeout_count_2 <= 0;
    end

    //Valid out logic
    assign valid_out_0 = !empty_0;
    assign valid_out_1 = !empty_1;
    assign valid_out_2 = !empty_2;

endmodule : synchronizer
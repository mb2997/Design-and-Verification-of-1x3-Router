`define FIFO_WIDTH 9
`define FIFO_DEPTH 16

module fifo   (clk,
               resetn,
               soft_reset,
               write_en,
               read_en,
               lfd_state,
               data_in,
               full,
               empty,
               data_out);

    input clk, resetn, soft_reset, write_en, read_en, lfd_state;
    input [7:0] data_in;
    output reg full, empty;
    output reg [7:0] data_out;

    //Internal variables
    logic [8:0] fifo_memory [0:15];
    bit [4:0] write_pointer; 
    bit [4:0] read_pointer; 
    bit [4:0] incrementer; 
    bit lfd_temp;
    //bit [4:0] full_empty_check;
    bit [5:0] counter;
    int i;

    //lfd_temp logic
    always@(posedge clk)
    begin
        lfd_temp <= lfd_state;
    end

    //FIFO Memory reset & Data input logic
    always@(posedge clk)
    begin
        if(!resetn || soft_reset)
        begin
            foreach(fifo_memory[i])
            begin
                fifo_memory[i] = 'h0;
            end
        end
        else
        begin
            if(write_en == 1 && full == 0)
            begin
                {fifo_memory[write_pointer[3:0]][8],fifo_memory[write_pointer[3:0]][7:0]} <= {lfd_temp,data_in};
                write_pointer = write_pointer + 1'b1;
            end
        end
    end

    //FIFO Data output logic
    always@(posedge clk)
    begin
        if(!resetn)
        begin
            data_out <= 'hz;
        end
        else if(soft_reset)
        begin
            data_out <= 'hz;
        end
        else
        begin
            if(read_en == 1 && empty == 0)
            begin
                data_out <= fifo_memory[read_pointer[3:0]];
                read_pointer = read_pointer + 1'b1;
            end
            else if((counter == 0) && data_out != 0)
                data_out <= 'hz;
        end
    end

    //pointer logic
    always@(posedge clk)
    begin
        if(!resetn)
        begin
            read_pointer <= 0;
            write_pointer <= 0;
        end
        else 
        begin
            //if(read_en == 1 && empty == 0)
                

            //if(write_en == 1 && full == 0)
                
        end
    end

    //Counter logic
    always@(*)
    begin
        if(fifo_memory[read_pointer][8] && read_en && ~empty)
            counter <= fifo_memory[read_pointer[3:0]][7:2]+1;
    end

    always@(posedge clk)
	begin
        //if(fifo_memory[read_pointer][8] && read_en && ~empty)
            //counter <= fifo_memory[read_pointer][7:2]+1;
        if(read_en && ~empty && counter != 0)
            counter <= counter - 1;
	end

    assign full = ((write_pointer[4] != read_pointer[4]) && (write_pointer[3:0] == read_pointer[3:0]));
    assign empty = (write_pointer == read_pointer);

endmodule : fifo
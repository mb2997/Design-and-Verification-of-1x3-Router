module fsm( clk, 
            resetn,
            pkt_valid,
            data_in,
            fifo_full,
            fifo_empty_0,
            fifo_empty_1,
            fifo_empty_2,
            soft_reset_0,
            soft_reset_1,
            soft_reset_2,
            parity_done,
            low_pkt_valid,
            write_en_reg,
            detect_addr,
            ld_state,
            laf_state,
            lfd_state,
            full_state,
            reset_int_reg,
            busy);

            input [1:0] data_in;
            input clk, resetn, pkt_valid, fifo_full, fifo_empty_0, fifo_empty_1, fifo_empty_2, soft_reset_0, soft_reset_1, soft_reset_2, parity_done, low_pkt_valid;
            output reg write_en_reg, detect_addr, ld_state, laf_state, lfd_state, full_state, reset_int_reg, busy;

            parameter DECODE_ADDRESS     = 3'b000;
            parameter LOAD_FIRST_DATA    = 3'b001;
            parameter LOAD_DATA          = 3'b010;
            parameter LOAD_PARITY        = 3'b011;
            parameter FIFO_FULL_STATE    = 3'b100;
            parameter LOAD_AFTER_FULL    = 3'b101;
            parameter WAIT_TILL_EMPTY    = 3'b110;
            parameter CHECK_PARITY_ERROR = 3'b111;

            reg [2:0] present_state, next_state;

            //Initialize condition or else
            always@(posedge clk)
            begin
                if(!resetn)
                begin
                    //$display("RESETn applied, FSM Moves to the DECODE_ADDRESS State");
                    present_state <= DECODE_ADDRESS;
                end
                else if(soft_reset_0 || soft_reset_1 || soft_reset_2)
                begin
                    //$display("SOFT_RESET applied, FSM Moves to the DECODE_ADDRESS State");
                    present_state <= DECODE_ADDRESS;
                end
                else
                begin
                    present_state <= next_state;
                end
            end

            always@(*)
            begin
                next_state = present_state;
                
                case(present_state)
                DECODE_ADDRESS      :   begin
                                            if((data_in == 2'b00 && pkt_valid == 1 && fifo_empty_0 == 1) || (data_in == 2'b01 && pkt_valid == 1 && fifo_empty_1 == 1) || (data_in == 2'b10 && pkt_valid == 1 && fifo_empty_2 == 1))
                                            begin
                                                next_state <= LOAD_FIRST_DATA;
                                                //$display("FSM Moved from DECODE_ADDRESS to LOAD_FIRST_DATA State");
                                            end
                                            else if((data_in == 2'b00 && pkt_valid == 1 && fifo_empty_0 == 0) || (data_in == 2'b01 && pkt_valid == 1 && fifo_empty_1 == 0) || (data_in == 2'b10 && pkt_valid == 1 && fifo_empty_2 == 0))
                                            begin
                                                next_state <= WAIT_TILL_EMPTY;
                                                //$display("FSM Moved from DECODE_ADDRESS to WAIT_TILL_EMPTY State");
                                            end
                                            else
                                            begin
                                                next_state <= DECODE_ADDRESS;
                                                //$display("FSM is staying at the same state = DECODE_ADDRESS");
                                            end
                                        end
                                        
                LOAD_FIRST_DATA     :   begin
                                            next_state <= LOAD_DATA;
                                            //$display("FSM Moved from LOAD_FIRST_DATA to LOAD_DATA State");
                                        end

                LOAD_DATA           :   begin
                                            if(fifo_full == 1)
                                            begin
                                                next_state <= FIFO_FULL_STATE;
                                                //$display("FSM Moved from LOAD_DATA to FIFO_FULL_STATE State");
                                            end
                                            else if(fifo_full == 0 && pkt_valid == 0)
                                            begin
                                                next_state <= LOAD_PARITY;
                                                //$display("FSM Moved from LOAD_DATA to LOAD_PARITY State");
                                            end
                                            else
                                            begin
                                                next_state <= LOAD_DATA;
                                                //$display("FSM is staying at the same state = LOAD_DATA");
                                            end
                                        end

                LOAD_PARITY         :   begin
                                            next_state <= CHECK_PARITY_ERROR;
                                            //$display("FSM Moved from LOAD_PARITY to CHECK_PARITY_ERROR State");
                                        end

                FIFO_FULL_STATE     :   begin
                                            if(fifo_full == 0)
                                            begin
                                                next_state <= LOAD_AFTER_FULL;
                                                //$display("FSM Moved from FIFO_FULL_STATE to LOAD_AFTER_FULL State");
                                            end
                                            else if(fifo_full == 1)
                                            begin
                                                next_state <= FIFO_FULL_STATE;
                                                //$display("FSM is staying at the same state = FIFO_FULL_STATE");
                                            end
                                        end

                LOAD_AFTER_FULL     :   begin
                                            if(parity_done == 1)
                                            begin
                                                next_state <= DECODE_ADDRESS;
                                                //$display("FSM Moved from LOAD_AFTER_FULL to DECODE_ADDRESS State");
                                            end
                                            else if(low_pkt_valid == 1 && parity_done == 0)
                                            begin
                                                next_state <= LOAD_PARITY;
                                                //$display("FSM Moved from LOAD_AFTER_FULL to LOAD_PARITY State");
                                            end
                                            else if(low_pkt_valid == 0 && parity_done == 0)
                                            begin
                                                next_state <= LOAD_DATA;
                                                //$display("FSM Moved from LOAD_AFTER_FULL to LOAD_DATA State");
                                            end
                                            else
                                            begin
                                                next_state <= LOAD_AFTER_FULL;
                                                //$display("FSM is staying at the same state = LOAD_AFTER_FULL");
                                            end
                                        end

                WAIT_TILL_EMPTY     :   begin
                                            if(fifo_empty_0 == 1 || fifo_empty_1 == 1 || fifo_empty_2 == 1)
                                            begin
                                                next_state <= LOAD_FIRST_DATA;
                                                //$display("FSM Moved from WAIT_TILL_EMPTY to LOAD_FIRST_DATA State");
                                            end
                                            else if(fifo_empty_0 == 0 || fifo_empty_1 == 0 || fifo_empty_2 == 0)
                                            begin
                                                next_state <= WAIT_TILL_EMPTY;
                                                //$display("FSM is staying at the same state = WAIT_TILL_EMPTY");
                                            end
                                        end

                CHECK_PARITY_ERROR  :   begin
                                            if(fifo_full == 1)
                                            begin
                                                next_state <= FIFO_FULL_STATE;
                                                //$display("FSM Moved from CHECK_PARITY_ERROR to FIFO_FULL_STATE State");
                                            end
                                            else if(fifo_full == 0)
                                            begin
                                                next_state <= DECODE_ADDRESS;
                                                //$display("FSM Moved from CHECK_PARITY_ERROR to DECODE_ADDRESS State");
                                            end
                                            else
                                            begin
                                                next_state <= CHECK_PARITY_ERROR;
                                                //$display("FSM is staying at the same state = CHECK_PARITY_ERROR");
                                            end
                                        end

                default             :   begin
                                            next_state <= DECODE_ADDRESS;
                                            //$display("FSM is staying at the same state = DEFAULT");
                                        end
                endcase 
            end

            assign detect_addr      = (present_state == DECODE_ADDRESS);
            assign lfd_state        = (present_state == LOAD_FIRST_DATA);
            assign busy             = (present_state == LOAD_FIRST_DATA || present_state == LOAD_PARITY ||  present_state == FIFO_FULL_STATE || present_state == LOAD_AFTER_FULL || present_state == WAIT_TILL_EMPTY || present_state == CHECK_PARITY_ERROR);
            assign ld_state         = (present_state == LOAD_DATA);
            assign write_en_reg     = (present_state == LOAD_DATA || present_state == LOAD_PARITY || present_state == LOAD_AFTER_FULL);
            assign full_state       = (present_state == FIFO_FULL_STATE);
            assign laf_state        = (present_state == LOAD_AFTER_FULL);
            assign reset_int_reg    = (present_state == CHECK_PARITY_ERROR);

endmodule : fsm
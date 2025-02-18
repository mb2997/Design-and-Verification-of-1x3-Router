`ifndef ROUTER_SB
`define ROUTER_SB

class router_sb extends uvm_scoreboard;

    //Factory registration
    `uvm_component_utils(router_sb)

    //analysis fifo declaration
    uvm_tlm_analysis_fifo #(router_wr_trans) write_analysis_fifo;
    uvm_tlm_analysis_fifo #(router_rd_trans) read_analysis_fifo_0;
    uvm_tlm_analysis_fifo #(router_rd_trans) read_analysis_fifo_1;
    uvm_tlm_analysis_fifo #(router_rd_trans) read_analysis_fifo_2;

    //Taking handles of ram_wtrans and ram_rtrans for collection of data from wmon and rmon analysis interface
    router_wr_trans wr_trans_h;
    router_rd_trans rd_trans_h0;
    router_rd_trans rd_trans_h1;
    router_rd_trans rd_trans_h2;
    virtual router_if vif;

    router_env_config env_config_h;

    // covergroup data_bytes_cvg();

    //     coverpoint wr_trans_h.payload_data {
    //         foreach(wr_trans_h.payload_data[i])
    //                         {
    //                             bins DATA_IN_LOW1   =   {[1:15]};
    //                             bins DATA_IN_LOW2   =   {[16:30]};
    //                             bins DATA_IN_LOW3   =   {[31:45]};
    //                             bins DATA_IN_LOW4   =   {[46:60]};
    //                             bins DATA_IN_LOW5   =   {[61:75]};
    //                             bins DATA_IN_LOW6   =   {[76:90]};
    //                             bins DATA_IN_MED1   =   {[91:105]};
    //                             bins DATA_IN_MED2   =   {[105:120]};
    //                             bins DATA_IN_MED3   =   {[121:135]};
    //                             bins DATA_IN_MED4   =   {[136:150]};
    //                             bins DATA_IN_MED5   =   {[151:165]};
    //                             bins DATA_IN_MED6   =   {[166:175]};
    //                             bins DATA_IN_HIGH1  =   {[176:190]};
    //                             bins DATA_IN_HIGH2  =   {[191:205]};
    //                             bins DATA_IN_HIGH3  =   {[206:220]};
    //                             bins DATA_IN_HIGH4  =   {[221:235]};
    //                             bins DATA_IN_HIGH5  =   {[236:250]};
    //                             bins DATA_IN_HIGH6  =   {[251:255]};
    //                         }
    //                     }


    // endgroup: data_bytes_cvg

    //Functional coverage
    covergroup cvg_router @(posedge vif.clk);

        RESET           :   coverpoint vif.resetn;

        PACKET_VALID    :   coverpoint vif.pkt_valid;
                            
        READ_ENB_0      :   coverpoint vif.read_enb_0;

        READ_ENB_1      :   coverpoint vif.read_enb_1;

        READ_ENB_2      :   coverpoint vif.read_enb_2;

        INPUT_DATA      :   coverpoint vif.data_in
                            {
                                bins DATA_IN_LOW1   =   {[1:15]};
                                bins DATA_IN_LOW2   =   {[16:30]};
                                bins DATA_IN_LOW3   =   {[31:45]};
                                bins DATA_IN_LOW4   =   {[46:60]};
                                bins DATA_IN_LOW5   =   {[61:75]};
                                bins DATA_IN_LOW6   =   {[76:90]};
                                bins DATA_IN_MED1   =   {[91:105]};
                                bins DATA_IN_MED2   =   {[105:120]};
                                bins DATA_IN_MED3   =   {[121:135]};
                                bins DATA_IN_MED4   =   {[136:150]};
                                bins DATA_IN_MED5   =   {[151:165]};
                                bins DATA_IN_MED6   =   {[166:175]};
                                bins DATA_IN_HIGH1  =   {[176:190]};
                                bins DATA_IN_HIGH2  =   {[191:205]};
                                bins DATA_IN_HIGH3  =   {[206:220]};
                                bins DATA_IN_HIGH4  =   {[221:235]};
                                bins DATA_IN_HIGH5  =   {[236:250]};
                                bins DATA_IN_HIGH6  =   {[251:255]};
                            }

        OUTPUT_DATA_0   :   coverpoint vif.data_out_0
                            {
                                bins DATA_OUT_0_LOW1   =   {[1:15]};
                                bins DATA_OUT_0_LOW2   =   {[16:30]};
                                bins DATA_OUT_0_LOW3   =   {[31:45]};
                                bins DATA_OUT_0_LOW4   =   {[46:60]};
                                bins DATA_OUT_0_LOW5   =   {[61:75]};
                                bins DATA_OUT_0_LOW6   =   {[76:90]};
                                bins DATA_OUT_0_MED1   =   {[91:105]};
                                bins DATA_OUT_0_MED2   =   {[105:120]};
                                bins DATA_OUT_0_MED3   =   {[121:135]};
                                bins DATA_OUT_0_MED4   =   {[136:150]};
                                bins DATA_OUT_0_MED5   =   {[151:165]};
                                bins DATA_OUT_0_MED6   =   {[166:175]};
                                bins DATA_OUT_0_HIGH1  =   {[176:190]};
                                bins DATA_OUT_0_HIGH2  =   {[191:205]};
                                bins DATA_OUT_0_HIGH3  =   {[206:220]};
                                bins DATA_OUT_0_HIGH4  =   {[221:235]};
                                bins DATA_OUT_0_HIGH5  =   {[236:250]};
                                bins DATA_OUT_0_HIGH6  =   {[251:255]};
                            }

        OUTPUT_DATA_1   :   coverpoint vif.data_out_1
                            {
                                bins DATA_OUT_1_LOW1   =   {[1:15]};
                                bins DATA_OUT_1_LOW2   =   {[16:30]};
                                bins DATA_OUT_1_LOW3   =   {[31:45]};
                                bins DATA_OUT_1_LOW4   =   {[46:60]};
                                bins DATA_OUT_1_LOW5   =   {[61:75]};
                                bins DATA_OUT_1_LOW6   =   {[76:90]};
                                bins DATA_OUT_1_MED1   =   {[91:105]};
                                bins DATA_OUT_1_MED2   =   {[105:120]};
                                bins DATA_OUT_1_MED3   =   {[121:135]};
                                bins DATA_OUT_1_MED4   =   {[136:150]};
                                bins DATA_OUT_1_MED5   =   {[151:165]};
                                bins DATA_OUT_1_MED6   =   {[166:175]};
                                bins DATA_OUT_1_HIGH1  =   {[176:190]};
                                bins DATA_OUT_1_HIGH2  =   {[191:205]};
                                bins DATA_OUT_1_HIGH3  =   {[206:220]};
                                bins DATA_OUT_1_HIGH4  =   {[221:235]};
                                bins DATA_OUT_1_HIGH5  =   {[236:250]};
                                bins DATA_OUT_1_HIGH6  =   {[251:255]};
                            }

        OUTPUT_DATA_2   :   coverpoint vif.data_out_2
                            {
                                bins DATA_OUT_2_LOW1   =   {[1:15]};
                                bins DATA_OUT_2_LOW2   =   {[16:30]};
                                bins DATA_OUT_2_LOW3   =   {[31:45]};
                                bins DATA_OUT_2_LOW4   =   {[46:60]};
                                bins DATA_OUT_2_LOW5   =   {[61:75]};
                                bins DATA_OUT_2_LOW6   =   {[76:90]};
                                bins DATA_OUT_2_MED1   =   {[91:105]};
                                bins DATA_OUT_2_MED2   =   {[105:120]};
                                bins DATA_OUT_2_MED3   =   {[121:135]};
                                bins DATA_OUT_2_MED4   =   {[136:150]};
                                bins DATA_OUT_2_MED5   =   {[151:165]};
                                bins DATA_OUT_2_MED6   =   {[166:175]};
                                bins DATA_OUT_2_HIGH1  =   {[176:190]};
                                bins DATA_OUT_2_HIGH2  =   {[191:205]};
                                bins DATA_OUT_2_HIGH3  =   {[206:220]};
                                bins DATA_OUT_2_HIGH4  =   {[221:235]};
                                bins DATA_OUT_2_HIGH5  =   {[236:250]};
                                bins DATA_OUT_2_HIGH6  =   {[251:255]};
                            }
                         
        VALID_OUT_0     :   coverpoint vif.valid_out_0;
                
        VALID_OUT_1     :   coverpoint vif.valid_out_1;
                
        VALID_OUT_2     :   coverpoint vif.valid_out_2;

        BUSY            :   coverpoint vif.busy;

        ERROR           :   coverpoint vif.error;
        
        PACKET_VALIDxINPUT_DATA     :   cross PACKET_VALID, INPUT_DATA
                                        {
                                            bins PACKET_VALID_HIGH = binsof(PACKET_VALID) intersect {1};
                                        }

        OUTPUT_DATA_0xVALID_OUT_0   :   cross OUTPUT_DATA_0, VALID_OUT_0
                                        {
                                            ignore_bins IGNORE_VALID_0_LOW = binsof(VALID_OUT_0) intersect {0};
                                        }

        OUTPUT_DATA_1xVALID_OUT_1   :   cross OUTPUT_DATA_1, VALID_OUT_1
                                        {
                                            ignore_bins IGNORE_VALID_1_LOW = binsof(VALID_OUT_1) intersect {0};
                                        }
        
        OUTPUT_DATA_2xVALID_OUT_2   :   cross OUTPUT_DATA_2, VALID_OUT_2
                                        {
                                            ignore_bins IGNORE_VALID_2_LOW = binsof(VALID_OUT_2) intersect {0};
                                        }

        OUTPUT_DATA_0xREAD_ENB_0    :   cross OUTPUT_DATA_0, READ_ENB_0
                                        {
                                            ignore_bins READ_ENB_0_LOW = binsof(READ_ENB_0) intersect {0};
                                        }

        OUTPUT_DATA_1xREAD_ENB_1    :   cross OUTPUT_DATA_1, READ_ENB_1
                                        {
                                            ignore_bins READ_ENB_1_LOW = binsof(READ_ENB_1) intersect {0};
                                        }

        OUTPUT_DATA_2xREAD_ENB_2    :   cross OUTPUT_DATA_2, READ_ENB_2
                                        {
                                            ignore_bins READ_ENB_2_LOW = binsof(READ_ENB_2) intersect {0};
                                        }

    endgroup : cvg_router
    
    //Function new - constructor
    function new(string name = "fsm_sb", uvm_component parent = null);
        super.new(name, parent);
        write_analysis_fifo = new("write_analysis_fifo",this);
        read_analysis_fifo_0 = new("read_analysis_fifo_0",this);
        read_analysis_fifo_1 = new("read_analysis_fifo_1",this);
        read_analysis_fifo_2 = new("read_analysis_fifo_2",this);
        if(!uvm_config_db #(virtual router_if) :: get(this," ","vif_top",vif))
            `uvm_fatal("ROUTER_SB:", $sformatf("Can't able to get vif... Have you set it ??"))
        cvg_router = new();
        // data_bytes_cvg = new();
    endfunction

    function void build_phase(uvm_phase phase);

        env_config_h = router_env_config :: type_id :: create("env_config_h");
        if(!uvm_config_db #(virtual router_if) :: get(this," ","vif_top",vif))
            `uvm_fatal("ROUTER_SB:", $sformatf("Can't able to get vif... Have you set it ??"))
        
        if(!uvm_config_db #(router_env_config) :: get(this," ","router_env_config",env_config_h))
            `uvm_fatal("ROUTER_SB:", $sformatf("Can't able to get router_env_config... Have you set it ??"))

    endfunction : build_phase

    task sb_sampling();
        @(posedge vif.clk);
        cvg_router.sample();
    endtask: sb_sampling

    task run_phase(uvm_phase phase);
        if(env_config_h.has_scoreboard == 1)
        begin
            wr_trans_h = router_wr_trans :: type_id :: create("wr_trans_h");
            rd_trans_h0 = router_rd_trans :: type_id :: create("rd_trans_h0");
            rd_trans_h1 = router_rd_trans :: type_id :: create("rd_trans_h1");
            rd_trans_h2 = router_rd_trans :: type_id :: create("rd_trans_h2");
            // fork
            //     sb_sampling();
            // join_none
            forever
            begin
                data_from_write_monitor();
                data_from_read_monitor();
                // data_bytes_cvg.sample();
            end
        end
    endtask : run_phase

    task data_from_write_monitor();

        write_analysis_fifo.get(wr_trans_h);
        `uvm_info(get_type_name(),$sformatf("Data Received at SCOREBOARD from WRITE-MONITOR is = \n%s",wr_trans_h.sprint()),UVM_NONE)
        env_config_h.total_no_of_trans++;
        env_config_h.total_no_of_write_trans++;

    endtask : data_from_write_monitor

    task data_from_read_monitor();

        if(wr_trans_h.header_byte[1:0] == 2'b00)
        begin
            read_analysis_fifo_0.get(rd_trans_h0);
            `uvm_info(get_type_name(),$sformatf("Data Received at SCOREBOARD from READ-MONITOR is : \nrd_trans_h0 = \n%s",rd_trans_h0.sprint()),UVM_NONE)
            check_and_compare(wr_trans_h, rd_trans_h0);
            env_config_h.total_no_of_read_trans++;
        end
        else if(wr_trans_h.header_byte[1:0] == 2'b01)
        begin
            read_analysis_fifo_1.get(rd_trans_h1);
            `uvm_info(get_type_name(),$sformatf("Data Received at SCOREBOARD from READ-MONITOR is : \nrd_trans_h1 = \n%s",rd_trans_h1.sprint()),UVM_NONE)
            check_and_compare(wr_trans_h, rd_trans_h1);
            env_config_h.total_no_of_read_trans++;
        end
        else if(wr_trans_h.header_byte[1:0] == 2'b10)
        begin
            read_analysis_fifo_2.get(rd_trans_h2);
            `uvm_info(get_type_name(),$sformatf("Data Received at SCOREBOARD from READ-MONITOR is : \nrd_trans_h2 = \n%s",rd_trans_h2.sprint()),UVM_NONE)
            check_and_compare(wr_trans_h, rd_trans_h2);
            env_config_h.total_no_of_read_trans++;
        end

    endtask : data_from_read_monitor

    task check_and_compare(router_wr_trans write_trans, router_rd_trans read_trans);

        `uvm_info("*","\n***************************************************************************************************************************\n                                               PACKET COMPARISION START                                                    ***************************************************************************************************************************\n",UVM_MEDIUM);

        //Compare header bytes
        if(write_trans.header_byte == read_trans.header_byte)
        begin
            `uvm_info("HEADER_MATCHED",$sformatf("Header Byte Matched Successfully \n \n Write Header : %0h\t == \tRead Header : %0h \n",write_trans.header_byte, read_trans.header_byte),UVM_MEDIUM)
            if(write_trans.payload_data.size() != read_trans.payload_data.size())
                `uvm_error("PAYLOAD_LENGTH_MIS-MATCHED",$sformatf("Payload Length Mis-Matched \n \n Write Length : %0h\t != \tRead Length : %0h \n",write_trans.payload_data.size(), read_trans.payload_data.size()))
            else
            begin
                `uvm_info("PAYLOAD_LENGTH_MATCHED",$sformatf("Payload Length Matched Successfully\n \n Write Length : %0h\t == \tRead Length : %0h \n",write_trans.payload_data.size(), read_trans.payload_data.size()),UVM_MEDIUM)
                for(int i=0; i<$size(write_trans.payload_data); i++)
                begin
                    if(write_trans.payload_data[i] == read_trans.payload_data[i])
                        `uvm_info("PAYLOAD_DATA_MATCHED",$sformatf("Payload Data[%0d] Matched Successfully \n \n Write Data : %0h\t == \tRead Data : %0h \n", i, write_trans.payload_data[i], read_trans.payload_data[i]),UVM_MEDIUM)
                    else
                        `uvm_info("PAYLOAD_DATA_MIS-MATCHED",$sformatf("Payload Data[%0d] Mis-Matched \n \n Write Data : %0h\t != \tRead Data : %0h \n", i, write_trans.payload_data[i], read_trans.payload_data[i]),UVM_MEDIUM)
                end
            end
            if(write_trans.parity_byte == read_trans.parity_byte)
            begin
                `uvm_info("PARITY_BYTE_MATCHED",$sformatf("Parity Byte Matched Successfully \n \n Write Parity : %0h\t == \tRead Parity : %0h \n",write_trans.parity_byte, read_trans.parity_byte),UVM_MEDIUM)
                env_config_h.total_no_of_good_packets++;
            end
            else
            begin
                `uvm_error("PARITY_BYTE_MIS-MATCHED",$sformatf("Parity Byte Mis-Matched \n \n Write Parity : %0h\t != \tRead Parity : %0h \n",write_trans.parity_byte, read_trans.parity_byte))
                env_config_h.total_no_of_bad_packets++;
            end
        end
        else
            `uvm_error("HEADER_MIS-MATCHED",$sformatf("Header Byte Mis-Matched \n \n Write Header : %0h\t != \tRead Header : %0h \n",write_trans.header_byte, read_trans.header_byte))

        `uvm_info("*","\n***************************************************************************************************************************\n                                               PACKET COMPARISION END                                                    ***************************************************************************************************************************\n",UVM_MEDIUM);

    endtask : check_and_compare

    function void report_phase(uvm_phase phase);
        $display("-----------------------------------------------------------------------------------------------------------------------");
        $display("                                                 SIMULATION SUMMARY                                                    ");
        $display("-----------------------------------------------------------------------------------------------------------------------");
        $display("\n\t\t\t\t TOTAL NUMBER OF PACKET TRANSACTIONS\t : \t%0d\t\t\t\t\t|\n",env_config_h.total_no_of_trans);
        $display("\t\t\t\t TOTAL NUMBER OF WRITE PACKETS\t\t : \t%0d\t\t\t\t\t|\n",env_config_h.total_no_of_write_trans);
        $display("\t\t\t\t TOTAL NUMBER OF READ PACKETS\t\t : \t%0d\t\t\t\t\t|\n",env_config_h.total_no_of_read_trans);
        $display("\t\t\t\t TOTAL NUMBER OF GOOD PACKETS\t\t : \t%0d\t\t\t\t\t|\n",env_config_h.total_no_of_good_packets);
        $display("\t\t\t\t TOTAL NUMBER OF BAD PACKETS\t\t : \t%0d\t\t\t\t\t|\n",env_config_h.total_no_of_bad_packets);
        $display("-----------------------------------------------------------------------------------------------------------------------");
        $display("          NOTE : Scoreboard should be enabled from environment config to update counts in Simulation Summary          |");
        $display("-----------------------------------------------------------------------------------------------------------------------");

    endfunction

endclass : router_sb

`endif
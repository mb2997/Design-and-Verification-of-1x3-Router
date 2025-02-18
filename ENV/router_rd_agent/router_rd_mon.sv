`ifndef ROUTER_RD_MON
`define ROUTER_RD_MON

class router_rd_mon extends uvm_monitor;

    //Factory registration
    `uvm_component_utils(router_rd_mon)

    router_rd_trans rd_trans_h;         //Temp
    router_rd_trans rd_trans_h0;
    router_rd_trans rd_trans_h1;
    router_rd_trans rd_trans_h2;
    router_rd_agent_config rd_agt_config_h;

    virtual router_if vif;
    bit [7:0] header_byte;
    bit [7:0] payload_data_wave;
    bit [7:0] parity_data_wave;
    static int size;

    //Analysis port for SB
    uvm_analysis_port #(router_rd_trans) read_analysis_port_0;
    uvm_analysis_port #(router_rd_trans) read_analysis_port_1;
    uvm_analysis_port #(router_rd_trans) read_analysis_port_2;

    //Function new - constructor
    function new(string name = "router_mon", uvm_component parent = null);
        super.new(name, parent);
        read_analysis_port_0 = new("read_analysis_port_0",this);
        read_analysis_port_1 = new("read_analysis_port_1",this);
        read_analysis_port_2 = new("read_analysis_port_2",this);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        if(!uvm_config_db #(router_rd_agent_config) :: get(this," ","rd_agt_config_h",rd_agt_config_h))
            `uvm_fatal("ROUTER_READ_MONITOR :","Can't able to get router_rd_agent_config... Have you set it ??")

    endfunction : build_phase


    task run_phase(uvm_phase phase);

        rd_trans_h = router_rd_trans :: type_id :: create("rd_trans_h");
        rd_trans_h0 = router_rd_trans :: type_id :: create("rd_trans_h0");
        rd_trans_h1 = router_rd_trans :: type_id :: create("rd_trans_h1");
        rd_trans_h2 = router_rd_trans :: type_id :: create("rd_trans_h2");

        forever
        begin
            monitor_data_from_inf();
            //write_to_sb();
            rd_agt_config_h.rd_monitor_rcvd_xtn_cnt++;
        end
    endtask

    task monitor_data_from_inf();
    begin

        fork : F1
            begin : T1
                `uvm_info(get_type_name(), "monitor_data_from_inf CALLED", UVM_FULL)
                //For READ_ENB_0
                wait(vif.read_enb_0 == 1);
                @(posedge vif.clk);         //Practically observed delay
                `uvm_info(get_type_name(), "READ_ENB_0 -- HIGH", UVM_FULL)


                //Reading header byte
                @(negedge vif.clk);
                rd_trans_h0.header_byte = vif.data_out_0;
                rd_trans_h0.data_0_for_cov = vif.data_out_0;
                rd_trans_h0.payload_data = new[rd_trans_h0.header_byte[7:2]];

                for(int i=0; i<$size(rd_trans_h0.payload_data); i++)
                begin
                    @(negedge vif.clk);
                    rd_trans_h0.payload_data[i] = vif.data_out_0;
                    rd_trans_h0.data_0_for_cov = vif.data_out_0;
                end

                @(negedge vif.clk);
                rd_trans_h0.parity_byte = vif.data_out_0;
                rd_trans_h0.data_0_for_cov = vif.data_out_0;

                //Valid_out_x
                rd_trans_h0.valid_out_0 = vif.valid_out_0;
                rd_trans_h0.valid_out_1 = vif.valid_out_1;
                rd_trans_h0.valid_out_2 = vif.valid_out_2;
                
                //Busy
                rd_trans_h0.busy = vif.busy;
                rd_trans_h1.busy = vif.busy;
                rd_trans_h2.busy = vif.busy;
                
                //Error
                rd_trans_h0.error = vif.error;
                rd_trans_h1.error = vif.error;
                rd_trans_h2.error = vif.error;

                //write to analysis fifo of sb
                if(rd_trans_h0.header_byte != 0)
                begin
                    read_analysis_port_0.write(rd_trans_h0);
                    `uvm_info(get_type_name(),$sformatf("Data Sent from READ-MONITOR to SCOREBOARD by read_analysis_port_0  is = \n%s",rd_trans_h0.sprint()),UVM_NONE)
                end
                rd_trans_h0 = router_rd_trans :: type_id :: create("rd_trans_h0");
            end : T1

            begin : T2
                //For READ_ENB_1
                wait(vif.read_enb_1 == 1);
                @(posedge vif.clk);         //Practically observed delay
                
                //Reading header byte
                @(negedge vif.clk);
                rd_trans_h1.header_byte = vif.data_out_1;
                rd_trans_h1.data_1_for_cov = vif.data_out_1;
                
                rd_trans_h1.payload_data = new[rd_trans_h1.header_byte[7:2]];
                
                for(int i=0; i<$size(rd_trans_h1.payload_data); i++)
                begin
                    @(negedge vif.clk);
                    rd_trans_h1.payload_data[i] = vif.data_out_1;
                    rd_trans_h1.data_1_for_cov = vif.data_out_1;
                    $display($time," -- payload_data[%0d] = %0h", i, rd_trans_h1.payload_data[i]);
                end

                @(negedge vif.clk);
                rd_trans_h1.parity_byte = vif.data_out_1;
                rd_trans_h1.data_2_for_cov = vif.data_out_1;

                //Valid_out_x
                rd_trans_h1.valid_out_0 = vif.valid_out_0;
                rd_trans_h1.valid_out_1 = vif.valid_out_1;
                rd_trans_h1.valid_out_2 = vif.valid_out_2;

                //write to analysis fifo of sb
                if(rd_trans_h1.header_byte != 0)
                begin
                    read_analysis_port_1.write(rd_trans_h1);
                    `uvm_info(get_type_name(),$sformatf("Data Sent from READ-MONITOR to SCOREBOARD by read_analysis_port_1  is = \n%s",rd_trans_h1.sprint()),UVM_NONE)
                end
                rd_trans_h1 = router_rd_trans :: type_id :: create("rd_trans_h1");
            end : T2

            begin : T3
                //For READ_ENB_2
                wait(vif.read_enb_2 == 1);
                @(posedge vif.clk);         //Practically observed delay

                //Reading header byte
                @(negedge vif.clk);
                rd_trans_h2.header_byte = vif.data_out_2;
                rd_trans_h2.data_2_for_cov = vif.data_out_2;
                rd_trans_h2.payload_data = new[rd_trans_h2.header_byte[7:2]];

                for(int i=0; i<$size(rd_trans_h2.payload_data); i++)
                begin
                    @(negedge vif.clk);
                    rd_trans_h2.payload_data[i] = vif.data_out_2;
                    rd_trans_h2.data_2_for_cov = vif.data_out_2;
                end

                @(negedge vif.clk);
                rd_trans_h2.parity_byte = vif.data_out_2;
                rd_trans_h2.data_2_for_cov = vif.data_out_2;

                //Valid_out_x
                rd_trans_h2.valid_out_0 = vif.valid_out_0;
                rd_trans_h2.valid_out_1 = vif.valid_out_1;
                rd_trans_h2.valid_out_2 = vif.valid_out_2;

                //write to analysis fifo of sb
                if(rd_trans_h2.header_byte != 0)
                begin
                    read_analysis_port_2.write(rd_trans_h2);
                    `uvm_info(get_type_name(),$sformatf("Data Sent from READ-MONITOR to SCOREBOARD by read_analysis_port_2  is = \n%s",rd_trans_h2.sprint()),UVM_NONE)
                end
                rd_trans_h2 = router_rd_trans :: type_id :: create("rd_trans_h2");
            end : T3

        join_any : F1



    end
    endtask

    

endclass : router_rd_mon

`endif
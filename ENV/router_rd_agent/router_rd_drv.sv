`ifndef ROUTER_RD_DRV
`define ROUTER_RD_DRV

class router_rd_drv extends uvm_driver#(router_rd_trans);

    //Factory registration
    `uvm_component_utils(router_rd_drv)

    //Instantiation
    router_rd_trans rd_trans_h;
    virtual router_if vif;
    router_rd_agent_config rd_agt_config_h;
    static int trans_cnt = 1;
    string trans_display = "";
    bit [1:0] detect_addr;
    int read_wait_clk;
    bit event_on;

    transaction_type_e xtn_type;

    //New constructor
    function new(string name = "router_rd_drv", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        rd_trans_h = router_rd_trans :: type_id :: create("rd_trans_h");
        if(!uvm_config_db #(router_rd_agent_config) :: get(this," ","rd_agt_config_h",rd_agt_config_h))
            `uvm_fatal("ROUTER_READ_DRIVER :","Can't able to get router_rd_agent_config... Have you set it ??")

    endfunction : build_phase

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);

    endfunction : connect_phase

    task initial_reset();

        vif.resetn = 0;
        wait_for_negedge_clock(1);
        vif.resetn = 1;

    endtask : initial_reset

    task run_phase(uvm_phase phase);

        initial_reset();

        forever
        begin
            event_on = 0;
            //"get_next_item" is sending request to sequencer to get the new packet for driving to DUT
            seq_item_port.get_next_item(req);
            `uvm_info(get_type_name(),$sformatf("Data Received at READ-DRIVER = \n%s",req.sprint()),UVM_MEDIUM)
            
            //Task call to drive the data
            send_read_xtn_to_dut(req);
                
            //"item_done" is NB method. It indicates completion of driving process    
            seq_item_port.item_done();
            rd_agt_config_h.rd_driver_sent_xtn_cnt++;
        end

    endtask : run_phase

    task send_read_xtn_to_dut(router_rd_trans req);

        fork : F1
            begin
                wait(vif.valid_out_0);
                //repeat(rd_trans_h.xtn_delay)
                    //  @(negedge vif.clk);
                
                wait_for_posedge_clock(req.xtn_delay);
                    
                vif.read_enb_0 <= 1;
                wait(~vif.valid_out_0);
                @(negedge vif.clk);
                vif.read_enb_0 <= 0;
            end

            begin
                wait(vif.valid_out_1);
                //repeat(rd_trans_h.xtn_delay)
                    //  @(posedge vif.clk);

                wait_for_posedge_clock(req.xtn_delay);
                    
                vif.read_enb_1 <= 1;
                wait(~vif.valid_out_1);
                @(negedge vif.clk);
                vif.read_enb_1 <= 0;
            end

            begin
                wait(vif.valid_out_2);
                //repeat(rd_trans_h.xtn_delay)
                    //  @(negedge vif.clk);
                    
                wait_for_posedge_clock(req.xtn_delay);
                    
                vif.read_enb_2 <= 1;
                wait(~vif.valid_out_2);
                @(negedge vif.clk);
                vif.read_enb_2 <= 0;
            end

        join_any

    endtask

endclass : router_rd_drv

`endif
`ifndef ROUTER_WR_DRV
`define ROUTER_WR_DRV

class router_wr_drv extends uvm_driver#(router_wr_trans);

    //Factory registration
    `uvm_component_utils(router_wr_drv)

    //Instantiation
    router_wr_trans wr_trans_h;
    virtual router_if vif;
    router_wr_agent_config wr_agt_config_h;
    static int trans_cnt = 1;
    string trans_display = "";
    bit [1:0] detect_addr;
    int read_wait_clk;

    bit read_lfd_state;

    transaction_type_e xtn_type;

    //New constructor
    function new(string name = "router_wr_drv", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        wr_trans_h = router_wr_trans :: type_id :: create("wr_trans_h");
        if(!uvm_config_db #(router_wr_agent_config) :: get(this," ","wr_agt_config_h",wr_agt_config_h))
            `uvm_fatal("ROUTER_WRITE_DRIVER :","Can't able to get router_wr_agent_config... Have you set it ??")

    endfunction : build_phase

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);
        vif = wr_agt_config_h.vif;

    endfunction : connect_phase

    task initial_reset();

        wait_for_negedge_clock(1);
        vif.resetn = 0;
        wait_for_negedge_clock(1);
        vif.resetn = 1;

    endtask : initial_reset

    task run_phase(uvm_phase phase);

        initial_reset();

        forever
        begin
            //"get_next_item" is sending request to sequencer to get the new packet for driving to DUT
            seq_item_port.get_next_item(req);
            `uvm_info(get_type_name(),$sformatf("Data Received at WRITE-DRIVER = \n%s",req.sprint()),UVM_HIGH)
            
            //Task call to drive the data
            send_write_xtn_to_dut(req);
                
            //"item_done" is NB method. It indicates completion of driving process    
            seq_item_port.item_done();
            wr_agt_config_h.wr_driver_sent_xtn_cnt++;
            trans_cnt++;
        end

    endtask : run_phase

    task send_write_xtn_to_dut(router_wr_trans req);

        //Wait for busy signal to be LOW before driving the transaction
        wait(vif.busy == 0);
        @(negedge vif.clk);

        //Sending header byte and pkt_valid=1 during that driving
        vif.pkt_valid = 1;
        trans_display = $sformatf("TRANS-%0d",trans_cnt);
        $cast(xtn_type, 1);
        vif.data_in <= req.header_byte;
        detect_addr = req.header_byte[1:0];

        //Wait for lfd_state to be high to catch header_byte at the output end - Practically observed
        do
        begin
            void'(uvm_hdl_read("router_top.ROUTER_DUT.FSM.lfd_state",read_lfd_state));
            #2;
        end
        while(read_lfd_state == 0);

        //Driving payload data bytes as per its length and check busy signal after every transaction, pkt_valid=1 during that time
        @(negedge vif.clk);
        foreach(req.payload_data[i])
        begin
            wait(vif.busy == 0);
            @(negedge vif.clk);
            $cast(xtn_type, 2);
            vif.data_in <= req.payload_data[i];
        end

        //Driving parity byte, checking for busy, pkt_valid=1 during that time
        wait(vif.busy == 0);
        
        @(negedge vif.clk);
        //Make pkt_valid=0 after all packet transactions
        vif.pkt_valid = 0;
        $cast(xtn_type, 3);
        vif.data_in <= req.parity_byte;
        
    endtask : send_write_xtn_to_dut

endclass : router_wr_drv

`endif
`ifndef ROUTER_WR_MON
`define ROUTER_WR_MON

class router_wr_mon extends uvm_monitor;

    //Factory registration
    `uvm_component_utils(router_wr_mon)

    router_wr_trans wr_trans_h;
    router_wr_agent_config wr_agt_config_h;

    virtual router_if vif;
    bit [7:0] header_byte;
    bit [7:0] payload_data_wave;
    bit [7:0] parity_data_wave;
    static int size;
    bit read_ld_state;

    //Analysis port for SB
    uvm_analysis_port#(router_wr_trans) write_analysis_port;

    //Function new - constructor
    function new(string name = "router_mon", uvm_component parent = null);
        super.new(name, parent);
        write_analysis_port = new("write_analysis_port",this);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        if(!uvm_config_db #(router_wr_agent_config) :: get(this," ","wr_agt_config_h",wr_agt_config_h))
            `uvm_fatal("ROUTER_WRITE_MONITOR :","Can't able to get router_wr_agent_config... Have you set it ??")

    endfunction : build_phase

    task run_phase(uvm_phase phase);

        forever
        begin
            monitor_data_from_inf();
            write_to_sb();
            wr_agt_config_h.wr_monitor_rcvd_xtn_cnt++;
        end

    endtask

    task monitor_data_from_inf();
        begin
            wr_trans_h = router_wr_trans :: type_id :: create("wr_trans_h");
            //Monitor header_byte
            wait(vif.pkt_valid);
            @(posedge vif.clk);
            wr_trans_h.header_byte = vif.data_in;
            wr_trans_h.data_for_cov = vif.data_in;

            //Wait for lfd_state to be high to catch header_byte at the output end - Practically observed
            do
            begin
                void'(uvm_hdl_read("router_top.ROUTER_DUT.FSM.ld_state",read_ld_state));
                #2;
            end
            while(read_ld_state == 0);

            //Monitor payload_data bytes
            wr_trans_h.payload_data = new[wr_trans_h.header_byte[7:2]];
            for(int i=0; i<$size(wr_trans_h.payload_data); i++)
            begin
                @(posedge vif.clk);
                wait(~vif.busy);
                wr_trans_h.payload_data[i] = vif.data_in;
                wr_trans_h.data_for_cov = vif.data_in;
            end

            wait(~vif.pkt_valid);
            @(posedge vif.clk);
            wr_trans_h.parity_byte = vif.data_in;
            wr_trans_h.data_for_cov = vif.data_in;
            wr_trans_h.pkt_valid = vif.pkt_valid;

            `uvm_info(get_type_name(),$sformatf("Data Received at WRITE-MONITOR from INTERFACE is = \n%s",wr_trans_h.sprint()),UVM_HIGH)
        end
    endtask

    task write_to_sb();
        write_analysis_port.write(wr_trans_h);
        `uvm_info(get_type_name(),$sformatf("Data Sent to SCOREBOARD from WRITE-MONITOR is = \n%s",wr_trans_h.sprint()),UVM_HIGH)
    endtask

endclass : router_wr_mon

`endif
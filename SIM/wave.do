onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Interface
add wave -noupdate /uvm_root/uvm_test_top/env_h/wr_agent_h/wr_drv_h/trans_display
add wave -noupdate /uvm_root/uvm_test_top/env_h/wr_agent_h/wr_drv_h/xtn_type
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/clk
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/resetn
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/pkt_valid
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/read_enb_0
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/read_enb_1
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/read_enb_2
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/data_in
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/data_out_0
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/data_out_1
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/data_out_2
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/valid_out_0
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/valid_out_1
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/valid_out_2
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/error
add wave -noupdate -expand -group {Interface Signals} /router_top/inf/busy
add wave -noupdate -divider FIFO-1-2-3
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/clk
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/resetn
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/soft_reset
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/write_en
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/read_en
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/lfd_state
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/data_in
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/full
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/empty
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/data_out
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/counter
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/write_pointer
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/read_pointer
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/fifo_memory
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/lfd_temp
add wave -noupdate -expand -group FIFO-1 /router_top/ROUTER_DUT/FIFO_1/i
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/clk
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/resetn
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/soft_reset
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/write_en
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/read_en
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/lfd_state
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/data_in
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/full
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/empty
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/data_out
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/write_pointer
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/read_pointer
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/fifo_memory
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/lfd_temp
add wave -noupdate -expand -group FIFO-2 /router_top/ROUTER_DUT/FIFO_2/i
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/clk
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/resetn
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/soft_reset
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/write_en
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/read_en
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/lfd_state
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/data_in
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/full
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/empty
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/data_out
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/write_pointer
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/read_pointer
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/incrementer
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/fifo_memory
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/lfd_temp
add wave -noupdate -expand -group FIFO-3 /router_top/ROUTER_DUT/FIFO_3/i
add wave -noupdate -divider Synchronizer
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/data_in
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/clk
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/resetn
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/detect_addr
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/full_0
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/full_1
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/full_2
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/empty_0
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/empty_1
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/empty_2
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/write_en_reg
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/read_enb_0
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/read_enb_1
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/read_enb_2
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/fifo_full
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/valid_out_0
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/valid_out_1
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/valid_out_2
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/soft_reset_0
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/soft_reset_1
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/soft_reset_2
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/write_enb
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/fifo_selection
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/timeout_count_0
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/timeout_count_1
add wave -noupdate -expand -group Synchronizer /router_top/ROUTER_DUT/SYNCHRONIZER/timeout_count_2
add wave -noupdate -divider Register
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/data_in
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/clk
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/resetn
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/pkt_valid
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/fifo_full
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/detect_addr
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/ld_state
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/laf_state
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/full_state
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/lfd_state
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/reset_int_reg
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/error
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/parity_done
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/low_pkt_valid
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/data_out
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/full_state_byte
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/internal_parity
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/packet_parity
add wave -noupdate -expand -group Register /router_top/ROUTER_DUT/REGISTER/header_byte
add wave -noupdate -divider FSM
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/data_in
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/clk
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/resetn
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/pkt_valid
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/fifo_full
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/fifo_empty_0
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/fifo_empty_1
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/fifo_empty_2
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/soft_reset_0
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/soft_reset_1
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/soft_reset_2
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/parity_done
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/low_pkt_valid
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/write_en_reg
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/detect_addr
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/ld_state
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/laf_state
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/lfd_state
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/full_state
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/reset_int_reg
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/busy
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/present_state
add wave -noupdate -expand -group FSM /router_top/ROUTER_DUT/FSM/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6042559 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 143
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {6809250 ps}

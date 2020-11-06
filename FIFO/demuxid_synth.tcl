read_verilog demux_id.v
hierarchy -check -top demux_id
proc; opt; fsm; opt; memory; opt
techmap; opt
dfflibmap -liberty cmos_cells.lib
abc -liberty cmos_cells.lib
clean
write_verilog demux_id_est.v
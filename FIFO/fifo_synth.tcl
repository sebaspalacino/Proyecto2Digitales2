read_verilog fifo.v
hierarchy -check -top fifo
proc; opt; fsm; opt; memory; opt
techmap; opt
dfflibmap -liberty cmos_cells.lib
abc -liberty cmos_cells.lib
clean
write_verilog fifo_est.v
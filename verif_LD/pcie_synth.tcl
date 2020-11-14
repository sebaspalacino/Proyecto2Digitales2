read_verilog pcie_trans.v
hierarchy -check -top pcie_trans
proc; opt; fsm; opt; memory; opt
techmap; opt
dfflibmap -liberty cmos_cells.lib
abc -liberty cmos_cells.lib
clean
write_verilog pcie_trans_est.v
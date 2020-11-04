`include "mux_dest.v"
`include "probador.v"
`include "cmos_cells.v"
`include "mux_dest_synth.v"

module BancoPruebas#(parameter BITNUMBER=5);

wire clk, reset, valid_VC0, valid_VC1, valid_out_dest, valid_out_dest_estr;

wire [BITNUMBER-1:0] data_in0, data_in1, data_out_dest, data_out_dest_estr;

mux_dest mux_dest(.clk	(clk),
		.reset	(reset),
		.valid_VC0	(valid_VC),
		.valid_VC1	(valid_VC1),
		.data_in0	(data_in0),
		.data_in1	(data_in1),
		.valid_out_dest	(valid_out_dest),
		.data_out_dest	(data_out_dest));

mux_dest_synth mux_dest_synth(.clk	(clk),
		.reset	(reset),
		.valid_VC0	(valid_VC),
		.valid_VC1	(valid_VC1),
		.data_in0	(data_in0),
		.data_in1	(data_in1),
		.valid_out_dest	(valid_out_dest_estr),
		.data_out_dest	(data_out_dest_estr));		

probador probador(.clk	(clk),
		.reset	(reset),
		.valid_VC0	(valid_VC),
		.valid_VC1	(valid_VC1),
		.data_in0	(data_in0),
		.data_in1	(data_in1),
		.valid_out_dest_estr	(valid_out_dest_estr),
		.data_out_dest_estr	(data_out_dest_estr),
		.valid_out_dest	(valid_out_dest),
		.data_out_dest	(data_out_dest));

endmodule		

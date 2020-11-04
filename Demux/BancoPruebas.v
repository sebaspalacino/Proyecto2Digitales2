`include "demux_dest.v"
`include "probador.v"
`include "cmos_cells.v"
`include "demux_dest_synth.v"

module BancoPruebas#(parameter BITNUMBER=5);


wire clk, reset, valid_in0, valid_in1;
wire valid_out0, valid_out1, valid_out0_estr, valid_out1_estr;

wire [BITNUMBER-1:0] data_in, data_out0, data_out1, data_out0_estr, data_out1_estr;






demux_dest demux_dest(.clk	(clk),
			.reset	(reset),
			.valid_in0	(valid_in0),
			.valid_in1	(valid_in1),
			.data_in	(data_in),
			.valid_out0	(valid_out0),
			.valid_out1	(valid_out1),
			.data_out0	(data_out0),
			.data_out1	(data_out1));

demux_dest_synth demux_dest_synth(.clk	(clk),
			.reset	(reset),
			.valid_in0	(valid_in0),
			.valid_in1	(valid_in1),
			.data_in	(data_in),
			.valid_out0	(valid_out0_estr),
			.valid_out1	(valid_out1_estr),
			.data_out0	(data_out0_estr),
			.data_out1	(data_out1_estr));

probador probador(.clk	(clk),
			.reset	(reset),
			.valid_in0	(valid_in0),
			.valid_in1	(valid_in1),
			.data_in	(data_in),
			.valid_out0	(valid_out0),
			.valid_out1	(valid_out1),
			.data_out0	(data_out0),
			.data_out1	(data_out1),
			.valid_out0_estr	(valid_out0_estr),
			.valid_out1_estr	(valid_out1_estr),
			.data_out0_estr	(data_out0_estr),
			.data_out1_estr	(data_out1_estr));
			
			
endmodule									

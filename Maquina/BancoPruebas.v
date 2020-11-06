`include "maquina.v"
`include "probador.v"
`include "cmos_cells.v"
`include "maquina_synth.v"

module BancoPruebas;

parameter BITBUS=1;

wire clk, reset;

wire [4:0] Fifo_empties, Fifo_errors;

wire [BITBUS-1:0] umbralMF, umbralVC, umbralD;

wire [BITBUS-1:0] umbralMF_out, umbralVC_out, umbralD_out;
wire [BITBUS-1:0] umbralMF_out_estr, umbralVC_out_estr, umbralD_out_estr;

wire init_out, idle_out, active_out, error_out;
wire idle_out_estr, active_out_estr, error_out_estr, init_out_estr;
wire [3:0] next_state, next_state_estr, state, state_estr;

maquina maquina(.clk	(clk),
		.reset	(reset),
		.umbralMF	(umbralMF[BITBUS-1:0]),
		.umbralVC	(umbralVC[BITBUS-1:0]),
		.umbralD	(umbralD[BITBUS-1:0]),
		.umbralMF_out	(umbralMF_out[BITBUS-1:0]),
		.umbralVC_out	(umbralVC_out[BITBUS-1:0]),
		.umbralD_out	(umbralD_out[BITBUS-1:0]),
		.Fifo_empties	(Fifo_empties[4:0]),
		.Fifo_errors	(Fifo_errors[4:0]),
		.init_out	(init_out),
		.idle_out	(idle_out),
		.active_out	(active_out),
		.error_out	(error_out),
		.state		(state[3:0]),
		.next_state (next_state[3:0]));

maquina_synth maquina_synth(.clk	(clk),
		.reset	(reset),
		.umbralMF	(umbralMF[BITBUS-1:0]),
		.umbralVC	(umbralVC[BITBUS-1:0]),
		.umbralD	(umbralD[BITBUS-1:0]),
		.umbralMF_out	(umbralMF_out_estr[BITBUS-1:0]),
		.umbralVC_out	(umbralVC_out_estr[BITBUS-1:0]),
		.umbralD_out	(umbralD_out_estr[BITBUS-1:0]),
		.Fifo_empties	(Fifo_empties[4:0]),
		.Fifo_errors	(Fifo_errors[4:0]),
		.init_out	(init_out_estr),
		.idle_out	(idle_out_estr),
		.active_out	(active_out_estr),
		.error_out	(error_out_estr),
		.state_estr		(state_estr[3:0]),
		.next_state_estr (next_state_estr[3:0]));		

probador probador(.clk	(clk),
		.reset	(reset),
		.umbralMF	(umbralMF[BITBUS-1:0]),
		.umbralVC	(umbralVC[BITBUS-1:0]),
		.umbralD	(umbralD[BITBUS-1:0]),
		.umbralMF_out	(umbralMF_out[BITBUS-1:0]),
		.umbralVC_out	(umbralVC_out[BITBUS-1:0]),
		.umbralD_out	(umbralD_out[BITBUS-1:0]),
		.Fifo_empties	(Fifo_empties[4:0]),
		.Fifo_errors	(Fifo_errors[4:0]),
		.umbralMF_out_estr	(umbralMF_out_estr[BITBUS-1:0]),
		.umbralVC_out_estr	(umbralVC_out_estr[BITBUS-1:0]),
		.umbralD_out_estr	(umbralD_out_estr[BITBUS-1:0]),
		.init_out_estr	(init_out_estr),
		.idle_out_estr	(idle_out_estr),
		.active_out_estr	(active_out_estr),
		.error_out_estr	(error_out_estr),
		.init_out	(init_out),
		.idle_out	(idle_out),
		.active_out	(active_out),
		.error_out	(error_out));

endmodule	

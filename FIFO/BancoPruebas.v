`timescale 1ns / 100ps
`include "fifo.v"
`include "probador.v"
`include "fifo_est.v"
`include "cmos_cells.v"
`include "demux_id.v"
`include "demux_id_est.v"
module BancoPruebas;

//Parametros
parameter BITNUMBER =6;
parameter LENGTH =4*1;

//Wires
wire clk, reset, Fifo_rd, Fifo_wr, Fifo_rd_error, Fifo_wr_error, Fifo_error, Fifo_error_est, almost_empty, almost_full, Fifo_full_est, Fifo_empty_est, valid_read, valid_read_est;
wire pause, pause_est, Fifo_wr0_mux, Fifo_wr1_mux, Fifo_wr0_mux_est, Fifo_wr1_mux_est;
wire [BITNUMBER-1:0] Fifo_Data_in;
wire [BITNUMBER-1:0] Fifo_Data_out, Fifo_Data_out_est;
wire [BITNUMBER-1:0]demux_to_VC0, demux_to_VC1, demux_to_VC0_est, demux_to_VC1_est;
wire [2:0] rd_ptr,rd_ptr_est, Umbral;

fifo #(.BITNUMBER (BITNUMBER), .LENGTH (LENGTH))fifo_(/*AUTOINST*/
						      // Outputs
						      .Fifo_full	(Fifo_full),
						      .Fifo_empty	(Fifo_empty),
						      .Fifo_Data_out	(Fifo_Data_out[BITNUMBER-1:0]),
						      .Fifo_rd_error	(Fifo_rd_error),
						      .Fifo_wr_error	(Fifo_wr_error),
						      .Fifo_error	(Fifo_error),
						      .almost_full	(almost_full),
						      .almost_empty	(almost_empty),
						      .can_pop		(can_pop),
						      .pause		(pause),
						      .valid_read	(valid_read),
						      // Inputs
						      .Fifo_Data_in	(Fifo_Data_in[BITNUMBER-1:0]),
						      .clk		(clk),
						      .reset		(reset),
						      .Fifo_rd		(Fifo_rd),
						      .Fifo_wr		(Fifo_wr),
						      .Umbral		(Umbral[2:0]));

fifo_est fifo_est(/*AUTOINST*/
		  // Outputs
		  .Fifo_Data_out_est	(Fifo_Data_out_est[5:0]),
		  .Fifo_empty_est	(Fifo_empty_est),
		  .Fifo_error_est	(Fifo_error_est),
		  .Fifo_full_est	(Fifo_full_est),
		  .Fifo_rd_error_est	(Fifo_rd_error_est),
		  .Fifo_wr_error_est	(Fifo_wr_error_est),
		  .almost_empty_est	(almost_empty_est),
		  .almost_full_est	(almost_full_est),
		  .can_pop		(can_pop),
		  .pause		(pause),
		  .valid_read_est	(valid_read_est),
		  // Inputs
		  .Fifo_Data_in		(Fifo_Data_in[5:0]),
		  .Fifo_rd		(Fifo_rd),
		  .Fifo_wr		(Fifo_wr),
		  .Umbral		(Umbral[2:0]),
		  .clk			(clk),
		  .reset		(reset));
demux_id demux_id_(
	// Outputs
    .demux_to_VC0	(demux_to_VC0[BITNUMBER-1:0]),
    .demux_to_VC1	(demux_to_VC1[BITNUMBER-1:0]),
    .Fifo_wr0		(Fifo_wr0_mux),
	.Fifo_wr1		(Fifo_wr1_mux),
	// Inputs
	.Fifo_Data_out 	(Fifo_Data_out[BITNUMBER-1:0]),
    .clk			(clk),
    .reset			(reset),
    .valid_read		(valid_read)
);

demux_id_est demux_id_est_(
	// Outputs
    .demux_to_VC0_est	(demux_to_VC0_est[BITNUMBER-1:0]),
    .demux_to_VC1_est	(demux_to_VC1_est[BITNUMBER-1:0]),
    .Fifo_wr0_est		(Fifo_wr0_mux_est),
	.Fifo_wr1_est		(Fifo_wr1_mux_est),
	// Inputs
	.Fifo_Data_out_est 	(Fifo_Data_out_est[5:0]),
    .clk			(clk),
    .reset			(reset),
    .valid_read_est		(valid_read_est)
);

probador #(.BITNUMBER (BITNUMBER), .LENGTH (LENGTH))probador_(/*AUTOINST*/
							      // Outputs
							      .reset		(reset),
							      .clk		(clk),
							      .Fifo_wr		(Fifo_wr),
							      .Fifo_rd		(Fifo_rd),
							      .Umbral		(Umbral[2:0]),
							      .Fifo_Data_in	(Fifo_Data_in[BITNUMBER-1:0]),
							      // Inputs
							      .Fifo_Data_out	(Fifo_Data_out[BITNUMBER-1:0]),
							      .pause		(pause));

endmodule

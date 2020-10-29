`timescale 1ns / 100ps
`include "fifo.v"
`include "probador.v"
`include "fifo_est.v"
`include "cmos_cells.v"
module BancoPruebas;

//Parametros
parameter BITNUMBER =6;
parameter LENGTH =4*1;

//Wires
wire clk, reset, Fifo_rd, Fifo_wr, Fifo_rd_error, Fifo_wr_error, Fifo_error, Fifo_error_est, almost_empty, almost_full, Fifo_full_est, Fifo_empty_est, valid_read, valid_read_est;
wire [BITNUMBER-1:0] Fifo_Data_in;
wire [BITNUMBER-1:0] Fifo_Data_out, Fifo_Data_out_est;
wire [2:0] rd_ptr,rd_ptr_est;

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
						      .valid_read	(valid_read),
						      // Inputs
						      .Fifo_Data_in	(Fifo_Data_in[BITNUMBER-1:0]),
						      .clk		(clk),
						      .reset		(reset),
						      .Fifo_rd		(Fifo_rd),
						      .Fifo_wr		(Fifo_wr));

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
		  .valid_read_est	(valid_read_est),
		  // Inputs
		  .Fifo_Data_in		(Fifo_Data_in[5:0]),
		  .Fifo_rd		(Fifo_rd),
		  .Fifo_wr		(Fifo_wr),
		  .clk			(clk),
		  .reset		(reset));

probador #(.BITNUMBER (BITNUMBER), .LENGTH (LENGTH))probador_(/*AUTOINST*/
							      // Outputs
							      .reset		(reset),
							      .clk		(clk),
							      .Fifo_wr		(Fifo_wr),
							      .Fifo_rd		(Fifo_rd),
							      .Fifo_Data_in	(Fifo_Data_in[BITNUMBER-1:0]),
							      // Inputs
							      .Fifo_Data_out	(Fifo_Data_out[BITNUMBER-1:0]));

endmodule

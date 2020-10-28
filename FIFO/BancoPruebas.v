`timescale 1ns / 100ps
`include "fifo.v"
`include "probador.v"

module BancoPruebas;

//Parametros
parameter BITNUMBER =8;
parameter LENGTH =8;

//Wires
wire clk, reset, Fifo_rd, Fifo_wr, Fifo_rd_error, Fifo_wr_error;
wire [BITNUMBER-1:0] Fifo_Data_in;
wire [BITNUMBER-1:0] Fifo_Data_out;

fifo fifo_(/*AUTOINST*/
	   // Outputs
	   .Fifo_full			(Fifo_full),
	   .Fifo_empty			(Fifo_empty),
	   .Fifo_Data_out		(Fifo_Data_out[BITNUMBER-1:0]),
	   .Fifo_rd_error		(Fifo_rd_error),
	   .Fifo_wr_error		(Fifo_wr_error),
	   .almost_full			(almost_full),
	   .almost_empty		(almost_empty),
	   // Inputs
	   .Fifo_Data_in		(Fifo_Data_in[BITNUMBER-1:0]),
	   .clk				(clk),
	   .reset			(reset),
	   .Fifo_rd			(Fifo_rd),
	   .Fifo_wr			(Fifo_wr));

probador probador_(/*AUTOINST*/
		   // Outputs
		   .reset		(reset),
		   .clk			(clk),
		   .Fifo_wr		(Fifo_wr),
		   .Fifo_rd		(Fifo_rd),
		   .Fifo_Data_in	(Fifo_Data_in[BITNUMBER-1:0]),
		   // Inputs
		   .Fifo_Data_out	(Fifo_Data_out[BITNUMBER-1:0]));

endmodule

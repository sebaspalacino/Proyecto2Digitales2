`timescale 1ns / 100ps
`include "memoria.v"
`include "probador.v"

module BancoPruebas;

//Parametros
parameter BITNUMBER =10;
parameter LENGTH =8;

//Wires
wire clk, reset, read, write;
wire [2:0] ptr_write, ptr_read;
wire [BITNUMBER-1:0] data_in;
wire [BITNUMBER-1:0] data_out;

memoria memoria(.data_in	(data_in),
		.data_out	(data_out),
		.ptr_write	(ptr_write),
		.ptr_read	(ptr_read),
		.clk		(clk),
		.reset		(reset),
		.read		(read),
		.write		(write));

probador probador(.data_in	(data_in),
		.data_out	(data_out),
		.ptr_write	(ptr_write),
		.ptr_read	(ptr_read),
		.clk		(clk),
		.reset		(reset),
		.read		(read),
		.write		(write));

endmodule

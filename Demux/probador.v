`timescale 1ns / 100ps
module probador#(parameter BITNUMBER=5)
		(input [BITNUMBER-1:0] data_out0, data_out1, data_out0_estr, data_out1_estr,
		input valid_out0, valid_out1, valid_out0_estr, valid_out1_estr,
		output reg clk, reset, valid_in0, valid_in1,
		output reg [BITNUMBER-1:0] data_in);
		
		initial begin
		$dumpfile("resultados.vcd");
		$dumpvars;
		reset<=0;
		valid_in0<=0;
		valid_in1<=0;
		data_in<=0;
		@(posedge clk);
		reset<=1;
		@(posedge clk);
		valid_in0<=1;
		data_in<=5;
		@(posedge clk);
		data_in<=7;
		@(posedge clk);
		valid_in0<=0;
		valid_in1<=1;
		data_in<=4;
		@(posedge clk);
		data_in<=9;
		@(posedge clk);
		valid_in1<=0;
		data_in<=5;
		@(posedge clk);
		valid_in0<=1;
		data_in<=3;
		@(posedge clk);
		$finish;
		
		end
		initial	clk 	<= 0;
		always	#4 clk 	<= ~clk;		

endmodule

`timescale 1ns / 100ps

module probador#(parameter BITNUMBER=5)
			(input valid_out_dest0, valid_out_dest1, valid_out_dest0_estr, valid_out_dest1_estr,
			input [BITNUMBER-1:0] data_out_dest, data_out_dest_estr,
			output reg [BITNUMBER-1:0] data_in0, data_in1,
			output reg clk, reset, valid_VC0, valid_VC1);

initial begin
		$dumpfile("resultados.vcd");
		$dumpvars;
		reset<=0;
		valid_VC0<=0;
		valid_VC1<=0;
		data_in0<=0;
		data_in1<=0;
		@(posedge clk);
		reset<=1;
		@(posedge clk);
		data_in0<=5;
		data_in1<=7;
		@(posedge clk);
		valid_VC0<=1;
		data_in0<=4;
		data_in1<=8;
		
		@(posedge clk);
		valid_VC0<=0;
		valid_VC1<=1;
		data_in0<=6;
		data_in1<=3;
		@(posedge clk);
		valid_VC1<=0;
		data_in0<=8;
		data_in1<=9;
		@(posedge clk);
		valid_VC0<=1;
		valid_VC1<=0;		
		data_in0<=5;
		data_in1<=7;
		@(posedge clk);
		$finish;
end			
	initial	clk 	<= 0;
	always	#4 clk 	<= ~clk;		

endmodule

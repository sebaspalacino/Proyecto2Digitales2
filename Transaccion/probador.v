module probador #(parameter BITNUMBER = 8,
		parameter LENGTH = 8)
(	input Main_pause,
	input D0_can_pop,
	input D1_can_pop,
	output reg reset,
	output reg clk,
	output reg push,
	output reg pop_D1,
	output reg pop_D0,
	output reg [BITNUMBER-1:0] data_in);

initial begin
	$dumpfile("resultados.vcd");
	$dumpvars;

	reset <= 1;
	{push, pop_D0, pop_D1, data_in} <=0;
	@(posedge clk);
	@(posedge clk);
	reset <=0;

	@(posedge clk);
	data_in <= $random;
	/*if(!Main_pause)
		push <= 1;
	else 
		push <= 0;*/
	push <= 1;
	@(posedge clk);
	data_in <= $random;
	/*if(!Main_pause)
		push <= 1;
	else 
		push <= 0;*/
	push <= 1;	
	@(posedge clk);
	data_in <= $random | 'b010000;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random| 'b010000;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random| 'b010000;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random| 'b010000;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random| 'b010000;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= $random;
	pop_D0 <= 1;
	pop_D1 <= 1;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	$finish;	
end

initial clk <=0;
always #4 clk <= ~clk;
endmodule

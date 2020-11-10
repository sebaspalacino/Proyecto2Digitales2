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
	output reg [BITNUMBER-1:0] data_in,
	output reg [LENGTH-1:0] Umbral_MF_prob,
	output reg [LENGTH-1:0] Umbral_VC_prob, 
	output reg [LENGTH-1:0] Umbral_D_prob,
	output reg init);

initial begin
	$dumpfile("resultados.vcd");
	$dumpvars;

	reset <= 1;
	{push, pop_D0, pop_D1, data_in, Umbral_D_prob, Umbral_MF_prob, Umbral_VC_prob, init} <= 0;
	@(posedge clk);
	@(posedge clk);
	reset <=0;

	@(posedge clk);
	init <= 1;
	Umbral_D_prob <= 1;
	Umbral_MF_prob <= 1; 
	Umbral_VC_prob <= 3;
	data_in <= $random;
	/*if(!Main_pause)
		push <= 1;
	else 
		push <= 0;*/
	push <= 1;
	@(posedge clk);
	init <= 0;
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
	Umbral_D_prob <= 4;
	Umbral_MF_prob <= 6; 
	Umbral_VC_prob <= 0;
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
	init <= 1;
	Umbral_D_prob <= 2;
	Umbral_MF_prob <= 2; 
	Umbral_VC_prob <= 2;
	data_in <= $random;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	init <= 0;
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
	@(posedge clk);push<=0;@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	$finish;	
end

initial clk <=0;
always #4 clk <= ~clk;
endmodule

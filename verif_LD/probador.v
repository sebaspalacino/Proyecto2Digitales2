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
	output reg [3:0] Umbral_MF_prob,
	output reg [3:0] Umbral_VC_prob, 
	output reg [3:0] Umbral_D_prob,
	output reg init);
reg alternador;
initial begin
	$dumpfile("resultados.vcd");
	$dumpvars;

	reset <= 1;
	{push, pop_D0, pop_D1, data_in, Umbral_D_prob, Umbral_MF_prob, Umbral_VC_prob, init, alternador} <= 0;
	@(posedge clk);
	@(posedge clk);
	reset <=0;
// Lleno D0 Y D1 alternadamente
	@(posedge clk);
	init <= 1;
	Umbral_D_prob <= 1;
	Umbral_MF_prob <= 1; 
	Umbral_VC_prob <= 1;
	data_in <= 'b000001;
	push <= 1;

	@(posedge clk);
	init <= 0;
	data_in <= 'b010000;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;


	@(posedge clk);
	init <= 0;
	data_in <= 'b000010;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;

	
	@(posedge clk);
	init <= 0;
	data_in <= 'b010010;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;
	
	@(posedge clk);
	init <= 0;
	data_in <= 'b00011;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;
	
	@(posedge clk);
	init <= 0;
	data_in <= 'b010011;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;


	@(posedge clk);
	init <= 0;
	data_in <= 'b000100;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;
	
	@(posedge clk);
	init <= 0;
	data_in <= 'b010101;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;

// Pongo un valor nuevo en data in
	@(posedge clk);
	push <= 0;
	data_in <= 'b000100;

// Lleno VC0
	repeat (32) begin
		@(posedge clk);
		alternador <= alternador + 1;
		if (alternador == 0) begin
			data_in[4:0] <= data_in[4:0] + 1;
			data_in[5] <= 0; // A VC0
		end
		else begin
			data_in[4:0] <= data_in[4:0] + 1;
			data_in[5] <= 1; // A VC0
		end
		if(!Main_pause)
			push <= 1;
		else 
			push <= 0;
	end

/*// LLeno VC1
	repeat (16) begin
		@(posedge clk);
		data_in <= data_in + 1 | 'b100000;
		if(!Main_pause)
			push <= 1;
		else 
			push <= 0;
	end*/

// Lleno el main fifo
	@(posedge clk);
	data_in <= 'b111111;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;
	@(posedge clk);
	data_in <= 'b111110;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= 'b111101;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;	
	@(posedge clk);
	data_in <= 'b111100;
	if(!Main_pause)
		push <= 1;
	else 
		push <= 0;
	@(posedge clk)
	push <= 0;
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	pop_D0 <= 1;
	pop_D1 <= 1;			
	@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
	$finish;	
end

initial clk <=0;
always #4 clk <= ~clk;
endmodule
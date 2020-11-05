module probador #(parameter BITNUMBER = 8,
		parameter LENGTH = 8)
(input [BITNUMBER-1:0] Fifo_Data_out,
	input pause,
	output reg reset,
	output reg clk,
	output reg Fifo_wr,
	output reg Fifo_rd,
	output reg [2:0] Umbral,
	output reg [BITNUMBER-1:0] Fifo_Data_in);

initial begin
	$dumpfile("resultados.vcd");
	$dumpvars;

	reset <= 1;
	{Fifo_wr, Fifo_rd, Fifo_Data_in} <=0;
	Umbral <= 0;
	@(posedge clk);
	@(posedge clk);
	reset <=0;
	Umbral <= 1;
	@(posedge clk);
	Fifo_Data_in <= 'hA;
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;

	@(posedge clk);
		if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;	
	Fifo_Data_in <= 'hB;
	@(posedge clk);
		if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 'hC;
	@(posedge clk);
		if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 'hD;

	@(posedge clk);
		if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 'hE;
	Fifo_rd <= 1; // leer un dato
	@(posedge clk);
		if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 'hF;
	Fifo_rd <= 0;

	@(posedge clk);
		if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 1;
	@(posedge clk);
		if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 'b111111;
	@(posedge clk);
	Fifo_Data_in <= 'b100000;
	Fifo_rd <= 1;
		if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	@(posedge clk);
		if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 'b000111;
	@(posedge clk); // leer dos datos
	Fifo_Data_in <= 'b000001;
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	@(posedge clk);
		if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 3;
	@(posedge clk);
	
	Fifo_Data_in <= 4;
	@(posedge clk)
	Fifo_Data_in <= 'hF;
	Fifo_wr <= 0;
	Fifo_rd <= 1;
	@(posedge clk) // flush
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk) // Lo lleno
	Fifo_Data_in <= 'b111111;;
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_rd <= 0;
	@(posedge clk)
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 'b000111;
	@(posedge clk)
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 'b100000;
	@(posedge clk)
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 'b000001;
	@(posedge clk)
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 5;
	@(posedge clk)
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 6;
	@(posedge clk)
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 7;
	@(posedge clk)
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_Data_in <= 8;
	//Fifo_rd <= 1;
	@(posedge clk)
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	Fifo_rd <= 0;
	Fifo_Data_in <= 9;
	@(posedge clk)
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0;
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	Fifo_rd <= 1;
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	Fifo_rd <=0;
	@(posedge clk)
	@(posedge clk)
	if(!pause)
		Fifo_wr <= 1;
	else 
		Fifo_wr <= 0; 
	Fifo_Data_in <= 'hF;
	Fifo_rd <= 1;
	@(posedge clk)
	Fifo_rd <=0;
	Fifo_wr <= 0;
	@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	Fifo_rd <=1;
		@(posedge clk)
	@(posedge clk)
	@(posedge clk)
	$finish;	
end

initial clk <=0;
always #4 clk <= ~clk;
endmodule

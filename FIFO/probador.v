module probador #(parameter BITNUMBER = 8,
		parameter LENGTH = 8)
(input [BITNUMBER-1:0] Fifo_Data_out,
	output reg reset,
	output reg clk,
	output reg Fifo_wr,
	output reg Fifo_rd,
	output reg [BITNUMBER-1:0] Fifo_Data_in);

initial begin
	$dumpfile("resultados.vcd");
	$dumpvars;

	reset <= 1;
	{Fifo_wr, Fifo_rd, Fifo_Data_in} <=0;
	@(posedge clk);
	@(posedge clk);
	reset <=0;
	@(posedge clk);

	Fifo_Data_in <= 'hA;
	Fifo_wr <= 1;

	@(posedge clk);	
	Fifo_Data_in <= 'hB;
	@(posedge clk);
	Fifo_Data_in <= 'hC;
	@(posedge clk);
	Fifo_Data_in <= 'hD;

	@(posedge clk);
	Fifo_Data_in <= 'hE;
	Fifo_rd <= 1; // leer un dato
	@(posedge clk);
	Fifo_Data_in <= 'hF;
	Fifo_rd <= 0;

	@(posedge clk);
	Fifo_Data_in <= 1;
	@(posedge clk);
	Fifo_Data_in <= 2;
	Fifo_wr <= 0;
	@(posedge clk);
	Fifo_rd <= 1;
	@(posedge clk);
	@(posedge clk); // leer dos datos
	Fifo_wr <= 1;
	@(posedge clk);
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
	Fifo_Data_in <= 1;
	Fifo_wr <= 1;
	Fifo_rd <= 0;
	@(posedge clk)
	Fifo_Data_in <= 2;
	@(posedge clk)
	Fifo_Data_in <= 3;
	@(posedge clk)
	Fifo_Data_in <= 4;
	@(posedge clk)
	Fifo_Data_in <= 5;
	@(posedge clk)
	Fifo_Data_in <= 6;
	@(posedge clk)
	Fifo_Data_in <= 7;
	@(posedge clk)
	Fifo_Data_in <= 8;
	//Fifo_rd <= 1;
	@(posedge clk)
	Fifo_rd <= 0;
	//Fifo_Data_in <= 9;
	//@(posedge clk)
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

	$finish;	
end

initial clk <=0;
always #4 clk <= ~clk;
endmodule

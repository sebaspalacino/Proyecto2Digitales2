module probador #(parameter BITNUMBER =10,
		parameter LENGTH = 8)
(input [BITNUMBER-1:0] data_out,
	input [BITNUMBER-1:0] data_out_estr,
	output reg reset,
	output reg clk,
	output reg read,
	output reg write,
	output reg [2:0] ptr_write,
	output reg [2:0] ptr_read,
	output reg [BITNUMBER-1:0] data_in);

initial begin
	$dumpfile("resultados.vcd");
	$dumpvars;
	reset <=0;
	read <=0;
	write <=0;
	data_in <=0;
	ptr_write <=0;
	ptr_read <=0;
	@(posedge clk);
	@(posedge clk);
	reset <=1;
	@(posedge clk);
	data_in<=1;
	ptr_write<=1;
	write <=1;
	@(posedge clk);
	data_in<=2;
	ptr_read<=0;
	read<=1;
	ptr_write<=2;
	write<=1;
	@(posedge clk);
	data_in<=3;
	ptr_read<=1;
	read<=1;
	ptr_write<=3;
	write<=1;
	@(posedge clk);
	data_in<=4;
	ptr_read<=2;
	read<=1;
	ptr_write<=4;//orignalmente era 0
	write<=1;
	@(posedge clk);
	data_in<=5;
	ptr_read<=3;
	read<=1;
	ptr_write<=5;
	write<=1;	//Empezamos una mini prueba
	@(posedge clk); //Aqui hay problema con el data out ---- CORRECCION: YA SE RESOLVIO. AGARRABA ANTERIORMENTE PUNTEROS NULOS
	data_in<=6;
	ptr_read<=4;
	read<=1;
	ptr_write<=6;
	write<=1; //Extendemos la senal
	@(posedge clk);
	data_in<=7;
	ptr_read<=5;
	read<=1;
	ptr_write<=0;
	write<=0;
	@(posedge clk);
	data_in<=8;
	ptr_read<=6;
	read<=1;
	ptr_write<=2;
	write<=0;
	@(posedge clk);
	@(posedge clk);
	$finish;	
end

initial clk <=0;
always #4 clk <= ~clk;
endmodule

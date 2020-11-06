module probador#(parameter BITBUS =1)
		(input idle_out, active_out, error_out, init_out,
		input idle_out_estr, active_out_estr, error_out_estr, init_out_estr,
		input [BITBUS-1:0] umbralMF_out, umbralVC_out, umbralD_out,
		input [BITBUS-1:0] umbralMF_out_estr, umbralVC_out_estr, umbralD_out_estr,
		output reg clk,
		output reg reset,
		output reg [4:0] Fifo_empties, Fifo_errors,
		output reg  [BITBUS - 1:0] umbralMF, umbralVC, umbralD);
		
	initial begin
		$dumpfile("resultados.vcd");
		$dumpvars;
		
		reset<=0;
		umbralMF<=0;
		umbralVC<=0;
		umbralD<=0;
		Fifo_empties <=5'b11111;
		Fifo_errors <=00000;
		
		@(posedge clk);
		//@(posedge clk);
		reset<=1;
		@(posedge clk);
		//@(posedge clk);
		umbralMF<=1;
		umbralVC<=1;
		umbralD<=1;
		 //Este cambio a 0 funciona, aqui se prende init_out
		@(posedge clk);
		Fifo_empties <=5'b11111;
		@(posedge clk);
		Fifo_empties <= 11001; //Hay dos fifos que no estan vacios. Se deberia cambiar de estado a ACTIVE
		@(posedge clk); //Se deberia estar en ACTIVE
		Fifo_empties <=10001; //Hay otro FIFO que ya no esta vacio
		//No deberian haber errores
		@(posedge clk); //Aqui cambie las senales de  0 y 0 a 1 y 1
		Fifo_errors<=00001; //Se detecto un error, se deberia pasar ahora a ERROR
		@(posedge clk);
		//Se deberia mantener en error por un ciclo mas
		@(posedge clk); //Deactivamos el error para intentar saltar a RESET
		Fifo_errors<=00000;
		@(posedge clk);
		
		@(posedge clk);
		$finish;
		
		
	end		
	
	
	
initial clk <=0;
always #4 clk <= ~clk;
endmodule

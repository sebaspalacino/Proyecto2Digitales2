module probador(input idle_out, active_out, error_out, init_out,
		input idle_out_estr, active_out_estr, error_out_estr, init_out_estr,
		output reg clk,
		output reg reset,
		output reg umbralMF, umbralVC, umbralD,
		output reg FifoFull, FifoEmpty, FifoRead, FifoWrite);
		
	initial begin
		$dumpfile("resultados.vcd");
		$dumpvars;
		
		reset<=0;
		umbralMF<=0;
		umbralVC<=0;
		umbralD<=0;
		FifoFull<=0;
		FifoEmpty<=0;
		FifoRead<=0;
		FifoWrite<=0;
		
		@(posedge clk);
		//@(posedge clk);
		reset<=1;
		@(posedge clk);
		//@(posedge clk);
		umbralMF<=1;
		umbralVC<=1;
		umbralD<=0;
		FifoEmpty<=0; //Este cambio a 0 funciona, aqui se prende init_out
		@(posedge clk);
		//@(posedge clk);
		FifoEmpty<=1;
		FifoFull<=0;
		@(posedge clk); //Repetimos --- Se esta repitiendo estado 2 = IDLE
		FifoEmpty<=0;
		FifoFull<=0;
		@(posedge clk); //Aqui cambie las senales de  0 y 0 a 1 y 1
		FifoEmpty<=0;
		FifoFull<=0;
		//Voy a agregar un pulso extra para activar el error
		@(posedge clk);
		FifoEmpty<=1;
		FifoFull<=1;
		@(posedge clk); //Se deberia estar en el estado de ERROR
		FifoEmpty<=0;
		FifoFull<=1;
		FifoRead<=1;
		FifoWrite<=1;
		@(posedge clk);
		FifoFull<=0;
		FifoRead<=0;
		FifoWrite<=0;
		@(posedge clk);
		$finish;
		
		
	end		
	
	
	
initial clk <=0;
always #4 clk <= ~clk;
endmodule

module maquina#(parameter LENGTH = 2)
		(input clk,
		input reset,
		input [LENGTH-1:0] umbralMF,
		input [LENGTH-1:0] umbralVC,
		input [LENGTH-1:0] umbralD,
		input [4:0] Fifo_empties,
		input [4:0] Fifo_errors,
		output reg init_out,
		output reg idle_out,
		output reg active_out,
		output reg error_out,
		output reg [LENGTH-1:0] umbralMF_out,
		output reg [LENGTH-1:0] umbralVC_out,
		output reg [LENGTH-1:0] umbralD_out,
		output reg [3:0] state, 
		output reg [3:0]next_state);

parameter RESET=0;
parameter INIT =1;
parameter IDLE =2;
parameter ACTIVE=3;
parameter ERROR=4;

 always @ (posedge clk) begin
        if(~reset) begin
            state <= RESET; 
          //  error_out <=0;
        end
        else begin
            state <= next_state;
            
        end
    end		

always @(*) begin
	idle_out=0;
	active_out=0;
	error_out=0;
	next_state=state;
	init_out = 0;
	umbralMF_out = 0;
	umbralVC_out = 0;
	umbralD_out = 0;
	case(state)
		RESET: begin
		//For RESET state
			next_state= INIT;
		end
		
		INIT: begin
		//For INIT state
			if(umbralMF || umbralVC || umbralD)begin
			//Si hay algun umbral ON, init_out se enciende
				init_out=1;
				umbralMF_out = umbralMF;
				umbralVC_out = umbralVC;
				umbralD_out = umbralD;
				next_state= IDLE;
			end else begin
			//Si ningun umbral esta on, se vuelve a RESET e init_out se queda apagado
				init_out=0;
				umbralMF_out = 0;
				umbralVC_out = 0;
				umbralD_out = 0;
				next_state= RESET;
			end
		end
		
		IDLE: begin
		//For IDLE state
			if(Fifo_empties == 5'b11111)begin 
				idle_out=1;
				next_state= IDLE;
			end else begin
				idle_out=0;
				next_state= ACTIVE;
			end 
		end
		
		ACTIVE: begin
		//For ACTIVE state
			if(Fifo_errors == 00000) begin //Si el fifo no esta ni lleno, ni vacio, osea que tiene informacion adentro que se puede transmitir
				active_out=1;
				next_state=ACTIVE;
			end else begin
			//Este caso generaria un error puesto que el fifo no puede estar vacio y lleno al mismo tiempo
				active_out=0;
				next_state=ERROR; 	
			end 
			
		end
		
		ERROR: begin
		//For ERROR state
			if(Fifo_errors != 00000)begin
				error_out=1;
				next_state=ERROR;
			end else begin
				error_out=0;
				next_state=RESET;
			end		
		end
		default: begin
			next_state= RESET;
			idle_out=0;
			active_out=0;
			error_out=0;
		end
	endcase	
end


endmodule

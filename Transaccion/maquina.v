module maquina#(parameter LENGTH = 1)
		(input clk,
		input reset,
		input [3:0] umbralMF,
		input [3:0] umbralVC,
		input [3:0] umbralD,
		input [4:0] Fifo_empties,
		input [4:0] Fifo_errors,
		input init,
		output reg init_out,
		output reg idle_out,
		output reg active_out,
		output reg error_out,
		output reg [3:0] umbralMF_out,
		output reg [3:0] umbralVC_out,
		output reg [3:0] umbralD_out,
		output reg [3:0] state, 
		output reg [3:0]next_state);

parameter RESET=0;
parameter INIT =1;
parameter IDLE =2;
parameter ACTIVE=3;
parameter ERROR=4;
reg update;

 always @ (posedge clk) begin
        if(reset) begin
            state <= RESET;
			umbralMF_out <= 0;
			umbralVC_out <= 0;
			umbralD_out <= 0;
          //  error_out <=0;
        end
        else begin
			if (update) begin
				umbralMF_out <= umbralMF;
				umbralVC_out <= umbralVC;
				umbralD_out <= umbralD;
			end
			else begin
				umbralMF_out <= umbralMF_out;
				umbralVC_out <= umbralVC_out;
				umbralD_out <= umbralD_out;
			end
            state <= next_state;
            
        end
    end		
reg [LENGTH-1:0] umbralMF_o, umbralVC_o, umbralD_o;
always @(*) begin
	idle_out = 0;
	active_out = 0;
	error_out = 0;
	next_state = state;
	init_out = 0;
	update = 0;
	case(state)
		RESET: begin
		//For RESET state
		if (reset)
			next_state = RESET;
		else
			next_state= INIT;
		end
		
		INIT: begin
		//For INIT state
			init_out=1;
			update = 1;
			next_state= IDLE;
		end
		
		IDLE: begin
		//For IDLE state
		if(init)
			next_state= INIT;
		else begin
			update = 0;
			if(Fifo_empties == 'b11111)begin 
				idle_out=1;
				next_state= IDLE;
			end else begin
				idle_out=0;
				next_state= ACTIVE;
			end 
		end
		end
		
		ACTIVE: begin
		//For ACTIVE state
		if (init == 1)
			next_state = INIT;
		else if (init == 0) begin
			if(Fifo_errors == 00000) begin //Si el fifo no esta ni lleno, ni vacio, osea que tiene informacion adentro que se puede transmitir
				active_out=1;
				next_state=ACTIVE;
			end else begin
			//Este caso generaria un error puesto que el fifo no puede estar vacio y lleno al mismo tiempo
				active_out=0;
				next_state=ERROR; 	
			end 
		end
			
		end
		
		ERROR: begin
		//For ERROR state
			if(Fifo_errors != 00000)begin
				error_out=1;
				next_state=ERROR;end
			if (reset) begin
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

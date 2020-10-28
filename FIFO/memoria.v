module memoria #(parameter BITNUMBER = 8,
			parameter LENGTH = 8)
(input [BITNUMBER-1:0] data_in,
	input [(LENGTH/2)-2:0] ptr_write,
	input [(LENGTH/2)-2:0] ptr_read,
	input reset, 
	input clk, 
	input read,
	input write,
	output reg [BITNUMBER-1:0] data_out);	

	reg [BITNUMBER-1:0] mem [LENGTH-1:0];
	integer k;

	always@(posedge clk) begin
		if(reset) begin
			for(k = 0; k<LENGTH ; k = k+1 )begin 
				mem[k] <= 'b0; //Se pone en bajo las posiciones en la memoria
			end
		end else begin  
			  	if (write) mem[ptr_write] <= data_in;//Escribimos el dato de entrada en la posicion
				
		end
	end

	always@(*) begin
		data_out = 0;
		if (read) data_out = mem[ptr_read];
	end


endmodule

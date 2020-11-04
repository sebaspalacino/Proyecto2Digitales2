module mux_dest #(parameter BITNUMBER = 5)
		(input clk,
		input reset,
		input [BITNUMBER-1:0] data_in0,
		input [BITNUMBER-1:0] data_in1,
		input valid_VC0,
		input valid_VC1,
		output reg valid_out_dest,
		output reg [BITNUMBER-1:0] data_out_dest);
		
		reg [5:0] ValueHold_Out;
		reg interValidValue;
		

always @(*) begin
	if(valid_VC0) begin
		ValueHold_Out = data_in0;
		interValidValue = valid_VC0;
	end else begin
	//If valid_VC0==0
		if(valid_VC1) begin
		//If valid_VC1 ==1
			ValueHold_Out= data_in1;
			interValidValue = valid_VC1;
		end else begin
		//If valid_VC1==0
			ValueHold_Out = 0;
			interValidValue = 0;	
		end
	end	
	
end		
	

always @(posedge clk)begin
	if(~reset) begin
		data_out_dest <=0;
	end else begin
	//If reset == 1
		valid_out_dest <= interValidValue;
		data_out_dest <= ValueHold_Out;
	end
end



endmodule

module demux_dest#(parameter BITNUMBER=5)
		(input clk,
		input reset,
		//input selector,
		input [BITNUMBER-1:0] data_in,
		input valid_in0,
		input valid_in1,
		output reg valid_out0,
		output reg valid_out1,
		output reg [BITNUMBER-1:0] data_out0,
		output reg [BITNUMBER-1:0] data_out1);

    reg [BITNUMBER-1:0] data_holdValue0;
    reg [BITNUMBER-1:0] data_holdValue1;
    reg valid_holdValue0;
    reg valid_holdValue1;
    
     always @(*) begin
    	if(valid_in0==1) begin
    	     data_holdValue0 = data_in;
            data_holdValue1 = 0;
            valid_holdValue0 = valid_in0;
            valid_holdValue1 = 0;
    	end else begin
    	//If valid_in0==0
    		if(valid_in1==1) begin
    			data_holdValue0 = 0;
            		data_holdValue1 = data_in;
            		valid_holdValue0 = 0;
            		valid_holdValue1 = valid_in1;
    		end else begin
    		//If valid_in1==0
    			 data_holdValue0= 0;
            		data_holdValue1 = 0;
            		valid_holdValue0 = 0;
            		valid_holdValue1= 0;
    		end
    	end
    	
    end


    always @(posedge clk) begin
    	if(~reset) begin 
    	     data_out0 <= 0;
            data_out1 <= 0;
            valid_out0 <= 0;
            valid_out1 <= 0;
    	end else begin
    	//If reset==1
    		data_out0 <= data_holdValue0;
            data_out1 <= data_holdValue1;
            valid_out0 <= valid_holdValue0;
            valid_out1 <= valid_holdValue1;
    	end
    end
    
    
endmodule

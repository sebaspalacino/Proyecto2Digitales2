module demux_id#(parameter BITNUMBER = 6,
			parameter LENGTH = 4*1)(
    input [BITNUMBER-1:0] Fifo_Data_out,
    input clk,
    input reset,
    input valid_read,
    output reg [BITNUMBER-1:0] demux_to_VC0,
    output reg [BITNUMBER-1:0] demux_to_VC1,
    output reg Fifo_wr0,
    output reg Fifo_wr1
    );

always @(posedge clk) begin
    if (reset) begin
        {Fifo_wr0, Fifo_wr1, demux_to_VC0, demux_to_VC1} <= 0;
    end
    else begin
        if (Fifo_Data_out[BITNUMBER-1] == 0 && valid_read) begin
            demux_to_VC0 <= Fifo_Data_out;
            Fifo_wr0 <= 1;
            Fifo_wr1 <= 0;
        end
        else if(Fifo_Data_out[BITNUMBER-1] == 1 && valid_read) begin
            demux_to_VC1 <= Fifo_Data_out;
            Fifo_wr1 <= 1;
            Fifo_wr0 <= 0;
        end
        else
            {Fifo_wr0, Fifo_wr1, demux_to_VC0, demux_to_VC1} <= 0;
    end
end
endmodule
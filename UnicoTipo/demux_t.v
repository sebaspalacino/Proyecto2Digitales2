module demux_t #(parameter BITNUMBER = 6)(
    input clk, 
    input reset,
    input [BITNUMBER-1:0] Mux_out,
    input Mux_valid,
    output reg [BITNUMBER-1:0] data_D0,
    output reg [BITNUMBER-1:0] data_D1,
    output reg push_D0,
    output reg push_D1
);

always @(posedge clk) begin
    if (reset)
        {push_D0, push_D1, data_D0, data_D1} <= 0;
    else begin
        if (Mux_valid) begin
            if (Mux_out[BITNUMBER-2])begin
                push_D1 <= 1;
                data_D1 <= Mux_out;
                push_D0 <= 0;
                data_D0 <= 0;
            end
            else begin
                push_D0 <= 1;
                data_D0 <= Mux_out;
                push_D1 <= 0;
                data_D1 <= 0;
            end
        end
        else 
            {push_D0, push_D1, data_D0, data_D1} <= 0;
    end
end

endmodule
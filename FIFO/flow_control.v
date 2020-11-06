module flow_control #(parameter BITNUMBER = 6,
			parameter LENGTH = 4*1)(
  input clk,
  input reset,
  input Fifo_rd,
  input Fifo_wr,
  input almost_full, 
  input almost_empty,
  input Fifo_full, 
  input Fifo_empty,
  output reg can_pop,
  output reg pause 
  );

always @(*) begin
    if (reset) begin
        {can_pop, pause} = 0;
    end
    else begin
        if (almost_full || Fifo_full)
            pause = 1;
        else
            pause = 0;
        if (almost_empty || Fifo_empty)
            can_pop = 0;
        else
            can_pop = 1;
    end
end

endmodule
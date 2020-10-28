`include "memoria.v"

module fifo #(parameter BITNUMBER = 8,
			parameter LENGTH = 8)(
  input [BITNUMBER-1:0] Fifo_Data_in,
  input clk,
  input reset,
  input Fifo_rd,
  input Fifo_wr,
  output reg  Fifo_full,
  output reg Fifo_empty,
  output reg [BITNUMBER-1:0] Fifo_Data_out,
  output reg Fifo_rd_error,
  output reg Fifo_wr_error,
  output reg almost_full, 
  output reg almost_empty
  );

reg to_empty;
reg [(LENGTH/2)-2:0] wr_ptr, rd_ptr;
reg [(LENGTH/2)-1:0] elementos, crecimiento;
wire [BITNUMBER-1:0] q1;
integer i, wptr, rptr;
always @(posedge clk) begin
    Fifo_Data_out <= q1;
    if (reset) begin
        {wr_ptr, rd_ptr, Fifo_rd_error} <= 0;
        elementos <= 0 ;
        crecimiento <= 0;
        to_empty <= 1;
    end
    else begin
        elementos <= (wr_ptr - rd_ptr + LENGTH) % LENGTH ;
        crecimiento <= elementos;
        if (elementos > crecimiento) // se esta llenando
            to_empty <= 0;
        if (elementos < crecimiento)//se esta vaciando
            to_empty <= 1;
        if (elementos == crecimiento)
            to_empty <= to_empty;

        if (Fifo_wr) begin
            wr_ptr <= wr_ptr + 1;
        end

        if(Fifo_rd && !Fifo_empty) begin
            rd_ptr <= rd_ptr + 1;
            Fifo_rd_error <= 0; 
            end
    end
end


always @(*) begin
    elementos = (wr_ptr - rd_ptr + LENGTH) % LENGTH ;
    Fifo_empty = 0;
    Fifo_full = 0;
    {almost_empty, almost_full} = 0;
    if(elementos == 0) begin
        if (to_empty) begin
            Fifo_empty = 1;
            wr_ptr = 0;
            rd_ptr = 0;
        end
        else 
            Fifo_full = 1;
            to_empty = 1;
    end
    if(elementos == 1) begin
        almost_empty = 1;
    end;
    if(elementos == 7) begin
        almost_full = 1;
    end;
end



memoria memoria(.data_in	(Fifo_Data_in),
		.data_out	(q1),
		.ptr_write	(wr_ptr),
		.ptr_read	(rd_ptr),
		.clk		(clk),
		.reset		(reset),
		.read		(Fifo_rd),
		.write		(Fifo_wr));

endmodule
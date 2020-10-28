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
  output reg Fifo_error,
  output reg almost_full, 
  //output reg [2:0] rd_ptr,
  output reg almost_empty
  );

reg to_empty, q_wt, q_rd;
reg [(LENGTH/2)-2:0] rd_ptr, wr_ptr,  q_w, q_r;
reg [(LENGTH/2)-1:0] elementos, crecimiento;
wire [BITNUMBER-1:0] q1;
reg [BITNUMBER-1:0] q0;

always @(posedge clk) begin
    if (reset) begin
        {wr_ptr, rd_ptr, Fifo_rd_error, Fifo_wr_error} <= 0;
        elementos <= 0 ;
        crecimiento <= 0;
        to_empty <= 1;
        q0 <= 0;
        Fifo_Data_out <= 0;
        q_w <= 0;
        q_wt <= 0;
        Fifo_empty <= 0;
        Fifo_full <= 0;
    end
    else begin
        q_w <= wr_ptr;
        q_r <= rd_ptr;
        q_rd <= Fifo_rd;
        q_wt <= Fifo_wr;
        elementos <= (wr_ptr - rd_ptr + LENGTH) % LENGTH ;
        crecimiento <= elementos;
        Fifo_Data_out <= q1;
        if (elementos != 0 && crecimiento != 0)begin
           if (elementos > crecimiento) // se esta llenando
            to_empty <= 0;
        if (elementos < crecimiento)//se esta vaciando
            to_empty <= 1;
        if (elementos == crecimiento)
            to_empty <= to_empty; 
        end

        if (Fifo_wr && !Fifo_full) begin
            wr_ptr <= wr_ptr + 1;
            Fifo_wr_error <= 0;
            q0 <= Fifo_Data_in; 
        end
        else if (Fifo_wr && Fifo_full) begin
            Fifo_wr_error <= 1;
            q0 <= q0;
        end 
        else begin
         Fifo_wr_error <= 0;
         q0 <= q0;
        end
        if(Fifo_rd && !Fifo_empty) begin
            rd_ptr <= rd_ptr + 1;
            Fifo_rd_error <= 0; 
            Fifo_Data_out <= q1;
            //invalid_read <= 0;
            end
        if(Fifo_rd && Fifo_empty)
            Fifo_rd_error <= 1;
        else 
            Fifo_rd_error <= 0; // si comento esto la señal se mantiene hasta el proximo read sin error
        /*else 
            invalid_read <= 1;*/
    end
end


always @(*) begin
    elementos = (wr_ptr - rd_ptr + LENGTH) % LENGTH ;
    Fifo_empty = 0;
    Fifo_full = 0;
    {almost_empty, almost_full} = 0;
    Fifo_error = 0;
    if (reset) begin
        elementos = 0;
        Fifo_empty = 0;
        Fifo_full = 0;
        {almost_empty, almost_full} = 0;
        to_empty = 0;
    end
    else begin
        if(elementos == 0) begin
            if (to_empty) begin
                Fifo_empty = 1;
                to_empty = 1;
                //wr_ptr = 0;
                //rd_ptr = 0;
            end
        else 
            Fifo_full = 1;
            //to_empty = 0;
    end
    if(elementos == 1) begin
        almost_empty = 1;
    end
    if(elementos == 7) begin
        almost_full = 1;
    end
    Fifo_error = Fifo_rd_error | Fifo_wr_error; 
    end
end

memoria memoria(.data_in	(q0),
		.data_out	(q1),
		.ptr_write	(wr_ptr),
		.ptr_read	(rd_ptr),
		.clk		(clk),
		.reset		(reset),
		.read		(q_rd),
		.write		(q_wt));

endmodule
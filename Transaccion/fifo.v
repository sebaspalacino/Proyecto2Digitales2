`include "memoria.v"
`include "flow_control.v"
module fifo #(parameter BITNUMBER = 6,
			parameter LENGTH = 4*1)(
  input [BITNUMBER-1:0] Fifo_Data_in,
  input clk,
  input reset,
  input Fifo_rd,
  input Fifo_wr,
  input [2:0]Umbral,
  output reg  Fifo_full,
  output reg Fifo_empty,
  output reg [BITNUMBER-1:0] Fifo_Data_out,
  output reg Fifo_rd_error,
  output reg Fifo_wr_error,
  output  Fifo_error,
  output reg almost_full, 
  output reg almost_empty,
  output wire can_pop,
  output wire pause, 
  output reg valid_read
  );

reg to_empty, q_wt, q_rd, v1;
reg [((LENGTH/6)+(1)):0] rd_ptr, wr_ptr,  q_w, q_r; // Formula magica que deja un indice que se redondea a 1 (1.67) cuando LENGTH = 4 y a 3 (3.67) cuando LENGTH = 16.
reg [(LENGTH/4)+1:0] elementos, contador;
wire [BITNUMBER-1:0] q1;
reg [BITNUMBER-1:0] q0;

always @(posedge clk) begin
    if (reset) begin
        {wr_ptr, rd_ptr, Fifo_rd_error, Fifo_wr_error, /*Fifo_error,*/ Fifo_full, /*Fifo_Data_out,*/ almost_empty, almost_full, valid_read, elementos} <= 0;
        Fifo_Data_out <= 0;
        Fifo_empty <= 1;
        contador <= 0;
        almost_empty <= 0;
        valid_read <= 0;
        q0 <= 0;
        q_w <= 0;
        q_wt <= 0;
        v1 <= 0;
    end
    else begin
        q_w <= wr_ptr;
        q_r <= rd_ptr;
        q_rd <= Fifo_rd;
        q_wt <= Fifo_wr;
        elementos <= (wr_ptr - rd_ptr + LENGTH) % LENGTH ;
        Fifo_Data_out <= q1;
        valid_read <= v1;

        if (Fifo_wr && !Fifo_full) begin
            wr_ptr <= wr_ptr + 1;
            contador = contador +1;
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
        if(Fifo_rd && !Fifo_empty) begin // pop
            rd_ptr <= rd_ptr + 1;
            contador = contador -1;
            Fifo_rd_error <= 0; 
            //Fifo_Data_out <= q1;
            v1 <= 1;
            end
        else v1 <= 0;
        if(Fifo_rd && Fifo_empty)
            Fifo_rd_error <= 1;
        else begin
            Fifo_rd_error <= 0; // si comento esto la señal se mantiene hasta el proximo read sin error
        end 
        if (contador == LENGTH)
            Fifo_full <= 1;
        else 
            Fifo_full <= 0;
        if (contador == 0)
            Fifo_empty <= 1;
        else
            Fifo_empty <= 0;
        if (contador == LENGTH - Umbral)
            almost_full <= 1;
        else 
            almost_full <= 0;
        if (contador == Umbral)
            almost_empty <= 1;
        else
            almost_empty <= 0;
        //Fifo_error <= Fifo_rd_error | Fifo_wr_error; 
    end
end
assign Fifo_error = Fifo_rd_error | Fifo_wr_error; 
memoria #(.BITNUMBER(BITNUMBER), .LENGTH(LENGTH)) memoria (.data_in	(q0),
		.data_out	(q1),
		.ptr_write	(wr_ptr),
		.ptr_read	(rd_ptr),
		.clk		(clk),
		.reset		(reset),
		.read		(q_rd),
		.write		(q_wt));
flow_control #(.BITNUMBER(BITNUMBER), .LENGTH(LENGTH)) flow_c_ (
        .clk            (clk),
        .reset          (reset),
        .Fifo_rd        (Fifo_rd),
        .Fifo_wr        (Fifo_wr),
        .almost_full    (almost_full), 
        .almost_empty   (almost_empty),
        .Fifo_full      (Fifo_full),
        .Fifo_empty     (Fifo_empty),
        .can_pop        (can_pop),
        .pause          (pause));
endmodule
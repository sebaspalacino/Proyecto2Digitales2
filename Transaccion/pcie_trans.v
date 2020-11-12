`include "fifo.v"
`include "demux_id.v"
`include "mux_dst.v"
`include "demux_t.v"
`include "maquina.v"
module pcie_trans#(parameter BITNUMBER = 6,
			parameter LENGTH = 4)(
    input [BITNUMBER-1:0] data_in,
    input clk,
    input reset,
    input push,
    input pop_D0,
    input pop_D1,
	input [LENGTH-1:0] Umbral_MF_prob,
	input [LENGTH-1:0] Umbral_VC_prob,
	input [LENGTH-1:0] Umbral_D_prob,
	input init,
    output wire [BITNUMBER-1:0] data_out0,
    output wire [BITNUMBER-1:0] data_out1,
    output wire D0_can_pop,
    output wire D1_can_pop,
	output wire Main_pause, 
	output wire [3:0] state,
	output wire [3:0] next_state
    );


//Wires
wire Main_fifo_full, Main_fifo_empty, Main_Fifo_rd_error, Main_Fifo_wr_error, Main_Fifo_error, Main_almost_full, Main_almost_empty, Main_can_pop,/* Main_pause ,*/ Main_valid_read;
wire VC0_full, VC0_empty, VC0_rd_error, VC0_wr_error, VC0_error, VC0_almost_full, VC0_almost_empty, VC0_can_pop, VC0_pause , VC0_valid_read;
wire VC1_full, VC1_empty, VC1_rd_error, VC1_wr_error, VC1_error, VC1_almost_full, VC1_almost_empty, VC1_can_pop, VC1_pause , VC1_valid_read;
wire D0_full, D0_empty, D0_rd_error, D0_wr_error, D0_error, D0_almost_full, D0_almost_empty, /*D0_can_pop,*/ D0_pause , D0_valid_read;
wire D1_full, D1_empty, D1_rd_error, D1_wr_error, D1_error, D1_almost_full, D1_almost_empty, /*D1_can_pop,*/ D1_pause , D1_valid_read;
wire Mux_valid;
wire pop_main, push_VC0, push_VC1, push_D0, push_D1, pop_VC0, pop_VC1, pop_D0, pop_D1;
wire [BITNUMBER-1:0] Main_Fifo_Data_out, demux_to_VC0, demux_to_VC1, Mux_out, VC0_Data_out, VC1_Data_out, demux_to_D0, demux_to_D1;
wire [4:0] Fifo_empties, Fifo_error;
wire [LENGTH-1:0] Umbral_MF, Umbral_VC, Umbral_D;
wire idle_out, active_out, error_out;
//wire [3:0] state, next_state;
//wire [LENGTH-1:0] Umbral_MF_prob, Umbral_VC_prob, Umbral_D_prob;

fifo #(.BITNUMBER (BITNUMBER), .LENGTH (LENGTH))Main_fifo_(
						      // Outputs
						      .Fifo_full	    (Main_fifo_full),
						      .Fifo_empty	    (Main_fifo_empty),
						      .Fifo_Data_out	(Main_Fifo_Data_out[BITNUMBER-1:0]),
						      .Fifo_rd_error	(Main_Fifo_rd_error),
						      .Fifo_wr_error	(Main_Fifo_wr_error),
						      .Fifo_error	    (Main_Fifo_error),
						      .almost_full	    (Main_almost_full),
						      .almost_empty	    (Main_almost_empty),
						      .can_pop		    (Main_can_pop),
						      .pause		    (Main_pause),
						      .valid_read	    (Main_valid_read),
						      // Inputs
						      .Fifo_Data_in	    (data_in[BITNUMBER-1:0]),
						      .clk		        (clk),
							  .Umbral			(Umbral_MF[LENGTH-1:0]),
						      .reset		    (reset),
						      .Fifo_rd		    (pop_main),/****/
						      .Fifo_wr		    (push));

demux_id demux_id_(
	// Outputs
    .demux_to_VC0	(demux_to_VC0[BITNUMBER-1:0]),
    .demux_to_VC1	(demux_to_VC1[BITNUMBER-1:0]),
    .Fifo_wr0		(push_VC0),
	.Fifo_wr1		(push_VC1),
	// Inputs
	.Fifo_Data_out 	(Main_Fifo_Data_out[BITNUMBER-1:0]),
    .clk			(clk),
    .reset			(reset),
    .valid_read		(Main_valid_read)
);

fifo #(.BITNUMBER (BITNUMBER), .LENGTH (LENGTH*4))VC0_(
						      // Outputs
						      .Fifo_full	    (VC0_full),
						      .Fifo_empty	    (VC0_empty),
						      .Fifo_Data_out	(VC0_Data_out[BITNUMBER-1:0]),
						      .Fifo_rd_error	(VC0_rd_error),
						      .Fifo_wr_error	(VC0_wr_error),
						      .Fifo_error	    (VC0_error),
						      .almost_full	    (VC0_almost_full),
						      .almost_empty	    (VC0_almost_empty),
						      .can_pop		    (VC0_can_pop),
						      .pause		    (VC0_pause),
						      .valid_read	    (VC0_valid_read),
						      // Inputs
						      .Fifo_Data_in	    (demux_to_VC0[BITNUMBER-1:0]),
						      .clk		        (clk),
							  .Umbral			(Umbral_VC[4*LENGTH-1:0]),
						      .reset		    (reset),
						      .Fifo_rd		    (pop_VC0),/****/
						      .Fifo_wr		    (push_VC0));

fifo #(.BITNUMBER (BITNUMBER), .LENGTH (LENGTH*4))VC1_(
						      // Outputs
						      .Fifo_full	    (VC1_full),
						      .Fifo_empty	    (VC1_empty),
						      .Fifo_Data_out	(VC1_Data_out[BITNUMBER-1:0]),
						      .Fifo_rd_error	(VC1_rd_error),
						      .Fifo_wr_error	(VC1_wr_error),
						      .Fifo_error	    (VC1_error),
						      .almost_full	    (VC1_almost_full),
						      .almost_empty	    (VC1_almost_empty),
						      .can_pop		    (VC1_can_pop),
						      .pause		    (VC1_pause),
						      .valid_read	    (VC1_valid_read),
						      // Inputs
						      .Fifo_Data_in	    (demux_to_VC1[BITNUMBER-1:0]),
						      .clk		        (clk),
							  .Umbral			(Umbral_VC[4*LENGTH-1:0]),
						      .reset		    (reset),
						      .Fifo_rd		    (pop_VC1),/****/
						      .Fifo_wr		    (push_VC1));

mux_dst #(.BITNUMBER (BITNUMBER))Mux_(
                            // Outputs
                            .valid_out_dest    (Mux_valid),
                            .data_out_dest      (Mux_out[BITNUMBER-1:0]),
                            // Inputs
                            .clk                (clk),
                            .reset              (reset),
                            .data_in0           (VC0_Data_out[BITNUMBER-1:0]),
                            .data_in1           (VC1_Data_out[BITNUMBER-1:0]),
                            .valid_VC0          (VC0_valid_read),
                            .valid_VC1          (VC1_valid_read));

demux_t #(.BITNUMBER (BITNUMBER)) demux_(
                            // Outputs
                            .data_D0        (demux_to_D0[BITNUMBER-1:0]),
                            .data_D1        (demux_to_D1[BITNUMBER-1:0]),
                            .push_D0        (push_D0),
                            .push_D1        (push_D1),
                            // Inputs
                            .clk            (clk), 
                            .reset          (reset),
                            .Mux_out        (Mux_out[BITNUMBER-1:0]),
                            .Mux_valid      (Mux_valid));

fifo #(.BITNUMBER (BITNUMBER), .LENGTH (LENGTH))D0_(
						      // Outputs
						      .Fifo_full	    (D0_full),
						      .Fifo_empty	    (D0_empty),
						      .Fifo_Data_out	(data_out0[BITNUMBER-1:0]),
						      .Fifo_rd_error	(D0_rd_error),
						      .Fifo_wr_error	(D0_error), // (D0_wr_error)
						      .Fifo_error	    (D0_wr_error),		//(D0_error)
						      .almost_full	    (D0_almost_full),
						      .almost_empty	    (D0_almost_empty),
						      .can_pop		    (D0_can_pop),
						      .pause		    (D0_pause),
						      .valid_read	    (D0_valid_read),
						      // Inputs
						      .Fifo_Data_in	    (demux_to_D0[BITNUMBER-1:0]),
						      .clk		        (clk),
							  .Umbral			(Umbral_D[LENGTH-1:0]),
						      .reset		    (reset),
						      .Fifo_rd		    (pop_D0),/****/
						      .Fifo_wr		    (push_D0));

fifo #(.BITNUMBER (BITNUMBER), .LENGTH (LENGTH))D1_(
						      // Outputs
						      .Fifo_full	    (D1_full),
						      .Fifo_empty	    (D1_empty),
						      .Fifo_Data_out	(data_out1[BITNUMBER-1:0]),
						      .Fifo_rd_error	(D1_rd_error),
						      .Fifo_wr_error	(D1_error),//(D1_wr_error),
						      .Fifo_error	    (D1_wr_error),//(D1_error)
						      .almost_full	    (D1_almost_full),
						      .almost_empty	    (D1_almost_empty),
						      .can_pop		    (D1_can_pop),
						      .pause		    (D1_pause),
						      .valid_read	    (D1_valid_read),
						      // Inputs
						      .Fifo_Data_in	    (demux_to_D1[BITNUMBER-1:0]),
						      .clk		        (clk),
							  .Umbral			(Umbral_D[LENGTH-1:0]),
						      .reset		    (reset),
						      .Fifo_rd		    (pop_D1),/****/
						      .Fifo_wr		    (push_D1));

maquina #(.LENGTH (LENGTH))maquina_(
							// Outputs
							.init_out		(init_out),
							.idle_out		(idle_out),
							.active_out		(active_out),
							.error_out		(error_out),
							// .umbralMF_out 	(Umbral_MF[LENGTH-1:0]),
							// .umbralVC_out	(Umbral_VC[LENGTH-1:0]),
							// .umbralD_out	(Umbral_D[LENGTH-1:0]),
							.state			(state[3:0]),
							.next_state		(next_state[3:0]),
							// Inputs
							.init			(init),
							.clk 			(clk),
							.reset			(reset),
							.umbralMF		(Umbral_MF_prob [LENGTH-1:0]),
							.umbralVC		(Umbral_VC_prob [LENGTH-1:0]),
							.umbralD		(Umbral_D_prob [LENGTH-1:0]),
							.Fifo_empties	(Fifo_empties [4:0]),
							.Fifo_errors	(Fifo_error [4:0]));

assign pop_main = !(VC0_pause || VC1_pause) && !(Main_fifo_empty); 
assign pop_VC0 = !(D0_pause || D1_pause) && !(VC0_empty); 
assign pop_VC1 = !(D0_pause || D1_pause) && !(VC1_empty) && (VC0_empty); 

// Para la maquina de estados
assign Umbral_D = 1;
assign Umbral_VC = 3;
assign Umbral_MF = 1;

assign Fifo_empties[0] = Main_fifo_empty;
assign Fifo_empties[1] = VC0_empty;
assign Fifo_empties[2] = VC1_empty;
assign Fifo_empties[3] = D0_empty;
assign Fifo_empties[4] = D1_empty;

assign Fifo_error[0] = Main_Fifo_error;
assign Fifo_error[1] = VC0_error;
assign Fifo_error[2] = VC1_error;
assign Fifo_error[3] = D0_error;
assign Fifo_error[4] = D1_error;
endmodule
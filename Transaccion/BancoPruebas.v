`timescale 1ns / 100ps
`include "pcie_trans.v"
`include "pcie_trans_est.v"
`include "probador.v"
`include "cmos_cells.v"

module BancoPruebas;

//Parametros
parameter BITNUMBER = 6;
parameter LENGTH = 4;

//Wires
wire clk, reset, push, pop_D1, pop_D0, D0_can_pop, D1_can_pop, Main_pause, init;
wire /*push, pop_D1, pop_D0,*/ D0_can_pop_est, D1_can_pop_est, Main_pause_est;
wire [BITNUMBER-1:0] data_in, data_out0, data_out1,data_out0_est, data_out1_est;
wire [LENGTH-1:0] Umbral_MF_prob, Umbral_VC_prob, Umbral_D_prob;
wire [3:0] state, next_state, next_state_est, state_est;

pcie_trans #(.BITNUMBER (BITNUMBER), .LENGTH (LENGTH))pcie_(/*AUTOINST*/
							    // Outputs
							    .data_out0		(data_out0[BITNUMBER-1:0]),
							    .data_out1		(data_out1[BITNUMBER-1:0]),
							    .D0_can_pop		(D0_can_pop),
							    .D1_can_pop		(D1_can_pop),
							    .Main_pause		(Main_pause),
							    .state		(state[3:0]),
							    .next_state		(next_state[3:0]),
							    // Inputs
							    .data_in		(data_in[BITNUMBER-1:0]),
							    .clk		(clk),
							    .reset		(reset),
							    .push		(push),
							    .pop_D0		(pop_D0),
							    .pop_D1		(pop_D1),
							    .Umbral_MF_prob	(Umbral_MF_prob[LENGTH-1:0]),
							    .Umbral_VC_prob	(Umbral_VC_prob[LENGTH-1:0]),
							    .Umbral_D_prob	(Umbral_D_prob[LENGTH-1:0]),
							    .init		(init));

pcie_trans_est pcie_est(/*AUTOINST*/
			// Outputs
			.D0_can_pop_est	(D0_can_pop_est),
			.D1_can_pop_est	(D1_can_pop_est),
			.Main_pause_est	(Main_pause_est),
			.data_out0_est	(data_out0_est[5:0]),
			.data_out1_est	(data_out1_est[5:0]),
			.next_state_est	(next_state_est[3:0]),
			.state_est	(state_est[3:0]),
			// Inputs
			.Umbral_D_prob	(Umbral_D_prob[3:0]),
			.Umbral_MF_prob	(Umbral_MF_prob[3:0]),
			.Umbral_VC_prob	(Umbral_VC_prob[3:0]),
			.clk		(clk),
			.data_in	(data_in[5:0]),
			.init		(init),
			.pop_D0		(pop_D0),
			.pop_D1		(pop_D1),
			.push		(push),
			.reset		(reset));


probador #(.BITNUMBER (BITNUMBER), .LENGTH (LENGTH))probador_(/*AUTOINST*/
							      // Outputs
							      .reset		(reset),
							      .clk		(clk),
							      .push		(push),
							      .pop_D1		(pop_D1),
							      .pop_D0		(pop_D0),
							      .data_in		(data_in[BITNUMBER-1:0]),
							      .Umbral_MF_prob	(Umbral_MF_prob[LENGTH-1:0]),
							      .Umbral_VC_prob	(Umbral_VC_prob[LENGTH-1:0]),
							      .Umbral_D_prob	(Umbral_D_prob[LENGTH-1:0]),
							      .init		(init),
							      // Inputs
							      .Main_pause	(Main_pause),
							      .D0_can_pop	(D0_can_pop),
							      .D1_can_pop	(D1_can_pop));

endmodule

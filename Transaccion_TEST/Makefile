CC = iverilog
TARGET1 = resultados.vcd
TARGET2 = pcie
TARGET3 = BancoPruebas.v
TARGET4 = prueba.gtkw
TEMP01 = pcie_trans_est.v

fifo: YOSYS1
	@echo "Realizando auto-instanciación..."

	emacs --batch $(TARGET3) -f verilog-batch-auto 

	@echo "Compilando Verilog"

	$(CC) -o $(TARGET2) $(TARGET3)
	vvp $(TARGET2)

YOSYS1:
	@echo "Sintetizando..."
	yosys -s pcie_synth.tcl
	sed -i 's/pcie_trans/pcie_trans_est/g' $(TEMP01)
	sed -i 's/data_out0/data_out0_est/g' $(TEMP01)
	sed -i 's/data_out1/data_out1_est/g' $(TEMP01)
	sed -i 's/D0_can_pop/D0_can_pop_est/g' $(TEMP01)
	sed -i 's/D1_can_pop/D1_can_pop_est/g' $(TEMP01)
	sed -i 's/Main_pause/Main_pause_est/g' $(TEMP01)
	sed -i 's/fifo/fifo_est/g' $(TEMP01)
	sed -i 's/demux_id/demux_id_est/g' $(TEMP01)
	sed -i 's/demux_t/demux_t_est/g' $(TEMP01)
	sed -i 's/mux_dst/mux_dst_est/g' $(TEMP01)
	sed -i 's/state/state_est/g' $(TEMP01)
	sed -i 's/next_state_dst/next_state_est/g' $(TEMP01)
wave:
	gtkwave $(TARGET4)

clean:
	rm -f $(TARGET2) $(TARGET1)
	rm -f *est*
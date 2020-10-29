CC = iverilog
TARGET1 = resultados.vcd
TARGET2 = fifo
TARGET3 = BancoPruebas.v
TARGET4 = pruebas.gtkw
TEMP01 = fifo_est.v

fifo: YOSYS1
	@echo "Realizando auto-instanciación..."

	emacs --batch $(TARGET3) -f verilog-batch-auto 

	@echo "Compilando Verilog"

	$(CC) -o $(TARGET2) $(TARGET3)
	vvp $(TARGET2)

YOSYS1:
	@echo "Sintetizando..."
	yosys -s fifo_synth.tcl
	sed -i 's/fifo/fifo_est/g' $(TEMP01)
	sed -i 's/memoria/memoria_est/g' $(TEMP01)
	sed -i 's/Fifo_Data_out/Fifo_Data_out_est/g' $(TEMP01)
	sed -i 's/Fifo_full/Fifo_full_est/g' $(TEMP01)
	sed -i 's/Fifo_empty/Fifo_empty_est/g' $(TEMP01)
	sed -i 's/Fifo_error/Fifo_error_est/g' $(TEMP01)
	sed -i 's/Fifo_rd_error/Fifo_rd_error_est/g' $(TEMP01)
	sed -i 's/Fifo_wr_error/Fifo_wr_error_est/g' $(TEMP01)
	sed -i 's/almost_full/almost_full_est/g' $(TEMP01)
	sed -i 's/almost_empty/almost_empty_est/g' $(TEMP01)
	sed -i 's/valid_read/valid_read_est/g' $(TEMP01)

wave:
	gtkwave $(TARGET4)

clean:
	rm -f $(TARGET2) $(TARGET1)
	rm -f *est*
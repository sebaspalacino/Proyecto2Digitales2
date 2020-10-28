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
	# yosys -s synth.tcl
	# sed -i 's/maquina/maquina_est/g' $(TEMP01)
	# sed -i 's/data_out/data_out_est/g' $(TEMP01)
	# sed -i 's/control/control_est/g' $(TEMP01)
	# sed -i 's/error/error_est/g' $(TEMP01)
	# sed -i 's/nxt_err/nxt_err_est/g' $(TEMP01)
	# sed -i 's/estado/estado_est/g' $(TEMP01)
	# sed -i 's/word_box/word_box_est/g' $(TEMP01)
wave:
	gtkwave $(TARGET4)

clean:
	rm -f $(TARGET2) $(TARGET1)
	rm -f *est*
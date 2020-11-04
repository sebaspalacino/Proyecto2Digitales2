
maquina:
	yosys -s ./maquina_synth.ys
	sed -i 's/module maquina/module maquina_synth/' maquina_synth.v
	sed -i 's/state/state_estr/' maquina_synth.v
	sed -i 's/next_state/next_state_estr/' maquina_synth.v
	sed -i 's/next_state_estr_estr/next_state_estr/' maquina_synth.v
	iverilog -o out ./BancoPruebas.v
	vvp out

	gtkwave ./resultados.vcd

clean:
	rm ./*.vcd ./out

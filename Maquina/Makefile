
maquina:
	yosys -s ./maquina_synth.ys
	sed -i 's/module maquina/module maquina_synth/' maquina_synth.v
	iverilog -o out ./BancoPruebas.v
	vvp out

	gtkwave ./resultados.vcd

clean:
	rm ./*.vcd ./out


memory:
	yosys -s ./memoria_synth.ys
	sed -i 's/module memoria/module memoria_synth/' memoria_synth.v
	iverilog -o out ./BancoPruebas.v
	vvp out

	gtkwave ./resultados.vcd

clean:
	rm ./*.vcd ./out

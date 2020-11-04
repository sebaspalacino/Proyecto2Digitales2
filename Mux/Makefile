
mux:
	yosys -s ./mux_dest_synth.ys
	sed -i 's/module mux_dest/module mux_dest_synth/' mux_dest_synth.v
	iverilog -o out ./BancoPruebas.v
	vvp out

	gtkwave ./resultados.vcd

clean:
	rm ./*.vcd ./out

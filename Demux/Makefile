
demux:
	yosys -s ./demux_dest_synth.ys
	sed -i 's/module demux_dest/module demux_dest_synth/' demux_dest_synth.v
	iverilog -o out ./BancoPruebas.v
	vvp out

	gtkwave ./resultados.vcd

clean:
	rm ./*.vcd ./out

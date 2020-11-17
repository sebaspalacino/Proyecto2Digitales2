# Proyecto2Digitales2
Design for the transaction layer of a PCIe

Organización de los directorios:

- Demux: Código del demultiplexor utilizado.
- Maquina: Maquina de estados. 
- Transaccion: Código de toda la interconexión realizada y una prueba de su funcionamiento. Utilizar make para compilar y make wave para ver el archivo de onda. 
- verif_LD: Contiene la prueba de llenado y vaciado de los FIFOS y la prueba de forzar un error mediante el sobrellenado del FIFO principal. Utilizar make para compilar y luego make wave para observar el archivo de onda con las pruebas. 

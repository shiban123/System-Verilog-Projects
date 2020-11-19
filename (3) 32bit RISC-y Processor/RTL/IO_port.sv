module IOPORT (IO_PORT, PORT_DATA, PORT_DIR, PORT_RD);

parameter SIZE = 8;
input [SIZE - 1:0] PORT_DATA;
input PORT_DIR, PORT_RD;
inout wire [SIZE -1:0] IO_PORT;
 
assign IO_PORT = (PORT_DIR && !PORT_RD) ? PORT_DATA : 'bz;
endmodule
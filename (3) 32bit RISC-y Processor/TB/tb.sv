`timescale 1 ns/ 1 ns
module tb_RISCY();
reg CLK, RST;
wire [7:0] IO;
RISCY UUT(CLK, RST, IO);
initial
forever #1 CLK = ~CLK;

initial
$monitorb("%d CLK = %b RST = %b IO = %b ROM_OUT = %b ROM_ADDR = %b INSTR = %b RAM_OUT = %b RAM_DATA = %b DIR = %b PORT_DATA = %b A = %b B = %b ALU_OUT = %b DATA = %b IR_EN = %b A_EN = %b B_EN =%b PDR_EN = %b PORT_EN = %b PORT_RD = %b PC_EN = %b PC_LOAD = %b ALU_EN = %b ALU_OE = %b RAM_OE = %b RAM _CS = %b RDR_EN = %b ", $time, CLK, RST, IO,
UUT.ROM_OUT, UUT.ROM_ADDR, UUT.INSTR, UUT.RAM_OUT, UUT.RAM_DATA,
UUT.DIRECTION, UUT.PORT_DATA, UUT.A, UUT.B, UUT.ALU_OUT, UUT.DATA,
UUT.IR_EN, UUT.A_EN, UUT.B_EN, UUT.PDR_EN, UUT.PORT_EN, UUT.PORT_RD,
UUT.PC_EN, UUT.PC_LOAD, UUT.ALU_EN, UUT.ALU_OE, UUT.RAM_OE,
UUT.RAM_CS, UUT.RDR_EN);

assign IO = (UUT.DIRECTION && !UUT.PORT_RD) ? UUT.PORT_DATA : 'bz;

initial begin
$vcdpluson;
$readmemb("mem.txt", UUT.ROM.MEM);

CLK = 1'b0; RST = 1'b1;
#2 RST = 1'b0;
#2 RST = 1'b1;
#20 RST = 1'b0;
#2 RST = 1'b1;
#20 RST = 1'b0;
#2 RST = 1'b1;
#20 RST = 1'b0;
#2 RST = 1'b1;
#20 RST = 1'b0;
/*#2 RST = 1'b1;
#20 RST = 1'b0;
#2 RST = 1'b1;*/
#20 $finish;
end
endmodule

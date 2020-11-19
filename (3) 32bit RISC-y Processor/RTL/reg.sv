`timescale 1 ns / 1 ns
module REG_FILE(DATA,ADDR,OE,WS,CS);
parameter D_BUS = 8, A_BUS = 5;

//Port declaration
inout [D_BUS - 1:0] DATA;
input [A_BUS - 1:0] ADDR;
input OE, WS, CS;
reg [D_BUS - 1:0] MEM [0:31];

//Data bus remains in high impedance when OE is low and CS is high
assign DATA = !CS ? (OE ? MEM[ADDR] : 8'bz) :8'bz;

//module definition
always@(posedge WS)begin //contents of data bus is written to address on address bus when OE is low and at posedge of WS
if(!OE)
MEM[ADDR] <= DATA;
else
MEM[ADDR] <= MEM [ADDR];
end
endmodule
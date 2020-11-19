`timescale 1 ns / 1 ns
module REG_WITHOUT_RESET (OUT,IN, EN, CLK);
parameter SIZE = 8;
input EN, CLK;
input [SIZE-1:0] IN;
output reg [SIZE-1:0] OUT;

always_ff @ (posedge CLK) 
if (EN)
OUT <= IN;
else
OUT <= OUT;
endmodule
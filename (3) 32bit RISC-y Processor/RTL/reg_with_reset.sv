`timescale 1 ns / 1 ns
module REG_WITH_RESET (OUT,IN, EN, CLK, RST);
parameter SIZE = 8;
input EN, CLK, RST;
input [SIZE-1:0] IN;
output [SIZE-1:0] OUT;

always_ff @ (posedge CLK or negedge RST) begin
if(!RST)
Out <= 0;
else if (EN)
Out <= In;
else
Out <= Out;
end
endmodule
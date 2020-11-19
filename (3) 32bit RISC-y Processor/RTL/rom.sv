`timescale 1 ns / 1 ns
module ROM (DATA, ADDR, OE, CS);
parameter D_BUS = 8, A_BUS = 5;
output reg [D_BUS - 1:0] DATA;
input [A_BUS - 1:0] ADDR;
input OE, CS;
reg [D_BUS - 1:0] MEM [0:31];

always_comb begin
if (!CS && OE)
DATA <= MEM[ADDR];
else
DATA <= 8'bz;
end
endmodule
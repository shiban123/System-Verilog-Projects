`timescale 1 ns / 1 ns
module BUFFER (OUT, IN, EN);
parameter SIZE = 8;
input [SIZE-1:0] IN;
input EN;
output [SIZE-1:0] OUT;

assign OUT = EN ? IN : 'z;
endmodule
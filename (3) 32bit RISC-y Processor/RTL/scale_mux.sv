`timescale 1ns/1ns 
module SCALE_MUX(A, B, SEL, OUT);
parameter SIZE = 1;
input [SIZE-1:0] A;
input [SIZE-1:0] B;
input SEL;
output reg [SIZE-1:0] OUT ;
reg [SIZE:0] i;

always@(A or B or SEL)
if (!SEL)
OUT = A;
else if (SEL)
OUT = B;
else
  for (i=0;i<SIZE;i=i+1)
  if (A[i]==B[i])
  OUT[i] = A[i];
  else OUT[i] = 1'bx;
endmodule

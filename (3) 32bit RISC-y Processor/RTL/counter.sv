`timescale 1 ns / 1 ns 

module COUNTER (COUNT, CLOCK, RESET, ENABLE, LOAD, DATA);
parameter WIDTH = 5;
input CLOCK, RESET, ENABLE, LOAD;
input [WIDTH-1:0] DATA;
output reg [WIDTH-1:0] COUNT;

always @(posedge CLOCK or negedge RESET)
begin
if ( !RESET ) // Asynchronous Reset
COUNT <= 'd0;
else if ( ENABLE ) //Active high Enable

  if ( LOAD ) // When load is high
  COUNT <= DATA;
  else 
  COUNT <= COUNT + 1; // Counter increment
  
else // Enable is low
COUNT <= COUNT; // Hold count
end 
endmodule

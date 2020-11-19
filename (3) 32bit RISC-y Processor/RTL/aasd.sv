`timescale 1 ns / 1 ns 

module AASD (AASD_RESET, CLOCK, RESET);
input CLOCK, RESET;
output reg AASD_RESET;

reg AASD_TEMP;

always @(posedge CLOCK or negedge RESET)
begin
if (!RESET) begin // Asynchronous reset
	AASD_RESET <= 0;
	AASD_TEMP <= 0;
	end
else begin
	AASD_TEMP <= RESET;
	AASD_RESET <= AASD_TEMP;
	end 
end

endmodule





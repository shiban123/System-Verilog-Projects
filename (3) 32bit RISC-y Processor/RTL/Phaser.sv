`timescale 1ns/1ns
module PHASER (CLK, RST, EN, PHASE);
import globe ::*;
input CLK,RST,EN;
output STATES PHASE;

always_ff@ (posedge CLK, negedge RST)
if (!RST)
PHASE <= PHASE.first;
else if (EN)
PHASE <= PHASE;
else
PHASE <= PHASE.next;

endmodule
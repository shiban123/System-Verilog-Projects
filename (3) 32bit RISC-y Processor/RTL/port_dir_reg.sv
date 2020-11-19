`timescale 1 ns/1 ns
module PORT_DIR_REG(DIR,DATA,PDR_EN,CLK,RST);
 input DATA,PDR_EN,CLK,RST;
 output reg DIR;
 
 always_ff @(posedge CLK, negedge RST)
 if(!RST) DIR <= 1'b0;
 else if(PDR_EN) DIR <= DATA;
 else DIR <= DIR ;
endmodule 

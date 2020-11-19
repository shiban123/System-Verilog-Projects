
`timescale 1ns/100ps
module ALU(CLK, EN, OE, OPCODE, A, B,ALU_OUT, CF, OF, SF, ZF);
parameter WIDTH = 8;
output reg [WIDTH - 1:0] ALU_OUT;
output reg CF, OF, SF, ZF;
input [3:0] OPCODE;
input [WIDTH - 1:0] A, B;
input CLK, EN, OE; 
localparam OP_ADD = 4'b0010,
		   OP_SUB = 4'b0011,
		   OP_AND = 4'b0100,
		   OP_OR = 4'b0101,
		   OP_XOR = 4'b0110,
		   OP_NOT = 4'b0111;
reg TCB;

always_ff@(posedge CLK) begin
if (!EN)
	begin
		ALU_OUT<= ALU_OUT;
	end

else if (!OE)
	ALU_OUT <= 8'bz;

else
	begin
	case (OPCODE)
	
	OP_ADD:
	begin
		{CF,ALU_OUT} <= A + B; //using concantenation to generate output and CF
	
		//overflow flag generation
		if (A[WIDTH - 1] && B[WIDTH - 1] && !ALU_OUT[WIDTH-1]) //when MSB of A and B are 1 and ALU_OUT is 0
				OF <= 1;
		else if (!A[WIDTH - 1] && !B[WIDTH - 1] && ALU_OUT[WIDTH-1]) //when MSB of A and B are 0 and ALU_OUT is 1
				OF <= 1;
		else 
				OF <= 0;
	end
		
	OP_SUB:
	begin
		ALU_OUT <= A - B; 
		
		//carry flag generation
		if (B>A)
			CF <= 1;
		else
			CF <= 0;
	
		//overflow flag generation
		if (A[WIDTH - 1] && B[WIDTH - 1] && !ALU_OUT[WIDTH-1]) //when MSB of A and B are 1 and ALU_OUT is 0
				OF <= 1;
		else if (!A[WIDTH - 1] && !B[WIDTH - 1] && ALU_OUT[WIDTH-1]) //when MSB of A and B are 0 and ALU_OUT is 1
				OF <= 1;
		else 
				OF <= 0;
	end
	
	OP_AND: begin ALU_OUT <= A & B; CF <=0; OF <= 0; end
	OP_OR: begin ALU_OUT <= A | B; CF <=0; OF <= 0; end
	OP_XOR: begin ALU_OUT <= A ^ B; CF <=0; OF <= 0; end
	OP_NOT: begin ALU_OUT <= ~A; CF <=0; OF <= 0; end
	default: ALU_OUT<=ALU_OUT; 
	endcase
	//sign flag generation
	if (ALU_OUT[WIDTH - 1] == 1)
		SF <= 1;
	else 
		SF <=0;
	//zero flag generation
	if (ALU_OUT == 0)
		ZF <= 1;
	else 
		ZF <=0;
	end
end
endmodule
	
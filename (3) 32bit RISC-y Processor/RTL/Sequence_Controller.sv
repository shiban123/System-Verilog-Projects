`timescale 1ns/1ns
module SEQUENCE_CONTROLLER (ADDR,OPCODE,PHASE,CF,OF,SF,ZF,IF,IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS);
import globe::*;
input [6:0] ADDR;
input [3:0] OPCODE;
input STATES PHASE;
input CF,OF,SF,ZF,IF;
output reg IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS;
reg LOAD_FLAG, STORE_FLAG, BRANCH_FLAG;

localparam  LOAD = 4'b0000,
			STORE = 4'b0001,
			OP_ADD = 4'b0010,
			OP_SUB = 4'b0011,
			OP_AND = 4'b0100,
			OP_OR = 4'b0101,
			OP_XOR = 4'b0110,
			OP_NOT = 4'b0111,
			B = 4'b1000,
			BZ = 4'b1001,
			BN = 4'b1010,
			BV = 4'b1011,
			BC = 4'b1100;
			
always@ (PHASE)
	case (PHASE)
	
	FETCH:begin
		RAM_CS = 0; // Enabling RAM (CS is active low)
		RAM_OE = 1; // Enabling output for RAM			
		IR_EN = 1; // Enabling memory instruction register
		
		//Rest of the outputs are low
		{A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RDR_EN} = 10'b0;
		end
		
	DECODE: 
				
		case (OPCODE)
		
		LOAD: begin
			LOAD_FLAG = 1'b1; // Load flag is set to 1
			
			//Rest of the outputs are low
			{IR_EN, A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 13'b0;
			end
			
		STORE: begin
			STORE_FLAG = 1'b1;
			
			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 13'b0;
			end
			
		OP_ADD: begin
			ALU_EN = 1'b1; //Enabling ALU to perform operation
			ALU_OE = 1'b1; //Enabling ALU outputs to drive data bus 

			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,RAM_OE,RDR_EN,RAM_CS} = 11'b0;
			end
			
		OP_SUB: begin
			ALU_EN = 1'b1; //Enabling ALU to perform operation
			ALU_OE = 1'b1; //Enabling ALU outputs to drive data bus 

			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,RAM_OE,RDR_EN,RAM_CS} = 11'b0;
			end
			
		OP_AND: begin
			ALU_EN = 1'b1; //Enabling ALU to perform operation
			ALU_OE = 1'b1; //Enabling ALU outputs to drive data bus 

			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,RAM_OE,RDR_EN,RAM_CS} = 11'b0;
			end
			
		OP_OR: begin
			ALU_EN = 1'b1; //Enabling ALU to perform operation
			ALU_OE = 1'b1; //Enabling ALU outputs to drive data bus 

			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,RAM_OE,RDR_EN,RAM_CS} = 11'b0;
			end
			
		OP_XOR: begin
			ALU_EN = 1'b1; //Enabling ALU to perform operation
			ALU_OE = 1'b1; //Enabling ALU outputs to drive data bus 

			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,RAM_OE,RDR_EN,RAM_CS} = 11'b0;
			end
			
		OP_NOT: begin
			ALU_EN = 1'b1; //Enabling ALU to perform operation
			ALU_OE = 1'b1; //Enabling ALU outputs to drive data bus 

			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,RAM_OE,RDR_EN,RAM_CS} = 11'b0;
			end
			
		B: begin
			BRANCH_FLAG = 1'b1; //unconditional branching
			
			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 13'b0;
			end

		BZ: begin
			if (ZF) //if zero flag is high, set branch flag
				BRANCH_FLAG = 1'b1;
			else
				BRANCH_FLAG = 1'b0;
				
			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 13'b0;
			end

		BN: begin
			if (SF) //if sign flag is high, set branch flag
				BRANCH_FLAG = 1'b1;
			else
				BRANCH_FLAG = 1'b0;
				
			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 13'b0;
			end
			
		BV: begin
			if (OF) //if overflow flag is high, set branch flag
				BRANCH_FLAG = 1'b1;
			else
				BRANCH_FLAG = 1'b0;
				
			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 13'b0;
			end
			
		BC: begin
			if (CF) //if carry flag is high, set branch flag
				BRANCH_FLAG = 1'b1;
			else
				BRANCH_FLAG = 1'b0;
				
			//Rest of the outputs are low
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 13'b0;
			end
		
		default:
			// all are set in Cycle 1
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 13'b1111111111110;
		
		endcase
		
	EXECUTE: begin
		if (LOAD_FLAG) 
			if (ADDR == 7'd64) begin
				A_EN = 1'b1; //Enabling A register
				
				if (IF)
					//Rest of the outputs are low
					{IR_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 12'b0;
					
				else begin
					RAM_OE = 1'b1; //enabling RAM output
					RDR_EN = 1'b1; //Enable writing to RAM Data Register 
					
					//Rest of the outputs are low
					{IR_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_CS} = 10'b0;
				end
			end

			else if (ADDR == 7'd65) begin
				B_EN = 1'b1; //Enabling A register
				
				if (IF)
					//Rest of the outputs are low
					{IR_EN,A_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 12'b0;
					
				else begin
					RAM_OE = 1'b1; //enabling RAM output
					RDR_EN = 1'b1; //Enable writing to RAM Data Register 
					
					//Rest of the outputs are low
					{IR_EN,A_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_CS} = 10'b0;
					
				end
			end
					
			else if (ADDR == 7'd66) begin
				PDR_EN = 1'b1; //Enabling A register
				
				if (IF)
					//Rest of the outputs are low
					{IR_EN,A_EN,B_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 12'b0;
					
				else begin
					RAM_OE = 1'b1; //enabling RAM output
								
					//Rest of the outputs are low
					{IR_EN,A_EN,B_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RDR_EN,RAM_CS} = 11'b0;
					
					end
			end
					
			else if (ADDR == 7'd67) begin
				PORT_EN = 1'b1; //Enable writing to Port Data Register
				
				if (IF)
					//Rest of the outputs are low
					{IR_EN,A_EN,B_EN,PDR_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 12'b0;
					
				else begin
					RAM_OE = 1'b1; //enabling RAM output
					RDR_EN = 1'b1; //Enable writing to RAM Data Register
								
					//Rest of the outputs are low
					{IR_EN,A_EN,B_EN,PDR_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RDR_EN,RAM_CS} = 10'b0;
				end
			end
			
			else begin
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 13'bx; //illegal address
						
			LOAD_FLAG = 1'b0; //resetting load flag
			end
						
		else if (STORE_FLAG) begin
			if (ADDR == 7'd67) begin
				PORT_RD = 1; //Enable reading Port Input Data
				//Rest of the outputs are low
				{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS} = 12'b0;
			end
				
			else if (ADDR >= 7'd32 || ADDR <= 7'd64) begin
			
			ALU_EN = 1'b1;
			ALU_OE = 1'b1;
			
			{IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,RAM_OE,RDR_EN,RAM_CS} = 11'b0;
			end
			
			else begin {IR_EN, A_EN, B_EN, PDR_EN, PORT_EN, PORT_RD, PC_EN, PC_LOAD,ALU_EN, ALU_OE, RAM_OE, RDR_EN, RAM_CS} = 13'bx; //illegal address
			
			STORE_FLAG = 1'b0; //resetting store flag;
			end
			end
			
		else begin 
			LOAD_FLAG = 0;
			STORE_FLAG = 0;
		end
		end
		
	UPDATE: begin
		if (BRANCH_FLAG) begin
			PC_EN = 1'b1; //Enable updating Program Counter Register
			PC_LOAD = 1'b1; //Enable parallel load of PC
			
			//clearing all enables set in previous cycles
			{IR_EN, A_EN, B_EN, PDR_EN, PORT_EN, PORT_RD,ALU_EN, ALU_OE, RAM_OE, RDR_EN, RAM_CS} = 11'b0;
		
			BRANCH_FLAG = 1'b0;
			end
			
		else begin
			PC_EN = 1'b1; //Enable updating Program Counter Register
			RAM_OE = 1'b1; //Enable RAM output
			
			//clearing all enables set in previous cycles
			{IR_EN, A_EN, B_EN, PDR_EN, PORT_EN, PORT_RD,ALU_EN, ALU_OE, PC_LOAD, RDR_EN, RAM_CS} = 11'b0;
			end
		end
	
	default: begin
		IR_EN = IR_EN;
		A_EN = A_EN;
		B_EN = B_EN;
		PDR_EN = PDR_EN;
		PORT_EN = PORT_EN;
		PORT_RD = PORT_RD;
		PC_EN = PC_EN;
		PC_LOAD = PC_LOAD;
		ALU_EN = ALU_EN;
		ALU_OE = ALU_OE;
		RDR_EN = RDR_EN;
		RAM_OE = RAM_OE;
		RAM_CS = RAM_CS;
		
		end
	
	endcase
	endmodule



















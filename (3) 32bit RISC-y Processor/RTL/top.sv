module RISCY(CLK,RST,IO);
import globe::*;
STATES PHASE;
input CLK, RST;
inout [7:0] IO;
wire IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS;
wire RESET,DIRECTION;
wire [4:0] ROM_ADDR;
wire [31:0] INSTR, ROM_OUT;
wire [7:0] RAM_OUT, RAM_DATA, PORT_DATA, DATA, PORT_DATA_OUT, ALU_OUT, A, B;
wire OF, SF, ZF, CF;

AASD AASD(RESET, CLK, RST);
COUNTER #(5) PC (ROM_ADDR, CLK, RESET, PC_EN, PC_LOAD, INSTR[24:20]);
ROM #(32,5) ROM (ROM_OUT, ROM_ADDR, 1'b1, 1'b0);
REG_WITHOUT_RESET #(32) MEMORY_INSTRUCTION_REG(INSTR,ROM_OUT, IR_EN, CLK);
REG_FILE #(8,5) RAM(RAM_OUT,INSTR[4:0],RAM_OE,CLK,RAM_CS);
SCALE_MUX #(8) MUX (INSTR[7:0],RAM_DATA,RAM_OE,DATA);
REG_WITHOUT_RESET #(8) REG_A (A,INSTR[7:0],A_EN,CLK);
REG_WITHOUT_RESET #(8) REG_B (B,INSTR[7:0],B_EN,CLK);
ALU ALU(CLK, ALU_EN, ALU_OE, INSTR[31:28], A, B,ALU_OUT, CF, OF, SF, ZF);
BUFFER ALU_BUF (RAM_OUT, ALU_OUT, ALU_OE);

PORT_DIR_REG PDR (DIRECTION,INSTR[0],PDR_EN,CLK,RESET);
REG_WITHOUT_RESET #(8) PORT_DATA_REG (PORT_DATA,INSTR[7:0],PORT_EN,CLK);
BUFFER BUFFER1 (PORT_DATA_OUT, PORT_DATA, DIRECTION);
IOPORT #(8) IOPORT (IO, PORT_DATA_OUT, DIRECTION, PORT_RD);
BUFFER BUFFER2 (RAM_OUT, IO, PORT_RD);

PHASER PHASER (CLK, RST, 1'b0, PHASE);
SEQUENCE_CONTROLLER CONTROLLER (INSTR[26:20],INSTR[31:28],PHASE,CF,OF,SF,ZF,INSTR[27],IR_EN,A_EN,B_EN,PDR_EN,PORT_EN,PORT_RD,PC_EN,PC_LOAD,ALU_EN,ALU_OE,RAM_OE,RDR_EN,RAM_CS);

endmodule 
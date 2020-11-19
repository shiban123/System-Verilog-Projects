package globe;
typedef enum reg [1:0] {FETCH, DECODE, EXECUTE, UPDATE} STATES;

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

endpackage
module ir (
	iInstruction,
	oOpcode,
	oCDcode,  // only for BRA, opcode = 0001
	osrcType, // 0 for reg/mem, 1 for immediate
	odestType, // 0 for reg, 1 for immediate
	osrc1, 
	osrc2
);

input [31:0] iInstruction;
output [4:0] oOpcode, oCDcode;
output osrcType, odestType;
output [11:0] osrc1, osrc2;

assign oOpcode = iInstruction[31:28];
assign oCDcode = iInstruction[27:24];
assign osrcType = iInstruction[27];
assign odestType = iInstruction[26];
assign osrc1 = iInstruction[23:12];
assign osrc2 = iInstruction[11:0];

endmodule
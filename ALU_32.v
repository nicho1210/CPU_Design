module ALU_32 (
	iclock,
	in1,
	in2, 
	iop, 
	alucontrol,
	out, 
	oc, 
	oe, 
	op,
	oz,
	on,
	oPSR
);

parameter Bits = 12;
			 //inputBits = 12;
parameter Ops = 4;

parameter ADD = 4'b0100;
parameter MUL = 4'b0101;
parameter CMP = 4'b0110;
parameter SHF = 4'b0111;
parameter ROT = 4'b1000;

input iclock;
input [Bits-1:0] in1, in2;
input [Ops-1:0] iop;
output [Bits-1:0] out;
output [4:0] oPSR;

//Status Flags
output oc, oe, op, oz, on;'

reg [Bits:0] alu;

always @(posedge iclock)
begin
	case(iop)
		ADD:
			alu <= in1 + in2;
		MUL:
			alu <= in1 * in2;
		CMP:
			alu <= ~in1;
		SHF:
			alu <= in1 << 1;
		ROT:
		begin
			alu[Bits:1] <= in1 << 1;
			alu[0] <= in1[Bits-1];
		end
	endcase
end

assign oc = alu[Bits]; //carry
assign oe = ~alu[0];   //even
assign op = ^alu; //odd parity
assign oz = ~alu; //zero, 1's complement
assign on = alu[Bits - 1]; //negative

assign oPSR[0] = oc;
assign oPSR[1] = oe;
assign oPSR[2] = op;
assign oPSR[3] = oz;
assign oPSR[4] = on;

assign out = alu;

endmodule


			
			
			
			
			
			
			
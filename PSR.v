module PSR (
	iData,
	iClk,
	oPSR
);

parameter Bits = 12;

input [Bits:0] iData;
input iClk;
output [4:0]oPSR;

reg rc, re, rp, rz, rn;

always @(posedge iClk)
begin
	rc <= iData[Bits]; //carry
	re <= ~iData[0];   //even
	rp <= ^iData; //odd parity
	rz <= ~iData; //zero, 1's complement
	rn <= iData[Bits - 1]; //negative
end

assign oPSR[0] = rc;
assign oPSR[1] = re;
assign oPSR[2] = rp;
assign oPSR[3] = rz;
assign oPSR[4] = rn;


endmodule 
module pc (
	idata,
	iclk,
	opc
);

input iclk;
input idata;
output opc;

reg rpc = 0;

always @(posedge iclk)
begin
	rpc <= rpc + 1;
end

assign opc = rpc;

endmodule
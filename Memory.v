module Memory (
	iRamAddress,
	ipcAddress,
	iRamEnable, 
	iRamRW,
	iRamClk,
	iData,
	oData,
	oc, 
	oe, 
	op,
	oz,
	on,
	oPSR
);

input [11:0] iRamAddress;
input [11:0] ipcAddress;
input iRamEnable;
input iRamRW;
input iRamClk;

input [31:0] iData;
output [31:0] oData;
output [4:0] oPSR;

//Status Flags
output oc, oe, op, oz, on;

reg [31:0] oData;

reg [31:0] RAM_Data [1023:0];
reg [12:0] PSR_data;

/*
always @(posedge iRamClk)
begin

	case(iRamEnable)
		1'b1: RAM_Data[iRamAddress] <= iData; //write
		default: 
		begin
			oData = RAM_Data[iRamAddress]; //read
			PSR_data = oData[12:0];
		end
	endcase
	
end
*/

always @(ipcAddress)
begin
	//case(iRamEnable)
		//1'b1: RAM_Data[ipcAddress] <= iData; //write
		//default: 
		//begin
			//oData = RAM_Data[ipcAddress]; //read
			//PSR_data = oData[12:0];
		//end
	//endcase
	oData = RAM_Data[ipcAddress];
	
end

always @(iRamAddress)
begin

	case(iRamEnable)
		1'b1: RAM_Data[iRamAddress] <= iData; //write
		default: 
		begin
			oData = RAM_Data[iRamAddress]; //read
			PSR_data = oData[12:0];
		end
	endcase
	
end



assign oc = PSR_data[12]; //carry
assign oe = ~PSR_data[0];   //even
assign op = ^PSR_data; //odd parity
assign oz = ~PSR_data; //zero, 1's complement
assign on = PSR_data[12 - 1]; //negative

assign oPSR[0] = oc;
assign oPSR[1] = oe;
assign oPSR[2] = op;
assign oPSR[3] = oz;
assign oPSR[4] = on;

endmodule

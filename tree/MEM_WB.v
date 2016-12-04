module MEM_WB(
	WB_i,
	ReadData_i,
	mux8_i,
	immed_i,
	MemToReg_o,
	RegWrite_o,
	ReadData_o,
	mux8_o,	// connect this to Forwarding Unit
	immed_o
);

input	[1:0]	WB_i;
input	[4:0]	mux8_i;
input	[31:0]	ReadData_i, immed_i;

output			MemToReg_o, RegWrite_o;
output	[4:0]	mux8_o;
output	[31:0]	ReadData_o, immed_o;

assign			MemToReg_o = WB_i[0];
assign			RegWrite_o = WB_i[1];
assign			ReadData_o = ReadData_i;
assign 			immed_o = immed_i;

endmodule
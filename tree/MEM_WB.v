module MEM_WB(
	MemToReg_i,
	RegWrite_i,
	ReadData_i,
	mux8_i,
	immed_i,
	MemToReg_o,
	RegWrite_o,
	ReadData_o,
	mux8_o,	// connect this to Forwarding Unit
	immed_o
);

input			MemToReg_i, RegWrite_i;
input	[4:0]	mux8_i;
input	[31:0]	ReadData_i, immed_i;

output			MemToReg_o, RegWrite_o;
output	[4:0]	mux8_o;
output	[31:0]	ReadData_o, immed_o;

assign			MemToReg_o = MemToReg_i;
assign			RegWrite_o = RegWrite_i;
assign			ReadData_o = ReadData_i;
assign 			immed_o = immed_i;

endmodule
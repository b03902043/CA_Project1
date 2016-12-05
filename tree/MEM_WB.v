module MEM_WB(
	WB_i,
	ReadData_i,
	mux3_i,
	immed_i,
	WB_o,
	ReadData_o,
	mux3_o,	// connect this to Forwarding Unit
	immed_o
);

input	[1:0]	WB_i;
input	[4:0]	mux3_i;
input	[31:0]	ReadData_i, immed_i;

//output			MemToReg_o, RegWrite_o;
output	[1:0]	WB_o;
output	[4:0]	mux3_o;
output	[31:0]	ReadData_o, immed_o;

//assign			MemToReg_o = WB_i[0];
//assign			RegWrite_o = WB_i[1];
assign			WB_o = WB_i;
assign			ReadData_o = ReadData_i;
assign 			immed_o = immed_i;
assign			mux3_o = mux3_i;

endmodule
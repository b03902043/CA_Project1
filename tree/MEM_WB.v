module MEM_WB(
	clk_i,
	WB_i,
	ReadData_i,
	mux3_i,
	immed_i,
	WB_o,
	ReadData_o,
	mux3_o,	// connect this to Forwarding Unit
	immed_o
);

input			clk_i;
input	[1:0]	WB_i;
input	[4:0]	mux3_i;
input	[31:0]	ReadData_i, immed_i;

//output			MemToReg_o, RegWrite_o;
output reg	[1:0]	WB_o;
output reg	[4:0]	mux3_o;
output reg	[31:0]	ReadData_o, immed_o;

//assign			MemToReg_o = WB_i[0];
//assign			RegWrite_o = WB_i[1];


//assign			WB_o = WB_i;
//assign			ReadData_o = ReadData_i;
//assign 			immed_o = immed_i;
//assign			mux3_o = mux3_i;

always@(negedge clk_i)	begin
	WB_o <= WB_i;
	ReadData_o <= ReadData_i;
	immed_o <= immed_i;
	mux3_o <= mux3_i;
end

endmodule
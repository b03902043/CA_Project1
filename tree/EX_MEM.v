module EX_MEM(
	WB_i,
	ALUOut_i,
	mux7_i,
	mux8_i,
	MEM_i,
	WB_o,
	ALUOut_o,
	mux7_o,
	mux8_o,
	MemRead_o,
	MemWrite_o
);

// MemToReg_i, RegWrite_i => WB_i    ;    MemRead_i, MemWrite_i, => MEM_i
input	[1:0]	WB_i, MEM_i;	
// mux7_i = RT (Forwarding or not)
input	[31:0]	ALUOut_i, mux7_i;
//	registerRD(5)
input	[4:0]	mux8_i;

output	[1:0]	WB_o;
output	[31:0]	ALUOut_o, mux7_o;
output	[4:0]	mux8_o;
output			MemRead_o, MemWrite_o;

assign	WB_o = WB_i;
assign	ALUOut_o = ALUOut_i;
assign	mux7_o = mux7_i;
assign	mux8_o = mux8_i;
assign	MemRead_o = MEM_i[0];
assign	MemWrite_o = MEM_i[1];

endmodule
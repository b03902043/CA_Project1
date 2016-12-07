module EX_MEM(
	clk_i,
	WB_i,
	ALUOut_i,
	mux7_i,
	mux3_i,
	MEM_i,
	WB_o,
	ALUOut_o,
	mux7_o,
	mux3_o,
	MemRead_o,
	MemWrite_o
);

input			clk_i;
// MemToReg_i, RegWrite_i => WB_i    ;    MemRead_i, MemWrite_i, => MEM_i
input	[1:0]	WB_i, MEM_i;	
// mux7_i = RT (Forwarding or not)
input	[31:0]	ALUOut_i, mux7_i;
//	registerRD(5)
input	[4:0]	mux3_i;

output reg	[1:0]	WB_o;
output reg	[31:0]	ALUOut_o, mux7_o;
output reg	[4:0]	mux3_o;
output reg			MemRead_o, MemWrite_o;

//assign	WB_o = WB_i;
//assign	ALUOut_o = ALUOut_i;
//assign	mux7_o = mux7_i;
//assign	mux3_o = mux3_i;
//assign	MemRead_o = MEM_i[0];
//assign	MemWrite_o = MEM_i[1];

always@( posedge clk_i ) begin
	WB_o <= WB_i;
	ALUOut_o <= ALUOut_i;
	mux7_o <= mux7_i;
	mux3_o <= mux3_i;
	MemRead_o <= MEM_i[0];
	MemWrite_o <= MEM_i[1];
end

endmodule
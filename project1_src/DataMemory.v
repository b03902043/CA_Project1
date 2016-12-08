module DataMemory(
	clk_i,
	memRead_i,
	memWrite_i,
	ALUOut_i,
	WriteData_i,
	ReadData_o,
	memory_o
);

input			clk_i;
input 			memRead_i;
input			memWrite_i;
input	[31:0]		ALUOut_i;
input	[31:0]		WriteData_i;
output	[31:0]		ReadData_o;
output	[7:0]		memory_o;

reg	[7:0]		memory	[0:31];

assign 	memory_o = memory[0];
assign	ReadData_o = (memRead_i == 1)? memory[ALUOut_i]:32'b0;

always@ (posedge clk_i)	
begin
	if(memWrite_i)
		memory[ALUOut_i] <= WriteData_i;
	else;
end

endmodule

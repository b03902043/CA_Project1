module DataMemory(
	clk_i,
	memRead_i,
	memWrite_i,
	ALUOut_i,
	WriteData_i,
	ReadData_o
);

input			clk_i;
input 			memRead_i;
input			memWrite_i;
input	[31:0]		ALUOut_i;
input	[31:0]		WriteData_i;
output	[31:0]		ReadData_o;

reg	[7:0]		memory	[0:31];
reg	[31:0]		ReadData_o;


always@ (*)	
begin
	if(memWrite_i && clk_i)
		memory[ALUOut_i] <= WriteData_i;
	else if(memRead_i && ~clk_i)
		ReadData_o <= memory[ALUOut_i];
	else;
end

endmodule

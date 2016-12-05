module DataMemory(
	memRead_i,
	memWrite_i,
	ALUOut_i,
	WriteData_i,
	ReadData_o
);

input 			memRead_i;
input			memWrite_i;
input	[31:0]		ALUOut_i;
input	[31:0]		WriteData_i;
output	[31:0]		ReadData_o;

reg	[31:0]		memory	[0:31];
reg	[31:0]		ReadData_o;


always@ (*)	
begin
	if(memWrite_i)
		memory[ALUOut_i[15:0]] <= WriteData_i;
	else if(memRead_i)
		ReadData_o <= memory[ALUOut_i[15:0]];
	else;
end

endmodule

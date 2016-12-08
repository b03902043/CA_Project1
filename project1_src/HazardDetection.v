module HazardDetection
(
	IDEX_MemRead_i,
	IDEX_RegisterRt_i,
	instr_i,
	PCWrite_o,
	IFIDWrite_o,
	MUX8_o
);

input			IDEX_MemRead_i;
input		[4:0]	IDEX_RegisterRt_i;
input		[31:0]	instr_i;
output reg		PCWrite_o, IFIDWrite_o, MUX8_o;

always@(*)begin
	if(IDEX_MemRead_i && 
	   (IDEX_RegisterRt_i == instr_i[25:21] ||
            IDEX_RegisterRt_i == instr_i[20:16]))begin
		PCWrite_o <= 1'b1;
		IFIDWrite_o <= 1'b1;
		MUX8_o <= 1'b1;
	end
	else begin
		PCWrite_o <= 1'b0;
		IFIDWrite_o <= 1'b0;
		MUX8_o <= 1'b0;
	end
end

endmodule

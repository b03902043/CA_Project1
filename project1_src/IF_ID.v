module IF_ID
(
	clk_i,
	addr_i,
	instr_i,
	IFIDWrite_i,
	flush_i,
	addr_o,
	instr_o;
}

input	clk_i;
input	[31:0]	addr_i, instr_i;
input	IFIDWrite_i, flush_i;
output	[31:0]	addr_o, instr_o;

always@(negedge clk_i) begin
	if(flush_i == 1) begin
		addr_o <= addr_i;
		instr_o <= 32'b0;
	end
	else if(IFIDWrite == 0) begin
		addr_o <= addr_i;
		instr_o <= instr_i;
	end
	else begin
		//stall
	end
endmodule

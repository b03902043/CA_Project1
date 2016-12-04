module	unit_test;

	reg		memRead, memWrite, EX_MEM_regWrite_i, MEM_WB_regWrite_i, MemToReg_i, RegWrite_i;
	reg 	[1:0]	WB_i, MEM_i;
	reg		[31:0]	ALUOut, mux7;
	reg		[4:0]	mux8, ID_EX_RegRs, ID_EX_RegRt, EX_MEM_RegRd_i, MEM_WB_RegRd_i;

	wire 	memRead_o, memWrite_o, MemToReg_o, RegWrite_o;
	wire 	[1:0]	ForwardA_o, ForwardB_o, WB_o;
	wire 	[31:0]	ALUOut_o, mux7_o;
	wire 	[4:0]	mux8_o;

	//instantiate device under test
	EX_MEM	em(WB_i, ALUOut, mux7, mux8, MEM_i, WB_o, ALUOut_o, mux7_o, mux8_o, memRead_o, memWrite_o);
	ForwardingUnit	fu(ID_EX_RegRs, ID_EX_RegRt, WB_o[1], em.mux8_o, MEM_WB_regWrite_i, MEM_WB_RegRd_i, ForwardA_o, ForwardB_o);

	//apply inputs one at a time
	initial  begin
		$dumpfile("mytest.vcd");
		$dumpvars;
		//MemToReg_i = 1;	RegWrite_i = 1;
		WB_i = 2'b11;

		ALUOut = 32'd0;	mux7 = 32'd155;	mux8 = 5'b10110;	
		//memRead = 1;	memWrite = 0;
		MEM_i = 2'b01;	// Note: reverse write  MEM_i[0] = 1 = memRead

		ID_EX_RegRs = 5'b10101;	ID_EX_RegRt = 5'b10110;	MEM_WB_RegRd_i = 5'b11111;	MEM_WB_regWrite_i = 1;
//		#100 A=1'b1; B=1'b1; C=1'b1;
	end

	initial #200 $finish;

endmodule
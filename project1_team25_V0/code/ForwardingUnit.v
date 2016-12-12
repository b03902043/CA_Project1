module ForwardingUnit(
	ID_EX_RegRs,
	ID_EX_RegRt,
	EX_MEM_regWrite_i,
	EX_MEM_RegRd_i,
	MEM_WB_regWrite_i,
	MEM_WB_RegRd_i,
	ForwardA_o,
	ForwardB_o
);

// UpperCase Reg Means Register, LowerCase reg Means Control Signal

input	[4:0]	ID_EX_RegRs, ID_EX_RegRt, EX_MEM_RegRd_i, MEM_WB_RegRd_i;
input			EX_MEM_regWrite_i, MEM_WB_regWrite_i;
output	[1:0]	ForwardA_o, ForwardB_o;

reg 	[1:0]	fa_temp, fb_temp;

assign			ForwardA_o = fa_temp;
assign			ForwardB_o = fb_temp;

always@	(*)	begin
	// init
	fa_temp = 0;
	fb_temp = 0;
	
	// for EX Hazard
	if( EX_MEM_regWrite_i && EX_MEM_RegRd_i != 0 )	begin
		if( EX_MEM_RegRd_i == ID_EX_RegRs )	begin
			fa_temp = 2'b10;
		end if( EX_MEM_RegRd_i == ID_EX_RegRt )	begin
			fb_temp = 2'b10;
		end
	end

	// for MEM Hazard
	if( MEM_WB_regWrite_i && MEM_WB_RegRd_i != 0 )	begin
		if( MEM_WB_RegRd_i == ID_EX_RegRs )	begin
			fa_temp = 2'b01;
		end if( MEM_WB_RegRd_i == ID_EX_RegRt )	begin
			fb_temp = 2'b01;
		end
	end
end

endmodule
module(
	clk_i,
	instr1115_i,
	instr1620_MUX_i,
	instr1620_FW_i,
	instr2125_i,
	sign_extend_i,
	RS_data_i,
	RT_data_i,
	ctrl_WB_i,
	ctrl_M_i,
	ctrl_EX_i,
	instr1115_o,
	instr1620_MUX_o,
	instr1620_FW_o,
	instr2125_o,
	sign_extend_o,
	RS_data_o,
	RT_data_o,
	ctrl_WB_o,
	ctrl_M_o,
	ALUSrc_o,
	ALUOp_o,
	RegDst_o
);

input		clk_i;
input	[4:0]	instr1115_i, instr1620_MUX_i, instr1620_FW_i, instr2125_i;
input	[31:0]	sign_extend_i, RS_data_i, RT_data_i;
input	[1:0]	ctrl_WB_i;
input	[1:0]	ctrl_M_i;
input	[3:0]	ctrl_EX_i;
output	[4:0]	instr1115_o, instr1620_MUX_o, instr1620_FW_o, instr2125_o;
output	[31:0]	sign_extend_o, RS_data_o, RT_data_o;
output	[1:0]	ctrl_WB_o;
output	[1:0]	ctrl_M_o;
output	[1:0]	ALUOp_o;
output		ALUSrc_o, RegDst_o;

always@(negedge clk_i) begin
	instr1115_o <= instr1115_i;
	instr1620_MUX_o <= instr1620_MUX_i;
	instr1620_FW_o <= instr1620_FW_i;
	instr2125_o <= instr2125_i;
	sign_extend_o <= sign_extend_i;
	RS_data_o <= RS_data_i;
	RT_data_o <= RT_data_i;
	ctrl_WB_o <= ctrl_WB_i;
	RegDst_o <= ctrl_EX_i[0];
	ALUOp_o <= ctrl_EX_i[2:1];
	ALUSrc_o <= ctrl_EX_i[3];
end

module CPU
(
    clk_i,
    start_i
);

// Ports
input               clk_i;
input               start_i;


wire    [31:0]      inst_addr, inst;
// SP's section
wire                branch_flag, jump_flag, flush, IFIDWrite, PCWrite, HazardMUX_8;
wire    [1:0]       EX_M, EX_WB;
wire    [4:0]       EX_Rt, mux3EXMEM;
wire    [31:0]      ID_addr, EX_extend, ID_rs, ID_rt, mux1Out, mux6ALU, mux4ALU, IF_inst, ALUresult;
wire                Eq_flag;
wire    [7:0]       MUX8_data;

// tree's section
wire                branch_flagT, memWrite, memRead;
wire    [1:0]       WB_memState, WB_WBState;
wire    [4:0]       MEM_mux3, WB_mux3, IERt, IERs;
wire    [7:0]       cm8;
wire	[31:0]	    mux7Write;
// BOSS's section
wire    [31:0]      extended, MEM_ALUOut, Add_pc_o, MUX_5Out, MUX_7Out, JUMP_Addr, am1;

assign  JUMP_Addr[31:28] = mux1Out[31:28];
assign  Eq_flag = (ID_rs == ID_rt);
assign  branch_flag = branch_flagT & Eq_flag;
assign  flush = jump_flag | branch_flag;

Control Control(
    .data_in    (inst),
    .data_out   (cm8),
    .branch     (branch_flagT),
    .jump       (jump_flag)
);

Adder Add_PC(
    .data1_in   (inst_addr),
    .data2_in   (32'd4),
    .data_o     (Add_pc_o)
);

Adder ADD(
    .data1_in   (shiftLeft2_32.data_o),
    .data2_in   (ID_addr),
    .data_o     (am1)
);

shiftLeft2_32 shiftLeft2_32(
    .data_i    (extended),
    .data_o    (ADD.data1_in)
);

shiftLeft2_26 shiftLeft2_26(
    .data_i    (inst[25:0]),
    .data_o    (JUMP_Addr[27:0])
);

PC PC(
    .clk_i      (clk_i),
    .start_i    (start_i),
    .PCWrite_i  (PCWrite),
    .pc_i       (MUX_2.data_o),
    .pc_o       (inst_addr)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (inst_addr), 
    .instr_o    (IF_inst)
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (inst[25:21]),
    .RTaddr_i   (inst[20:16]),
    .RDaddr_i   (WB_mux3), 
    .RDdata_i   (MUX_5Out),
    .RegWrite_i (WB_WBState[1]), 
    .RSdata_o   (ID_rs), 
    .RTdata_o   (ID_rt) 
);

MUX32 MUX_1(
    .data1_i    (Add_pc_o),
    .data2_i    (am1),
    .select_i   (branch_flag),
    .data_o     (mux1Out)
);

MUX32 MUX_2(
    .data1_i    (mux1Out),
    .data2_i    (JUMP_Addr),
    .select_i   (jump_flag),
    .data_o     (PC.pc_i)
);

MUX5 MUX_3(
    .data1_i    (EX_Rt),
    .data2_i    (ID_EX.instr1115_o),
    .select_i   (ID_EX.RegDst_o),
    .data_o     (mux3EXMEM)
);

MUX32 MUX_4(
    .data1_i    (MUX_7Out),   // 0
    .data2_i    (EX_extend),    // 1
    .select_i   (ID_EX.ALUSrc_o),
    .data_o     (mux4ALU)
);

MUX32 MUX_5(
    .data1_i    (MEM_WB.immed_o),
    .data2_i    (MEM_WB.ReadData_o),
    .select_i   (WB_WBState[0]),
    .data_o     (MUX_5Out)
);

MUX3 MUX_6(
    .data1_i    (ID_EX.RS_data_o), // 00
    .data2_i    (MUX_5Out),        // 01
    .data3_i    (MEM_ALUOut),      // 10
    .select_i   (ForwardingUnit.ForwardA_o),
    .data_o     (mux6ALU)
);

MUX3 MUX_7(
    .data1_i    (ID_EX.RT_data_o), // 00
    .data2_i    (MUX_5Out),        // 01
    .data3_i    (MEM_ALUOut),      // 10
    .select_i   (ForwardingUnit.ForwardB_o),
    .data_o     (MUX_7Out)
);

MUX8 MUX_8(
    .data1_i    (cm8),
    .data2_i    (8'b0),
    .select_i   (HazardMUX_8),
    .data_o     (MUX8_data)
);

Sign_Extend Sign_Extend(
    .data_i     (inst[15:0]),
    .data_o     (extended)
);
  
ALU ALU(
    .data1_i    (mux6ALU),        //上面那支
    .data2_i    (mux4ALU),        //下面那支
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
    .data_o     (ALUresult)
);

ALU_Control ALU_Control(
    .funct_i    (EX_extend[5:0]),
    .ALUOp_i    (ID_EX.ALUOp_o),
    .ALUCtrl_o  (ALU.ALUCtrl_i)
);

HazardDetection HazardDetection(
	.IDEX_MemRead_i     (EX_M[1]),
	.IDEX_RegisterRt_i  (EX_Rt),
	.instr_i            (inst),
	.PCWrite_o          (PCWrite),
	.IFIDWrite_o        (IFIDWrite),
	.MUX8_o             (HazardMUX_8)
);

IF_ID IF_ID(
	.clk_i          (clk_i),
	.addr_i         (Add_pc_o),
	.instr_i        (IF_inst),
	.IFIDWrite_i    (IFIDWrite),
	.flush_i        (flush),
	.addr_o         (ID_addr),
	.instr_o        (inst)
);

ID_EX ID_EX(
	.clk_i              (clk_i),
	.instr1115_i        (inst[15:11]),
	.instr1620_MUX_i    (inst[20:16]),
	.instr1620_FW_i     (inst[20:16]),
	.instr2125_i        (inst[25:21]),
	.sign_extend_i      (extended),
	.RS_data_i          (ID_rs),
	.RT_data_i          (ID_rt),
	.ctrl_WB_i          (MUX8_data[7:6]),
	.ctrl_M_i           (MUX8_data[5:4]),
	.ctrl_EX_i          (MUX8_data[3:0]),
	.instr1115_o        (MUX_3.data2_i),
	.instr1620_MUX_o    (EX_Rt),
	.instr1620_FW_o     (IERt),
	.instr2125_o        (IERs),
	.sign_extend_o      (EX_extend),
	.RS_data_o          (MUX_6.data1_i),
	.RT_data_o          (MUX_7.data1_i),
	.ctrl_WB_o          (EX_WB),
	.ctrl_M_o           (EX_M),
	.ALUSrc_o           (MUX_4.select_i),
	.ALUOp_o            (ALU_Control.ALUOp_i),
	.RegDst_o           (MUX_3.select_i)
);

EX_MEM EX_MEM(
    .clk_i       (clk_i),
	.WB_i        (EX_WB),
	.ALUOut_i    (ALUresult),
	.mux7_i      (MUX_7Out),
	.mux3_i      (mux3EXMEM),
	.MEM_i       (EX_M),
	.WB_o        (WB_memState),
	.ALUOut_o    (MEM_ALUOut),        // connect MEM_ALUOut to mux6 , mux7 's input
	.mux7_o      (mux7Write),
	.mux3_o      (MEM_mux3),
	.MemRead_o   (memRead),
	.MemWrite_o  (memWrite)
);

MEM_WB MEM_WB(
    .clk_i       (clk_i),
	.WB_i        (WB_memState),
	.ReadData_i  (DataMemory.ReadData_o),
	.mux3_i      (MEM_mux3),
	.immed_i     (MEM_ALUOut),
	.WB_o        (WB_WBState),
	.ReadData_o  (MUX_5.data2_i),
	.mux3_o      (WB_mux3),	            // connect this to Forwarding Unit and xxx
	.immed_o     (MUX_5.data1_i)
);

DataMemory DataMemory(
    .clk_i         (clk_i),
    .memRead_i     (memRead),
    .memWrite_i    (memWrite),
    .ALUOut_i      (MEM_ALUOut),    // Address
    .WriteData_i   (mux7Write),              // 
    .ReadData_o    (MEM_WB.ReadData_i),    // 32bit
    .memory_o	   ()
);

ForwardingUnit ForwardingUnit(
	.ID_EX_RegRs         (IERs),
	.ID_EX_RegRt         (IERt),
	.EX_MEM_regWrite_i   (WB_memState[1]),
	.EX_MEM_RegRd_i      (MEM_mux3),
	.MEM_WB_regWrite_i   (WB_WBState[1]),
	.MEM_WB_RegRd_i      (WB_mux3),
	.ForwardA_o          (MUX_6.select_i),
	.ForwardB_o          (MUX_7.select_i)
);

endmodule
